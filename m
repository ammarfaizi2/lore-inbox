Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSJQBxL>; Wed, 16 Oct 2002 21:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261625AbSJQBxL>; Wed, 16 Oct 2002 21:53:11 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:29373 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261624AbSJQBwf>; Wed, 16 Oct 2002 21:52:35 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 17 Oct 2002 11:58:10 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15790.6450.3462.78596@notabene.cse.unsw.edu.au>
cc: Juan Gomez <juang@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: [PATCH] Fix problem with lcokd grace period checking.
In-Reply-To: message from Juan Gomez on Wednesday October 16
References: <OFEF1EC5DE.D14F89EF-ON87256C54.005C30B4@us.ibm.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 16, juang@us.ibm.com wrote:
> 
> In an effort to avoid this patch to die before in someone's mailbox I am
> bringing it back....
> As requested by Linus I am forwarding this to you Neil for review/inclusion
> in a soon-to-be released 2.5.* version

I made a few cosmetic changes, and move the comment into the changelog..

NeilBrown

###Comments for ChangeSet

We need to do the clear/grace period here and not before
svc_recv() because svc_recv() may sleep longer than the
grace period and the first request may be falsely processed
as if the server was in the grace period when it was not
causing unnecessary delays for the first request received.
     * Juan C. Gomez j_carlos_gome@yahoo.com

Also opencode trivial clear_grace_period function.

 ----------- Diffstat output ------------
 ./fs/lockd/svc.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

--- ./fs/lockd/svc.c	2002/10/16 04:45:57	1.2
+++ ./fs/lockd/svc.c	2002/10/17 01:53:15	1.3
@@ -72,11 +72,6 @@ static unsigned long set_grace_period(vo
 	return grace_period + jiffies;
 }
 
-static inline void clear_grace_period(void)
-{
-	nlmsvc_grace_period = 0;
-}
-
 /*
  * This is the lockd kernel thread
  */
@@ -141,10 +136,8 @@ lockd(struct svc_rqst *rqstp)
 		 * (Theoretically, there shouldn't even be blocked locks
 		 * during grace period).
 		 */
-		if (!nlmsvc_grace_period) {
+		if (!nlmsvc_grace_period)
 			timeout = nlmsvc_retry_blocked();
-		} else if (time_before(grace_period_expire, jiffies))
-			clear_grace_period();
 
 		/*
 		 * Find a socket with data available and call its
@@ -163,6 +156,9 @@ lockd(struct svc_rqst *rqstp)
 		dprintk("lockd: request from %08x\n",
 			(unsigned)ntohl(rqstp->rq_addr.sin_addr.s_addr));
 
+		if (nlmsvc_grace_period &&
+		    time_before(grace_period_expire, jiffies))
+			nlmsvc_grace_period = 0;
 		svc_process(serv, rqstp);
 
 	}
