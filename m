Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbULGU7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbULGU7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbULGU7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:59:07 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:22218 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261930AbULGU7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:59:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=n7sJZRyKErBgcm/Kdln+D3T+DAPTuBBTYfYu1CAvGiIMDrYLRn7zPwBUGFqrOHR7VZZRVIkfg5/5alobUqYQxdJ+qJztRTNa4Vc/9scnVefvCZ7OxbmiKcKC68/UVDUeX5OwG3R7uB8cbA5DF1kbtpvrCGdzbnfpM5foBAl6YKk=
Message-ID: <58cb370e041207125864b97eea@mail.gmail.com>
Date: Tue, 7 Dec 2004 21:58:52 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Pope <alan.pope@gmail.com>
Subject: Re: PDC202XX_OLD broken
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bugs@linux-ide.org, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <1102425655.17950.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <8e93903b041206140529a8baa9@mail.gmail.com>
	 <1102425655.17950.21.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

last mail and http://www.popey.com/promise helped a lot

You are using 40c cable instead of 80c one.
Thus transfer rate is limited to UDMA33.

Moreover pdc202xx_old has a bug in cable detection code.
pdc202xx_old_cable_detect() always returns '0' (which means
80c cable) due to a sloppy coding - result of CIS & mask is
truncated to 8 bits although CIS holds cable info in bits 10-11.

Does this fix work for you?

--- pdc202xx_old.c.orig	2004-11-07 03:14:09.000000000 +0100
+++ pdc202xx_old.c	2004-12-07 15:38:13.644921160 +0100
@@ -230,7 +230,7 @@
 {
 	u16 CIS = 0, mask = (hwif->channel) ? (1<<11) : (1<<10);
 	pci_read_config_word(hwif->pci_dev, 0x50, &CIS);
-	return ((u8)(CIS & mask));
+	return (CIS & mask) ? 1 : 0;
 }
 
 /*
