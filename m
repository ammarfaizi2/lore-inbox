Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135258AbRD1Lwe>; Sat, 28 Apr 2001 07:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135259AbRD1LwY>; Sat, 28 Apr 2001 07:52:24 -0400
Received: from fep01.swip.net ([130.244.199.129]:64487 "EHLO
	fep01-svc.swip.net") by vger.kernel.org with ESMTP
	id <S135258AbRD1LwM>; Sat, 28 Apr 2001 07:52:12 -0400
Date: Sat, 28 Apr 2001 13:52:06 +0200 (CEST)
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
X-X-Sender: <petero@ppro.localdomain>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: 2.4.4 sluggish under fork load
Message-ID: <Pine.LNX.4.33.0104281322070.1159-100000@ppro.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed that 2.4.4 feels a lot less responsive than 2.4.3 under
fork load. This is caused by the "run child first after fork" patch. I
have tested on two different UP x86 systems running redhat 7.0.

For example, when running the gcc configure script, the X mouse pointer is
very jerky. The configure script itself runs approximately as fast as in
2.4.3.

Another thing is that the bash loop "while true ; do /bin/true ; done" is
not possible to interrupt with ctrl-c.

A third thing I noticed is that starting a gnome session in redhat 7.0
takes longer. (It takes more time for the gnome splash screen to appear.)

Reverting the fork patch makes all these problems go away on my machine.
I'm not saying that this is necessarily a good idea, that patch might be
good for other reasons.


--- linux-2.4.4/kernel/fork.c~	Sat Apr 28 09:46:58 2001
+++ linux-2.4.4/kernel/fork.c	Sat Apr 28 11:14:33 2001
@@ -674,9 +674,16 @@
 	 * and then exec(). This is only important in the first timeslice.
 	 * In the long run, the scheduling behavior is unchanged.
 	 */
+#if 0
 	p->counter = current->counter;
 	current->counter = 0;
 	current->need_resched = 1;
+#else
+	p->counter = (current->counter + 1) >> 1;
+	current->counter >>= 1;
+	if (!current->counter)
+		current->need_resched = 1;
+#endif

 	/*
 	 * Ok, add it to the run-queues and make it

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden


