Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUHEUyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUHEUyw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267963AbUHEUyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:54:32 -0400
Received: from mailhub.emc.com ([168.159.2.31]:9326 "EHLO mailhub.lss.emc.com")
	by vger.kernel.org with ESMTP id S267939AbUHEUu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:50:26 -0400
Message-ID: <41129D79.9010402@emc.com>
Date: Thu, 05 Aug 2004 16:50:01 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
References: <41126458.1050203@emc.com> <1091724300.8043.58.camel@localhost.localdomain>
In-Reply-To: <1091724300.8043.58.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.6.0.97784, Antispam-Core: 4.6.0.97340, Antispam-Data: 2004.8.5.109628
X-PerlMx-Spam: SPAM=8%, Report='EMC_FROM_0 -0, __TLG_EMC_ENVFROM_0 0, __MOZILLA_MSGID 0, __HAS_MSGID 0, __SANE_MSGID 0, __USER_AGENT 0, X_ACCEPT_LANG 0, __MIME_VERSION 0, __TO_MALFORMED_2 0, ORDER_STATUS 0, __REFERENCES 0, __IN_REP_TO 0, __EVITE_CTYPE 0, __CT_TEXT_PLAIN 0, __CT 0, __CTE 0, __UNUSABLE_MSGID 0, EMAIL_ATTRIBUTION 0, QUOTED_EMAIL_TEXT 0, __MIME_TEXT_ONLY 0, REFERENCES 0.000, IN_REP_TO 0, USER_AGENT 0.000'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> I would make sure you are looking at the right register set in your own
> code. Any code now thats going to exist for most 2.4 users will need to
> do that itself, and after my 2.4 experience with the IDE core I'd advise
> anyone working on it to
> 
> a) Pass it off to another maintainer as fast as possible ;)
> b) Program defensively

Thanks for the reply Alan,

That probably is the best idea, rather than rely upon the code to do the 
right thing in all places.  That being said, I think the following code 
needs to be added to ide_end_drive_cmd(), since ide_error() calls 
ide_end_drive_cmd() after ide_dump_status() has left the registers 
pointing at the high order part of the LBA.  Using the taskfile ioctl 
will then lead to hobRegister[] and subsequently hob_ports[] being 
loaded with the wrong values.

BR


2.6============================================
--- linux-2.6.8-rc3/drivers/ide/ide-io.c        Tue Aug  3 17:28:20 2004
+++ linux/drivers/ide/ide-io.c  Thu Aug  5 16:28:38 2004
@@ -197,6 +197,8 @@
                                 args->hobRegister[IDE_DATA_OFFSET] 
  = (data >> 8) & 0xFF;
                         }
                         args->tfRegister[IDE_ERROR_OFFSET]   = err;
+                       /* Be sure we're looking at the low order bits */
+                       hwif->OUTB(drive->ctl & ~0x80,IDE_CONTROL_REG);
                         args->tfRegister[IDE_NSECTOR_OFFSET] = 
hwif->INB(IDE_NSECTOR_REG);
                         args->tfRegister[IDE_SECTOR_OFFSET]  = 
hwif->INB(IDE_SECTOR_REG);
                         args->tfRegister[IDE_LCYL_OFFSET]    = 
hwif->INB(IDE_LCYL_REG);


2.4============================================
--- linux-2.4.27-rc5/drivers/ide/ide-io.c       Fri Nov 28 13:26:20 2003
+++ linux/drivers/ide/ide-io.c  Thu Aug  5 16:33:15 2004
@@ -165,6 +165,9 @@
 
args->hobRegister[IDE_DATA_OFFSET_HOB] = (data >> 8) & 0xFF;
                                 }
                                 args->tfRegister[IDE_ERROR_OFFSET]   = err;
+                               /* Be sure we're looking at the low 
order bits
+                                */
+                               hwif->OUTB(drive->ctl & 
~0x80,IDE_CONTROL_REG);
                                 args->tfRegister[IDE_NSECTOR_OFFSET] = 
hwif->INB(IDE_NSECTOR_REG);
                                 args->tfRegister[IDE_SECTOR_OFFSET]  = 
hwif->INB(IDE_SECTOR_REG);
                                 args->tfRegister[IDE_LCYL_OFFSET]    = 
hwif->INB(IDE_LCYL_REG);
