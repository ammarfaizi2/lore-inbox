Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTKBGNa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 01:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbTKBGNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 01:13:30 -0500
Received: from CPE-144-132-198-235.nsw.bigpond.net.au ([144.132.198.235]:45449
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id S261473AbTKBGN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 01:13:28 -0500
Date: Sun, 2 Nov 2003 13:57:48 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: [patch] reproducible athlon mce fix
Message-ID: <20031102055748.GA1218@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hi all,


After switching from 2.4.22 to 2.6.0-test9, I have received reproducible
MCE non-fatal error check messages in my kernel log.  (For example, one
shows up right after my first scsi card init).

>From Dave Jones' patch here:

http://lists.insecure.org/lists/linux-kernel/2003/Sep/7362.html

and another message here:

http://lkml.org/lkml/2003/10/7/214

would seem to imply that Athlons don't like having their Bank 0 poked at,
though that's what non-fatal.c does.  Would it be correct to make sure
that that non-fatal.c starts at bank 1, if it is an Athlon?

Dave, is the following patch correct?  Booted and tested, no ill effects
so far ...


	- g.

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="mce-fix.patch"

--- linux-2.6.0-test9/arch/i386/kernel/cpu/mcheck/non-fatal.c.orig	2003-11-02 13:31:43.000000000 +0800
+++ linux-2.6.0-test9/arch/i386/kernel/cpu/mcheck/non-fatal.c	2003-11-02 13:34:37.000000000 +0800
@@ -30,7 +30,11 @@
 	int i;
 
 	preempt_disable(); 
+#if CONFIG_MK7
+	for (i=1; i<nr_mce_banks; i++) {
+#else
 	for (i=0; i<nr_mce_banks; i++) {
+#endif
 		rdmsr (MSR_IA32_MC0_STATUS+i*4, low, high);
 
 		if (high & (1<<31)) {

--bg08WKrSYDhXBjb5--
