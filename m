Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVD0VnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVD0VnB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 17:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVD0VnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 17:43:01 -0400
Received: from rgminet01.oracle.com ([148.87.122.30]:45354 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S262040AbVD0Vl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 17:41:59 -0400
Date: Wed, 27 Apr 2005 14:41:36 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1a/7] dlm: core locking
Message-ID: <20050427214136.GC938@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050425165705.GA11938@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425165705.GA11938@redhat.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 12:57:05AM +0800, David Teigland wrote:
> [Apologies, patch 1 was too large on its own.]
> 
> The core dlm functions.  Processes dlm_lock() and dlm_unlock() requests.
> Creates lockspaces which give applications separate contexts/namespaces in
> which to do their locking.  Manages locks on resources' grant/convert/wait
> queues.  Sends and receives high level locking operations between nodes.
> Delivers completion and blocking callbacks (ast's) to lock holders.
> Manages the distributed directory that tracks the current master node for
> each resource.
Just a couple comments here, more will come as time permits. I know you
consider cluster file systems to be "obscure" apps, so be warned as that is
my current bias ;)

<snip>

> +/*
> + * Size in bytes of Lock Value Block
> + */
> +
> +#define DLM_LVB_LEN            (32)
Why so small? In OCFS2 land, a nice healthy 64 bytes helps us fit most of
our important inode bits, thus ensuring that we don't have to go to disk to
update our metadata in some cases :)

<snip>

> + * DLM_LKF_EXPEDITE
> + *
> + * Used only with new requests for NL mode locks.  Tells the lock manager
> + * to grant the lock, ignoring other locks in convert and wait queues.
What's happens to non DLM_LKF_EXPEDITE NL mode requests? It seems that an
new NL mode lock should always be immediately be put on the grant queue...

<snip>

> +#define DLM_LKF_NOQUEUE        (0x00000001)
> +#define DLM_LKF_CANCEL         (0x00000002)
> +#define DLM_LKF_CONVERT        (0x00000004)
> +#define DLM_LKF_VALBLK         (0x00000008)
> +#define DLM_LKF_QUECVT         (0x00000010)
> +#define DLM_LKF_IVVALBLK       (0x00000020)
> +#define DLM_LKF_CONVDEADLK     (0x00000040)
> +#define DLM_LKF_PERSISTENT     (0x00000080)
> +#define DLM_LKF_NODLCKWT       (0x00000100)
> +#define DLM_LKF_NODLCKBLK      (0x00000200)
> +#define DLM_LKF_EXPEDITE       (0x00000400)
> +#define DLM_LKF_NOQUEUEBAST    (0x00000800)
> +#define DLM_LKF_HEADQUE        (0x00001000)
> +#define DLM_LKF_NOORDER        (0x00002000)
> +#define DLM_LKF_ORPHAN         (0x00004000)
> +#define DLM_LKF_ALTPR          (0x00008000)
> +#define DLM_LKF_ALTCW          (0x00010000)
Where's the LKM_LOCAL equivalent? What happens a dlm user wants to create a
lock on a resource it knows to be unique in the cluster (think file creation
for a cfs)? Does it have to hit the network for a resource lookup on those
locks?

Perhaps I should explain how this is interpreted in the OCFS2 dlm: When
LKM_LOCAL is provided with a request for a new lock, the normal master
lookup process is skipped and the resource is immediately created and
mastered to the local node. Obviously this requires that users be careful
not to create duplicate resources in the cluster. Any future requests for
the lock from other nodes go through the master discovery process and will
find it on the originating node.

We explicitly do not support LKM_FINDLOCAL - the notion of "local only"
lookups does not apply as the resource is only considered to have been
created locally and explicitly *not* hidden from the rest of the cluster.

>From a light skimming of dir.c (specifically dlm_dir_name2nodeid), I have a
hunch that our methods for determing a resource master are fundamentally
different, which would make implementation of LKM_LOCAL (at least as I have
described it) on your side, difficult.

<snip>

> +static struct list_head		ast_queue;
> +static struct semaphore		ast_queue_lock;
Why a semaphore here? On quick inspection I'm not seeing much more than list
operations being protected by ast_queue_lock... A spinlock might be more
appropriate.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
