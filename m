Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbUCYOhB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbUCYOeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:34:31 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:56840 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263172AbUCYOc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:32:27 -0500
Date: Thu, 25 Mar 2004 07:32:23 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: linux-raid@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Re: EMD Architecture Discussion
Message-ID: <889520000.1080225143@aslan.btc.adaptec.com>
In-Reply-To: <884890000.1080224995@aslan.btc.adaptec.com>
References: <884890000.1080224995@aslan.btc.adaptec.com>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has been mentioned on the lists that the best way to get the EMD
changes reviewed is to break them up into smaller chunks that can
be discussed individually.  This email is the first in a series
that attempts to do that.

There have also been many requests to see diffs instead of whole
files to aid in the review process.  Patches converting the existing
2.6 MD to EMD are now available here:

http://people.freebsd.org/~gibbs/linux/SRC/emd-2.6-20040425-diffs.gz

These are meant to help illustrate the changes, not as a formal
proposal for immediate inclusion into the 2.6 kernel.  Considering
the many changes in EMD, the fact that it is not yet at feature
parity with MD (no RAID5/6 or SB metadata support), and based on
the input from many in the Linux community, I will be generating
another patch set that creates EMD as a stand alone entity.  This
should allow experimentation with EMD while it is enhanced and
hopefully merged with MD.

Perhaps the largest structural change in EMD is to the data
structures used to represent array topology and state.  The
motivation behind these changes are:

	o Move attributes common to "leaf" (e.g. rdev) and
	  "array" objects into a single structure.
	o Leverage common code for most operations on
	  these objects.
	o Reduce the complexity of testing and manipulating
	  array or member state.
	o Allow RAID personalities to handle members that are
	  array objects.

The core of this change is the introduction of the mdk_member_t type:

struct mdk_member_s
{               
        spinlock_t              member_lock;    /* Protection of all fields */
        mdk_mtype_t             type;
        mdk_msubtype_t          subtype;
        mdu_mstate_t            state;
       
        sector_t                total_size;
        sector_t                data_size;
        sector_t                data_offset;

        mdk_member_t            *parent; 
        struct list_head        child_set;      /* Children of the member */
        u_int                   child_set_gencount;
        struct list_head        peer_links;     /* member of the same parent */
        mdk_personality_t       *pers;
        mdk_metapersonality_t   *metapers;

        void                    *metadata_private;
        void                    *pers_private;
        void                    *parent_pers_private;
       
        int                     priority;
        atomic_t                refcount;
        void                    (*destructor)(mdk_member_t *);
        char                    name[BDEVNAME_SIZE];
}

With few exceptions, EMD is able to manage all of its state in terms
of this one object.  To illustrate this, here is a typical internal
EMD topology rooted at the "toplevel_arrays" mdk_member_t structure:

toplevel_arrays
   |
   +->child_set
         |
         +->EMD0--->child_set-->sda-->peer_links-->sdb
         |
         +->EMD1--->child_set-->sdc-->peer_links-->sdd
         |
         +->EMD2--->child_set-->EMDX-->peer_links-->EMDY
                                  |                  |
                                  |                  +-->child_set ...
                                  |
                                  +-->child_set-->sde-->peer_links-->sdf

While the EMDXs are "mddev" structures and the sdXs are "rdev"
structures, both contain a member object.  At any level, the children
of that level are traversed the same way regardless of their
containing type (ITERATE_CHILDREN).  This allows the topology to
be nested transparently to any depth.

Children are sorted in their parent's child_set based on the "priority"
field, lowest to highest.  For members of an array, the priority field
indicates the "component index" of the member.  For top-level arrays,
the priority is used to determine the order of assignment for arrays
that do not have a preferred minor or whose preferred minor is already
claimed.

The entire topology is reference counted.  Member containing objects
are created with a sentinel refcount of 1.  Children hold refcounts
on their parents.  Each I/O operation on a member holds a reference
to that member.  The sentinel refcount ensures that objects are not
deleted prematurely.  To teardown a portion of the topology, a
depth-first "broadcast" operation is performed to drop the sentinel
refcount.  Similarly, when a member is failed, its sentinel refcount
is removed.  Once all I/O on that member has completed, its
refcount will drop to zero and it will be removed.  One of the
side-effects of this strategy is that there is no need to "hot
remove" a failed disk from a configuration.  The disk is removed
once failed and idle.

The basic locking rules for members are:

	o The member_lock must be held to traverse the child_set of
	  a member.
	o The member_lock of a child's parent must be held while
	  gaining a reference to the child.
	o The member_lock of a child's parent must be held while
	  dropping its sentinel reference count.
	o The member_lock must be held to change any state in the
	  member.
	o The member_lock must be held to ensure the stability of
	  the "state" field. 

The last rule mostly applies to meta-data modules that require some
certainty in the member's current state.  In the I/O path, we do
not take the lock, allowing the state to race.  We could not close
this race if we wanted to anyway, and trying too hard increases the
cost of doing I/O.  Consider that a member disk failure is only
visible once our I/O completion handler is executed.  This means
that we may schedule several I/Os without seeing that a member has
failed.  So, we must be robust in the face of not knowing that a
member has failed.  The only race of concern is that of having the
sentinel refcount on a member dropped just before an I/O operation
adds a reference.  We don't want one code path to attempt to destroy
the object just as the I/O path is trying to make use of it.  This
is where the 3rd rule above comes into play.  The code dropping the
sentinel reference must transition the object to a state that will
prevent users from taking new references, and release the sentinel
refcount while holding any parent's lock.  Since the I/O path also
holds the parent lock for any member it is considering for I/O, it
is guaranteed to be able to safely take a reference on any object
in the parent's list that it sees in a non-failed state.

It should be noted that "dropping the sentinel refcount" does not
mean that the refcount is transitioning from 1 to 0 with that drop.
The rule applies to the code that is losing a reference on the
object such that the refcount will eventually fall to 0.

While some RAID personalities can be implemented efficiently by
traversing the child set to select members for I/O, more complicated
transforms may benefit by using a different data structure.  To
support these methods, the child_set_gencount field is incremented
any time the membership of a child_set is changed.  A transform
using its own data structure to access members must verify that the
child_set_gencount is the same as a privately held version of the
gencount recorded the last time its data structures were updated.
Since the child_set is only stable while the member_lock is held,
the member_lock must be held while comparing the gencount as well
as referencing members by an alternate method.  If the gencount
check fails, a slow path, that updates the alternate member mapping,
must be executed before starting the I/O.

Object state has been consolidated into one field, the state field:

enum mdu_mstate_e
{
	MDU_MSTATE_UNKNOWN	  = 0x00,
	MDU_MSTATE_OPTIMAL	  = 0x01,
	MDU_MSTATE_DEGRADED	  = 0x02,
	MDU_MSTATE_FAILED	  = 0x04,/* No increments to refcount allowed.*/
	MDU_MSTATE_TEARDOWN	  = 0x08,
	MDU_MSTATE_MODIFIER_MASK  = 0xF0,
	MDU_MSTATE_REBUILD_TARGET = 0x10,
	MDU_MSTATE_INITIALIZING	  = 0x20
};

States are kept as individual bits so that most state tests can
be accomplished with simple mask and compare operations.  For
instance, a read operation is allowed on any optimal or degraded
member that is not a rebuild target or needs initialization before
access:

># define MDU_MSTATE_READABLE(state)                                      \
    (((state) & ~(MDU_MSTATE_OPTIMAL|MDU_MSTATE_DEGRADED)) == 0)

(RAID1's version of this macro also allows reads to rebuild targets when
 the I/O is below the current sync checkpoint).

A writable member is readable or a rebuild target:

># define MDU_MSTATE_WRITABLE(state)                                      \
    (((state) &                                                         \
     ~(MDU_MSTATE_OPTIMAL|MDU_MSTATE_DEGRADED|MDU_MSTATE_REBUILD_TARGET)) == 0)

Other than the "gross" state in this field, EMD does not attempt to cache
state.  For example, the number of currently optimal devices in an array
set is not stored in any field.  When a member's state changes, the meta-data
module will transition the array's state as necessary - perhaps after
traversing the list of all members.  These state changes occur "rarely"
and so are not worth optimizing and thus complicating how member state is
determined.

I will review other portions of the design in future emails.

--
Justin

