Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbRBEX5t>; Mon, 5 Feb 2001 18:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131983AbRBEX5j>; Mon, 5 Feb 2001 18:57:39 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:23826 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130685AbRBEX53>; Mon, 5 Feb 2001 18:57:29 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Byron Stanoszek <gandalf@winds.org>
Date: Tue, 6 Feb 2001 10:57:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14975.15829.623996.534161@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS stop/start problems (related to datagram shutdown bug?)
In-Reply-To: message from Byron Stanoszek on Monday February 5
In-Reply-To: <Pine.LNX.4.21.0102051728340.1460-100000@winds.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 5, gandalf@winds.org wrote:
> Seems recently, on both redhat 6.1 and 7.0 using kernel 2.4.1-ac3, I
> ran into this problem:
> 
> Stopping NFS says the following in the kernel logs:
> 
> nfsd: terminating on signal 9
> nfsd: terminating on signal 9
> nfsd: terminating on signal 9
> nfsd: terminating on signal 9
> nfsd: terminating on signal 9
> nfsd: terminating on signal 9
> nfsd: terminating on signal 9
> nfsd: terminating on signal 9
> svc: server socket destroy delayed
> 
> And restarting NFS has the following error message:
> 
> root:~> /etc/rc.d/init.d/nfs start
> Starting NFS services:                                     [  OK  ]
> Starting NFS quotas:                                       [  OK  ]
> Starting NFS mountd:                                       [  OK  ]
> Starting NFS daemon: nfssvc: Address already in use
>                                                            [FAILED]

How repeatable is this?  Is the server SMP?

There does seem to be a possible problem with sk_inuse not being
updated atomically, so a race between an increment and a decrement
could lose one of them.
svc_sock_release seems to often be called with no more protection than
the BKL, and it decrements sk_inuse.

svc_sock_enqueue, on the other hand increments sk_inuse, and is
protected by sv_lock, but not, I think, by the BKL, as it is called by
a networking layer callback.  So there might be a possibility for a
race here.

The attached patch might fix it, so if you are having reproducable
problems, it might be worth applying this patch.

Trond: any comments?

NeilBrown

[ a better fix would be to make sk_inuse atomic_t ]

--- net/sunrpc/svcsock.c	2001/02/05 23:45:54	1.1
+++ net/sunrpc/svcsock.c	2001/02/05 23:48:12
@@ -211,16 +211,22 @@
 svc_sock_release(struct svc_rqst *rqstp)
 {
 	struct svc_sock	*svsk = rqstp->rq_sock;
+	struct svc_serv	*serv = svsk->sk_server;
 
 	if (!svsk)
 		return;
 	svc_release_skb(rqstp);
 	rqstp->rq_sock = NULL;
+
+	spin_lock_bh(&serv->sv_lock);
 	if (!--(svsk->sk_inuse) && svsk->sk_dead) {
+		spin_unlock_bh(&serv->sv_lock);
 		dprintk("svc: releasing dead socket\n");
 		sock_release(svsk->sk_sock);
 		kfree(svsk);
 	}
+	else
+		spin_unlock_bh(&serv->sv_lock);
 }
 
 /*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
