Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275320AbRIZQts>; Wed, 26 Sep 2001 12:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275322AbRIZQti>; Wed, 26 Sep 2001 12:49:38 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:48118 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S275320AbRIZQtb>; Wed, 26 Sep 2001 12:49:31 -0400
Date: Wed, 26 Sep 2001 17:49:43 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Andrew Morton <andrewm@uow.edu.au>, Stephen Tweedie <sct@redhat.com>
Subject: Re: Linux-2.4.10 + ext3
Message-ID: <20010926174943.W3437@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <1001280620.3540.33.camel@gromit.house> <9om4ed$1hv$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9om4ed$1hv$1@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Sep 24, 2001 at 02:06:05AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 24, 2001 at 02:06:05AM +0000, Linus Torvalds wrote:

> We'll merge ext3 soon enough.. As RH seems to start using it more and
> more, there's more reason to merge it into the standard kernel too.

I was expecting to have to merge into 2.5 first and back-port if
necessary, but either way, it's worthwhile talking about what is
needed for the merge.

The core ext3 code has basically two extensions to the core kernel;
the rest is modular.  

The first change is minor, but from a cleanliness point of view
perhaps the one more open to debate: ext3 currently adds a task
struct field to indicate if the task is already running an ext3
transaction.  (It's a void * but I'll be cleaning that up to be a
struct super_block *).

ext3 needs to remain transactional even when making recursive calls
into the filesystem, and ext3 implements quotas, which are quite
capable of recursing into the fs if we end up hitting the VM at the
wrong moment.  Such recursions have to be handled very, very
carefully: a legal recursion within one filesystem is valid, but
recursions between filesystems absolutely must be avoided, as this can
lead to deadlock.  

And there are recursions we just can't get rid of --- an inode delete
ends up deallocating the inode on disk and updating the dquot (which
does a dqput, which writes the quota entry using the normal VFS API),
and we _have_ to make that quota-file write a nested transaction if we
want quotas to be atomic with respect to journal recovery.  Short of
adding a new context parameter to be passed all the way through the
quota and VM layers wherever this sort of recursion is possible, we
need to attach that context to the task.  (Without a task struct
field, though, we can still hash outstanding transaction handles by
pid for fast lookup.)


The second set of changes includes a couple of  places where the
existing VFS isn't quite intelligent enough for ext3, and where we
want to add a little extra processing.  Replacing the existing
processing is possible, but ext3 still looks a lot like ext2 --- it
has page->buffers, and those buffers can live on the normal writeback
lists, for example --- so replacing the existing address_space ops
wholesale ends up forcing ext3 to reproduce huge amounts of code, and
we'd still be short of a few desired hooks.

Right now the areas trapped by ext3 include:

try_to_free_buffers: 
	Replace with a generic try_to_release_page, which allows other
	metadata associate with the page (or its buffers) to be
	released, rather than being limited to page->buffers cleanup.

block_flushpage:
	We might be trying to delete a page which was written in a
	previous transaction, and which is still in the process of 
	being written to disk as part of background commit.  We 
	can't just throw away the buffer_heads if they are still
	being written that way.

(The other place ext3 used to add to the address_space code was to
balance every prepare_write with a commit_write, but the current
kernel does that for us anyway now.)

Both of these are used by ext3 because of its support for data
journaling (in which all data writes are first written atomically to
the journal), and data ordering (in which data writes get flushed to
disk as normal, but must be pushed out before the transaction which
wrote the data can commit).  The tying of data blocks to background
commit means that we simply can't be as free about discarding buffers
as the normal page->buffers management code would like to be.


ext3 also requires that we fix the problem we talked about before in
which a page fault executing in parallel with a truncate can leave a
stranded, anonymous page mapped into the mmap area.  This particular
problem is much worse in ext3 than in ext2 precisely because of the
block_flushpage change --- deleted pages often have to be left behind
for further processing as part of a background commit, and the
stranded-page scenario is much more likely to lead to a bug 
if block_flushpage is unable to remove the page from the LRU lists,
and some of the ext3 stress tests basically can't complete without
that bug fixed.

Cheers,
 Stephen
