Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVD1DmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVD1DmS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 23:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVD1DmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 23:42:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34266 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261876AbVD1DmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 23:42:07 -0400
Date: Thu, 28 Apr 2005 11:45:50 +0800
From: David Teigland <teigland@redhat.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1a/7] dlm: core locking
Message-ID: <20050428034550.GA10628@redhat.com>
References: <20050425165705.GA11938@redhat.com> <20050427214136.GC938@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427214136.GC938@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 02:41:36PM -0700, Mark Fasheh wrote:

> > +#define DLM_LVB_LEN            (32)
> Why so small? In OCFS2 land, a nice healthy 64 bytes helps us fit most of
> our important inode bits, thus ensuring that we don't have to go to disk to
> update our metadata in some cases :)

We were questioned for 32 being unnecessarily large when we started, which
seems to make a case for it being configurable.


> > + * DLM_LKF_EXPEDITE
> > + *
> > + * Used only with new requests for NL mode locks.  Tells the lock manager
> > + * to grant the lock, ignoring other locks in convert and wait queues.

> What's happens to non DLM_LKF_EXPEDITE NL mode requests? It seems that
> an new NL mode lock should always be immediately be put on the grant
> queue...

A comment in _can_be_granted() quotes the VMS rule:

"By default, a new request is immediately granted only if all three of the
following conditions are satisfied when the request is issued:

- The queue of ungranted conversion requests for the resoure is empty.
- The queue of ungranted new requests for the resource is empty.
- The mode of the new request is compatible with the most
  restrictive mode of all granted locks on the resource."

Which means without EXPEDITE it could go on the waiting queue.  I suspect
EXPEDITE was invented because most people want NL requests to work as you
suggest, despite the rules.


> Where's the LKM_LOCAL equivalent? What happens a dlm user wants to create a
> lock on a resource it knows to be unique in the cluster (think file creation
> for a cfs)? Does it have to hit the network for a resource lookup on those
> locks?
> 
> Perhaps I should explain how this is interpreted in the OCFS2 dlm: When
> LKM_LOCAL is provided with a request for a new lock, the normal master
> lookup process is skipped and the resource is immediately created and
> mastered to the local node. Obviously this requires that users be careful
> not to create duplicate resources in the cluster. Any future requests for
> the lock from other nodes go through the master discovery process and will
> find it on the originating node.
> 
> We explicitly do not support LKM_FINDLOCAL - the notion of "local only"
> lookups does not apply as the resource is only considered to have been
> created locally and explicitly *not* hidden from the rest of the cluster.
> 
> >From a light skimming of dir.c (specifically dlm_dir_name2nodeid), I have a
> hunch that our methods for determing a resource master are fundamentally
> different, which would make implementation of LKM_LOCAL (at least as I have
> described it) on your side, difficult.

Interesting, I was reading about this recently and wondered if people
really used it.  I figured parent/child locks were probably a more common
way to get similar benefits.

Just to clarify, though:  when the LOCAL resource is immediately created
and mastered locally, there must be a resource directory entry added for
it, right?  For us, the resource directory entry is added as part of a new
master lookup (which is being skipped).  If you don't add a directory
entry, how does another node that later wants to lock the same resource
(without LOCAL) discover who the master is?

If I understand LOCAL correctly, it should be simple for us to do.  We'd
still have a LOCAL request _send_ the lookup to create the directory
entry, but we'd simply not wait for the reply.  We'd assume, based on
LOCAL, that the lookup result indicates we're the master.

Some people don't use a resource directory, and maybe that's why
dlm_dir_name2nodeid() doesn't look familiar?  That function determines the
directory node for a resource, not the master node.  The nodeid returned
from that function is where we send the master lookup, and the lookup
reply says where we send the lock request.

[We'll be adding a simple config option to change this so you can operate
without a resource directory in which case there's never a master lookup
to do.  The downside is that the first node to request a lock on a
resource would no longer always be the master of it.]


> > +static struct list_head		ast_queue;
> > +static struct semaphore		ast_queue_lock;

> Why a semaphore here? On quick inspection I'm not seeing much more than list
> operations being protected by ast_queue_lock... A spinlock might be more
> appropriate.

You're right, thanks.
Dave

