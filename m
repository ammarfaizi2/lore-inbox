Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbSJYNTv>; Fri, 25 Oct 2002 09:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSJYNTv>; Fri, 25 Oct 2002 09:19:51 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:23063 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261391AbSJYNTu>;
	Fri, 25 Oct 2002 09:19:50 -0400
Message-ID: <3DB94683.8080902@acm.org>
Date: Fri, 25 Oct 2002 08:26:27 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: John Levon <levon@movementarian.org>, dipankar@gamebox.net
Subject: [PATCH] NMI request/release, version 8
References: <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk> <3DB81376.90403@mvista.com> <20021024171815.GA6920@compsoc.man.ac.uk> <3DB85213.4020509@mvista.com> <20021024202910.GA16192@compsoc.man.ac.uk> <3DB89CD9.5090409@mvista.com> <20021025013952.GA34678@compsoc.man.ac.uk> <3DB8A5E3.5010505@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------010507040703030903050002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010507040703030903050002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I realized that the piece of code at the end of the old NMI handler was 
still necessary.  I have attached a patch to the previous version to fix 
the problem.  The full version of the patch with this fix is on my web 
page at http://home.attbi.com/~minyard/linux-nmi-v8.diff.

-Corey

--------------010507040703030903050002
Content-Type: text/plain;
 name="linux-nmi-v7-v8.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-nmi-v7-v8.diff"

--- linux.v8/arch/i386/kernel/nmi.c	Thu Oct 24 20:53:04 2002
+++ linux/arch/i386/kernel/nmi.c	Fri Oct 25 08:21:22 2002
@@ -208,30 +208,29 @@
 
 	if (!handled)
 		unknown_nmi_error(regs, cpu);
-#if 0
-	/*
-	 * It MAY be possible to only call handlers until one returns
-	 * that it handled the NMI, if, we do the following.  Assuming
-	 * that all the incoming signals causing NMIs are
-	 * level-triggered, this code will cause another NMI
-	 * immediately if the incoming signal is still asserted.  I
-	 * don't know if the assumption is correct or if it's better
-	 * to call all the handlers or do the I/O.
-	 *
-	 * I'm pretty sure that this won't work with the performance
-	 * registers NMI output, so I'm guessing that this won't work.
-	 */
 	else {
 		/*
 		 * Reassert NMI in case it became active meanwhile
-		 * as it's edge-triggered.
+		 * as it's edge-triggered.    Don't do this if the NMI
+		 * wasn't handled to avoid an infinite NMI loop.
+		 *
+		 * This is necessary in case we have another external
+		 * NMI while processing this one.  The external NMIs
+		 * are level-generated, into the processor NMIs are
+		 * edge-triggered, so if you have one NMI source
+		 * come in while another is already there, the level
+		 * will never go down to cause another edge, and
+		 * no more NMIs will happen.  This does NOT apply
+		 * to internally generated NMIs, though, so you
+		 * can't use the same trick to only call one handler
+		 * at a time.  Otherwise, if two internal NMIs came
+		 * in at the same time you might miss one.
 		 */
 		outb(0x8f, 0x70);
 		inb(0x71);		/* dummy */
 		outb(0x0f, 0x70);
 		inb(0x71);		/* dummy */
 	}
-#endif
 }
 
 void __init init_nmi(void)

--------------010507040703030903050002--

