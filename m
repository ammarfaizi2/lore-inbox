Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTL3Gpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTL3Gpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:45:31 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:13382
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S264464AbTL3GpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:45:22 -0500
Date: Tue, 30 Dec 2003 01:45:21 -0500
From: Omkhar Arasaratnam <omkhar@rogers.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: emoenke@gwdg.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/cdrom/sjcd.c check_region() fix
Message-ID: <20031230064521.GA21141@omkhar.ibm.com>
References: <20031229195757.GA26168@omkhar.ibm.com> <200312300112.00823.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200312300112.00823.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.4i
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.192.237.88] using ID <omkhar@rogers.com> at Tue, 30 Dec 2003 01:43:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 01:12:00AM -0500, Gene Heskett wrote:
> On Monday 29 December 2003 14:57, Omkhar Arasaratnam wrote:
> >Here is another check_region fix, this time for sjcd.c
> >
> >--- /usr/src/linux-2.6.0/drivers/cdrom/sjcd.c	2003-12-17
> > 21:59:05.000000000 -0500 +++ drivers/cdrom/sjcd.c	2003-12-29
> > 14:52:05.000000000 -0500 @@ -1700,12 +1700,13 @@
> > 	sprintf(sjcd_disk->disk_name, "sjcd");
> > 	sprintf(sjcd_disk->devfs_name, "sjcd");
> >
> >-	if (check_region(sjcd_base, 4)) {
> >+	if (!request_region(sjcd_base, 4,"sjcd")) {
> > 		printk
> > 		    ("SJCD: Init failed, I/O port (%X) is already in use\n",
> > 		     sjcd_base);
> > 		goto out2;
> > 	}
> >+	release_region(sjcd_base,4);
> >
> > 	/*
> > 	 * Check for card. Since we are booting now, we can't use standard
> 
> I've got two of those check_region() warnings in advansys.c.
> 
> Would it be appropriate to do a similar fix to it?
Believe it or not I was actually working on advant.c as well. That's a big file. I was going to leave it till the AM to post 
after doing a final sanity check (it's almost 2am local time :)
I believe this _should_ work - perhaps you can advise if line 5390 (after applying my patch) will fail because of a duplicate
request_region()... Either way here is my patch:


--- linux-clean/drivers/scsi/advansys.c.org	2003-12-29 19:35:26.000000000 -0500
+++ linux-clean/drivers/scsi/advansys.c	2003-12-30 01:37:01.000000000 -0500
@@ -4619,7 +4619,7 @@
                         ASC_DBG1(1,
                                 "advansys_detect: probing I/O port 0x%x...\n",
                             iop);
-                        if (check_region(iop, ASC_IOADR_GAP) != 0) {
+                        if (!request_region(iop, ASC_IOADR_GAP, "advansys")) {
                             printk(
 "AdvanSys SCSI: specified I/O Port 0x%X is busy\n", iop);
                             /* Don't try this I/O port twice. */
@@ -4630,6 +4630,7 @@
 "AdvanSys SCSI: specified I/O Port 0x%X has no adapter\n", iop);
                             /* Don't try this I/O port twice. */
                             asc_ioport[ioport] = 0;
+			    release_region(iop, ASC_IOADR_GAP);
                             goto ioport_try_again;
                         } else {
                             /*
@@ -4647,6 +4648,7 @@
                                   * 'ioport' past this board.
                                   */
                                  ioport++;
+				 release_region(iop, ASC_IOADR_GAP);
                                  goto ioport_try_again;
                             }
                         }
@@ -10003,10 +10005,11 @@
     }
     for (; i < ASC_IOADR_TABLE_MAX_IX; i++) {
         iop_base = _asc_def_iop_base[i];
-        if (check_region(iop_base, ASC_IOADR_GAP) != 0) {
+        if (!request_region(iop_base, ASC_IOADR_GAP, "advansys")) {
             ASC_DBG1(1,
-               "AscSearchIOPortAddr11: check_region() failed I/O port 0x%x\n",
+               "AscSearchIOPortAddr11: request_region() failed I/O port 0x%x\n",
                      iop_base);
+	    release_region(iop_base, ASC_IOADR_GAP);
             continue;
         }
         ASC_DBG1(1, "AscSearchIOPortAddr11: probing I/O port 0x%x\n", iop_base);

O
