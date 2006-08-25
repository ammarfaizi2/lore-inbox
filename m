Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422895AbWHYUhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422895AbWHYUhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422903AbWHYUhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:37:14 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:58358 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422895AbWHYUhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:37:12 -0400
Subject: Re: [PATCH 4/4] nfs: deadlock prevention for NFS
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Indan Zupancic <indan@nul.nu>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
In-Reply-To: <1156536880.5927.29.camel@localhost>
References: <20060825153946.24271.42758.sendpatchset@twins>
	 <20060825154027.24271.43168.sendpatchset@twins>
	 <1156536880.5927.29.camel@localhost>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 22:36:22 +0200
Message-Id: <1156538183.26945.15.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 16:14 -0400, Trond Myklebust wrote:
> Grumble... If your patches are targetting NFS, could you please at the
> very least Cc nfs@lists.sourceforge.net and/or myself.

Sorry, will make sure you're on the CC list next round.

> On Fri, 2006-08-25 at 17:40 +0200, Peter Zijlstra wrote:
> > Provide a proper a_ops->swapfile() implementation for NFS. This will
> > set the NFS socket to SOCK_VMIO and put the socket reconnection under
> > PF_MEMALLOC (I hope this is enough, otherwise more work needs to be done).
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > ---
> >  fs/nfs/file.c               |   21 ++++++++++++++++++++-
> >  include/linux/sunrpc/xprt.h |    4 +++-
> >  net/sunrpc/xprtsock.c       |   16 ++++++++++++++++
> >  3 files changed, 39 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6/fs/nfs/file.c
> > ===================================================================
> > --- linux-2.6.orig/fs/nfs/file.c
> > +++ linux-2.6/fs/nfs/file.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/smp_lock.h>
> > +#include <net/sock.h>
> >  
> >  #include <asm/uaccess.h>
> >  #include <asm/system.h>
> > @@ -317,7 +318,25 @@ static int nfs_release_page(struct page 
> >  
> >  static int nfs_swapfile(struct address_space *mapping, int enable)
> >  {
> > -	return 0;
> > +	int err = -EINVAL;
> > +	struct rpc_clnt *client = NFS_CLIENT(mapping->host);
> > +	struct sock *sk = client->cl_xprt->inet;
> > +
> > +	if (enable) {
> > +		client->cl_xprt->swapper = 1;
> > +		/*
> > +		 * keep one extra sock reference so the reserve won't dip
> > +		 * when the socket gets reconnected.
> > +		 */
> > +		sk_adjust_memalloc(1, 1);
> > +		err = sk_set_vmio(sk);
> > +	} else if (client->cl_xprt->swapper) {
> > +		client->cl_xprt->swapper = 0;
> > +		sk_adjust_memalloc(-1, -1);
> > +		err = sk_clear_vmio(sk);
> > +	}
> > +
> > +	return err;
> >  }
> 
> This all belongs in net/sunrpc/xprtsock.c. The NFS code has no business
> screwing around with the internals of the sunrpc transport.

Ok, I'll make a function there, and call that.

> >  const struct address_space_operations nfs_file_aops = {
> > Index: linux-2.6/net/sunrpc/xprtsock.c
> > ===================================================================
> > --- linux-2.6.orig/net/sunrpc/xprtsock.c
> > +++ linux-2.6/net/sunrpc/xprtsock.c
> > @@ -1014,6 +1014,7 @@ static void xs_udp_connect_worker(void *
> >  {
> >  	struct rpc_xprt *xprt = (struct rpc_xprt *) args;
> >  	struct socket *sock = xprt->sock;
> > +	unsigned long pflags = current->flags;
> >  	int err, status = -EIO;
> >  
> >  	if (xprt->shutdown || xprt->addr.sin_port == 0)
> > @@ -1021,6 +1022,9 @@ static void xs_udp_connect_worker(void *
> >  
> >  	dprintk("RPC:      xs_udp_connect_worker for xprt %p\n", xprt);
> >  
> > +	if (xprt->swapper)
> > +		current->flags |= PF_MEMALLOC;
> > +
> >  	/* Start by resetting any existing state */
> >  	xs_close(xprt);
> >  
> > @@ -1054,6 +1058,9 @@ static void xs_udp_connect_worker(void *
> >  		xprt->sock = sock;
> >  		xprt->inet = sk;
> >  
> > +		if (xprt->swapper)
> > +			sk_set_vmio(sk);
> > +
> >  		write_unlock_bh(&sk->sk_callback_lock);
> >  	}
> >  	xs_udp_do_set_buffer_size(xprt);
> > @@ -1061,6 +1068,7 @@ static void xs_udp_connect_worker(void *
> >  out:
> >  	xprt_wake_pending_tasks(xprt, status);
> >  	xprt_clear_connecting(xprt);
> > +	current->flags = pflags;
> >  }
> >  
> >  /*
> > @@ -1097,11 +1105,15 @@ static void xs_tcp_connect_worker(void *
> >  {
> >  	struct rpc_xprt *xprt = (struct rpc_xprt *)args;
> >  	struct socket *sock = xprt->sock;
> > +	unsigned long pflags = current->flags;
> >  	int err, status = -EIO;
> >  
> >  	if (xprt->shutdown || xprt->addr.sin_port == 0)
> >  		goto out;
> >  
> > +	if (xprt->swapper)
> > +		current->flags |= PF_MEMALLOC;
> > +
> >  	dprintk("RPC:      xs_tcp_connect_worker for xprt %p\n", xprt);
> >  
> >  	if (!xprt->sock) {
> > @@ -1170,10 +1182,14 @@ static void xs_tcp_connect_worker(void *
> >  				break;
> >  		}
> >  	}
> > +
> > +	if (xprt->swapper)
> > +		sk_set_vmio(xprt->inet);
> >  out:
> >  	xprt_wake_pending_tasks(xprt, status);
> >  out_clear:
> >  	xprt_clear_connecting(xprt);
> > +	current->flags = pflags;
> >  }
> 
> How does this guarantee that the socket reconnection won't fail?

I was afraid this might not be enough, I really have to go through the
network code.

> Also, what about the case of rpc_malloc()? Can't that cause rpciod to
> deadlock when you add NFS swap into the equation?

I will have to plead ignorance for now, I'll look into this on monday.
On first glance it looks like rpc_malloc could use an |__GFP_EMERG for
RPC_TASK_SWAPPER.

