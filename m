Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRAMXLI>; Sat, 13 Jan 2001 18:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130374AbRAMXK7>; Sat, 13 Jan 2001 18:10:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41622 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130202AbRAMXKm>;
	Sat, 13 Jan 2001 18:10:42 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14944.57417.917410.380225@pizda.ninka.net>
Date: Sat, 13 Jan 2001 15:10:01 -0800 (PST)
To: trond.myklebust@fys.uio.no
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS devel <nfs-devel@linux.kernel.org>
Subject: Re: Spinlocking patch for in xprt.c
In-Reply-To: <14942.64595.157544.350302@charged.uio.no>
In-Reply-To: <14942.64595.157544.350302@charged.uio.no>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trond, did you actually look at how this code works before
you made modifications to my fixes?

xprt_lock serializes sleep/wakeup sequences in the xprt code, so you
cannot remove xprt_lock from the sections where I added holding of
xprt_sock_lock to protect the state of xprt->snd_task.  So for
example, this part of your patch is completely bogus and will create
new corruptions and crashes:

@@ -1143,10 +1143,10 @@
 	struct rpc_xprt *xprt = task->tk_rqstp->rq_xprt;
 
 	if (xprt->snd_task && xprt->snd_task == task) {
-		spin_lock(&xprt_lock);
+		spin_lock_bh(&xprt_sock_lock);
 		xprt->snd_task = NULL;
 		rpc_wake_up_next(&xprt->sending);
-		spin_unlock(&xprt_lock);
+		spin_unlock_bh(&xprt_sock_lock);
 	}
 }

You _must_ hold both xprt_lock and xprt_sock_lock in this
section of code, not just one or just the other.

Linus, please do not apply this patch until these issues
are addressed.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
