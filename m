Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318022AbSHHV7M>; Thu, 8 Aug 2002 17:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318028AbSHHV7M>; Thu, 8 Aug 2002 17:59:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32525 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318022AbSHHV7L>; Thu, 8 Aug 2002 17:59:11 -0400
Date: Thu, 8 Aug 2002 15:02:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hubertus Franke <frankeh@us.ibm.com>
cc: Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@zip.com.au>, <andrea@suse.de>, <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Paul Larson <plars@austin.ibm.com>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
In-Reply-To: <OF607243C8.ACB54959-ON85256C0F.00771789-85256C0F.0077571A@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0208081500550.9114-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Aug 2002, Hubertus Franke wrote:
> 
> That is true. All was done under the 16-bit assumption
> My hunch is that the current algorithm might actually work quite well
> for a sparsely populated pid-space (32-bits).

I agree.

So let's just try Andries approach, suggested patch as follows..

(yeah, silly mask and MAX_PID, but since even the kernel uses signed
integers for some of it, this way it never gets close to being an issue).

		Linus

----
--- 1.2/include/linux/threads.h	Tue Feb  5 07:23:04 2002
+++ edited/include/linux/threads.h	Thu Aug  8 14:58:28 2002
@@ -19,6 +19,7 @@
 /*
  * This controls the maximum pid allocated to a process
  */
-#define PID_MAX 0x8000
+#define PID_MASK 0x3fffffff
+#define PID_MAX (PID_MASK+1)
 
 #endif
===== kernel/fork.c 1.57 vs edited =====
--- 1.57/kernel/fork.c	Tue Jul 30 15:49:20 2002
+++ edited/kernel/fork.c	Thu Aug  8 15:00:16 2002
@@ -142,7 +142,7 @@
 		return 0;
 
 	spin_lock(&lastpid_lock);
-	if((++last_pid) & 0xffff8000) {
+	if((++last_pid) & ~PID_MASK) {
 		last_pid = 300;		/* Skip daemons etc. */
 		goto inside;
 	}
@@ -157,7 +157,7 @@
 			   p->tgid == last_pid	||
 			   p->session == last_pid) {
 				if(++last_pid >= next_safe) {
-					if(last_pid & 0xffff8000)
+					if(last_pid & ~PID_MASK)
 						last_pid = 300;
 					next_safe = PID_MAX;
 				}

