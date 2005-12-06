Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVLFQ4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVLFQ4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 11:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVLFQ4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 11:56:09 -0500
Received: from fsmlabs.com ([168.103.115.128]:47745 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932332AbVLFQ4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 11:56:08 -0500
X-ASG-Debug-ID: 1133888164-5825-1-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Tue, 6 Dec 2005 09:01:34 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Clemens Koller <clemens.koller@anagramm.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Collins <jgcc@pacbell.net>
X-ASG-Orig-Subj: Re: 2.6.13.2 crash on shutdown on SMP machine
Subject: Re: 2.6.13.2 crash on shutdown on SMP machine
In-Reply-To: <43957B94.1070604@anagramm.de>
Message-ID: <Pine.LNX.4.64.0512060900290.13220@montezuma.fsmlabs.com>
References: <433A747E.3070705@anagramm.de> <4394260F.7020703@anagramm.de>
 <Pine.LNX.4.64.0512051246130.13220@montezuma.fsmlabs.com> <43957B94.1070604@anagramm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6002
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Clemens Koller wrote:

> Hello, Zwane!
> 
> > > From what i hear it's this issue;
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=5203
> 
> Yes it seems to be the same issue.
> But who is Eric, mentioned in bugzilla? :-]
> If it makes sense I can test his patch while/before he is pushing
> it upstream.

Eric is 'Eric Biederman', Jeff tested his patch but there appears to be a 
failure case when there is no power management callback installed. Could 
you please test the following patch?

diff -r 3815424104b0 arch/i386/kernel/reboot.c
--- a/arch/i386/kernel/reboot.c	Sat Dec  3 07:09:38 2005
+++ b/arch/i386/kernel/reboot.c	Mon Dec  5 00:44:37 2005
@@ -359,6 +359,10 @@
 
 	if (pm_power_off)
 		pm_power_off();
-}
-
-
+
+	local_irq_disable();
+	if (cpu_data[0].hlt_works_ok)
+		while (1) halt();
+	while (1);
+}
+
diff -r 3815424104b0 arch/x86_64/kernel/reboot.c
--- a/arch/x86_64/kernel/reboot.c	Sat Dec  3 07:09:38 2005
+++ b/arch/x86_64/kernel/reboot.c	Mon Dec  5 00:44:37 2005
@@ -159,5 +159,9 @@
 	}
 	if (pm_power_off)
 		pm_power_off();
+
+	local_irq_disable();
+	while (1)
+		halt();
 }
 
