Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWCUH22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWCUH22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWCUH22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:28:28 -0500
Received: from smtpauth08.mail.atl.earthlink.net ([209.86.89.68]:9926 "EHLO
	smtpauth08.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S932158AbWCUH21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:28:27 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Tue, 21 Mar 2006 09:38:42 +0800."
             <3ACA40606221794F80A5670F0AF15F840B417262@pdsmsx403> 
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Tue, 21 Mar 2006 02:27:43 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FLbHL-0001hi-Cn@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478d165aa9320335d71d5bc33a77d89db29846c6eea46606956350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From pervious experience, we know _THM0._TMP causes problem.  If you
> fake _TMP for all THM, what could happen?

It still hangs on the second sleep.  I faked them in the kernel instead
of the DSDT, by faking them in acpi_evaluate_integer() like so:

diff -r ac486e270597 -r 959c4fa10a36 drivers/acpi/utils.c
--- a/drivers/acpi/utils.c	Sat Mar 18 08:35:34 2006 -0500
+++ b/drivers/acpi/utils.c	Mon Mar 20 20:52:01 2006 -0500
@@ -270,7 +270,15 @@ acpi_evaluate_integer(acpi_handle handle
 	memset(element, 0, sizeof(union acpi_object));
 	buffer.length = sizeof(union acpi_object);
 	buffer.pointer = element;
-	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
+	if (strcmp(pathname, "_TMP") != 0)
+	  status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
+	else {
+	  printk(KERN_INFO PREFIX "acpi_evaluate_integer: Faking _TMP\n");
+	  status = AE_OK;
+	  element->type = ACPI_TYPE_INTEGER;
+	  element->integer.value = 3000; /* 27 C, in deciKelvins */
+	}
+
 	if (ACPI_FAILURE(status)) {
 		acpi_util_eval_error(handle, pathname, status);
 		return_ACPI_STATUS(status);


Each thermal zone loaded with produced printk's like "Faking _TMP", etc,
so the patch was working.  It shouldn't change the result if instead I
make all the _TMP methods in the DSDT return 0xBB8 (or whatever the
magic number was).

So my plan, which I'm trying now, is to keep _TMP faked for all zones,
and take away one zone at a time until the hang goes away.  If I take
away all of THM[267], then it won't hang (since THM0 by itself hangs but
THM0 without _TMP does not hang).  But I hope that an earlier
combination in the search will not hang.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
