Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSGPV2s>; Tue, 16 Jul 2002 17:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318186AbSGPV2r>; Tue, 16 Jul 2002 17:28:47 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:2015 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id <S318184AbSGPV2p>;
	Tue, 16 Jul 2002 17:28:45 -0400
Date: Tue, 16 Jul 2002 23:10:03 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Cc: fischer@norbit.de, marcelo@conectiva.com.br
Subject: [PATCH] aha152x fix
Message-ID: <20020716231003.A488@lucretia.debian.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, fischer@norbit.de,
	marcelo@conectiva.com.br
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Marks-The-Spot: xxxxxxxxxx
X-GPG-Fingerprint: 1024D/8E950E00 CAC1 0932 B6B9 8768 40DB  C6AA 1239 F709 8E95 0E00
X-Machine-info: Linux lucretia 2.4.19-rc1-sched-o1 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I upgraded from 2.4.19-pre7 to -rc1 and this resulted in my aha152x card not
working anymore. (The error was "trying software interrupt, lost")

Below is a patch which makes it work again. Note that this is just reverting
a minimal part of the last applied patch to aha152x.c; so this may only be
fixing the symptom and not the problem.

Can somebody confirm if this is correct or not, and give some more insight
into this behaviour?


Regards,

Filip

--- aha152x.c.orig	Tue Jul 16 22:20:57 2002
+++ aha152x.c	Tue Jul 16 21:43:51 2002
@@ -1366,11 +1366,13 @@
 		}
 		HOSTDATA(shpnt)->swint = 0;
 
 		printk(KERN_INFO "aha152x%d: trying software interrupt, ", HOSTNO);
 		SETPORT(DMACNTRL0, SWINT|INTEN);
+		spin_unlock_irq (&io_request_lock);
 		mdelay(1000);
+		spin_lock_irq (&io_request_lock);
 		free_irq(shpnt->irq, shpnt);
 
 		if (!HOSTDATA(shpnt)->swint) {
 			if (TESTHI(DMASTAT, INTSTAT)) {
 				printk("lost.\n");

-- 
"Microsoft shouldn't be broken up.  It should be shut down."
	-- Phil Agre on the ILOVEYOU virus.
