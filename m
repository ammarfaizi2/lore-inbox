Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264466AbRFIMHQ>; Sat, 9 Jun 2001 08:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264468AbRFIMHH>; Sat, 9 Jun 2001 08:07:07 -0400
Received: from mons.uio.no ([129.240.130.14]:22012 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S264466AbRFIMG4>;
	Sat, 9 Jun 2001 08:06:56 -0400
To: Ian Lynagh <igloo@earth.li>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 rpc_execute panic (OK with 2.2.17)
In-Reply-To: <20010609113521.A30318@stu163.keble.ox.ac.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 09 Jun 2001 14:06:45 +0200
In-Reply-To: Ian Lynagh's message of "Sat, 9 Jun 2001 11:35:21 +0100"
Message-ID: <shselstyi0a.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ian Lynagh <igloo@earth.li> writes:

     > Hi all

     > We have a sun ultra 1 with /proc/cpuinfo as follows:

     > cpu : TI UltraSparc I (SpitFire) fpu : UltraSparc I integrated
     > FPU promlib : Version 3 Revision 1 prom : 3.1.1 type : sun4u
     > ncpus probed : 1 ncpus active : 1 BogoMips : 333.41 MMU Type :
     > Spitfire

     > When trying to mount something over NFS with a 2.2.19 kernel we
     > get:

     > Unsupported unaligned load/store trap for kernel at
     > <00000000004d260c> Kernel panic: Wheee. Kernel does fpu/atomic
     > unaligned load/store.

     > Which appears to be in rpc_execute according to System.map:

Does the following patch help?

Cheers,
  Trond

--- linux-2.2.19/include/linux/sunrpc/sched.h.orig	Mon Mar 26 17:11:28 2001
+++ linux-2.2.19/include/linux/sunrpc/sched.h	Sat Jun  9 14:04:08 2001
@@ -81,7 +81,7 @@
 	unsigned int		tk_lock;	/* Task lock counter */
 	unsigned char		tk_active   : 1,/* Task has been activated */
 				tk_wakeup   : 1;/* Task waiting to wake up */
-	unsigned int		tk_runstate;	/* Task run status */
+	unsigned long		tk_runstate;	/* Task run status */
 #ifdef RPC_DEBUG
 	unsigned int		tk_pid;		/* debugging aid */
 #endif
--- linux-2.2.19/include/linux/sunrpc/xprt.h.orig	Mon Mar 26 17:11:45 2001
+++ linux-2.2.19/include/linux/sunrpc/xprt.h	Sat Jun  9 14:04:46 2001
@@ -143,7 +143,7 @@
 	struct rpc_wait_queue	pingwait;	/* waiting on ping() */
 	struct rpc_rqst *	free;		/* free slots */
 	struct rpc_rqst		slot[RPC_MAXREQS];
-	unsigned int		sockstate;	/* Socket state */
+	unsigned long		sockstate;	/* Socket state */
 	unsigned char		nocong	    : 1,/* no congestion control */
 				stream      : 1,/* TCP */
 				shutdown    : 1,/* being shut down */
