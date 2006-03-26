Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWCZCSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWCZCSV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 21:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWCZCSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 21:18:21 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:55248 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751275AbWCZCSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 21:18:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=jKKt3SAf34D+sNqdAYnbou9konvoq6qibK8t35mvortx45OfsJbVzvmOb6yU/x4x/vMYDK7hmhxX91ZbOl9zj1Xs6Va6zGfxntf3XeuDU2gW2baj5ZnRBMYlOyvVcMt0bSIy9gfVDoefF5RyGWXX9JDZT+gmSSaymrI0+SsTv74=
Subject: Re: [2.6 patch] fix array over-run in efi.c
From: "Darren Jenkins\\" <darrenrjenkins@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603251941111.29793@yvahk01.tjqt.qr>
References: <20060325115853.GB4053@stusta.de>
	 <Pine.LNX.4.61.0603251941111.29793@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 12:18:10 +1000
Message-Id: <1143339491.8088.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-25 at 19:41 +0100, Jan Engelhardt wrote:
> >-		for (i = 0; i < sizeof(vendor) && *c16; ++i)
> >+		for (i = 0; i < (sizeof(vendor) - 1) && *c16; ++i)
> 
>                 for (i = 0; i <  sizeof(vendor) - 1  && *c16; ++i)
> Should suffice.
> 
> 
> Jan Engelhardt


OK since it is preferred without the brackets, here it is again.



Coverity found an over-run @ line 364 of efi.c

This is due to the loop checking the size correctly, then adding a '\0'
after possibly hitting the end of the array.

The patch below just ensures the loop exits with one space left in the
array.

Compile tested.

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>

--- linux-2.6.16-git8/arch/i386/kernel/efi.c.orig	2006-03-26 12:06:47.000000000 +1000
+++ linux-2.6.16-git8/arch/i386/kernel/efi.c	2006-03-26 12:08:34.000000000 +1000
@@ -361,7 +361,7 @@ void __init efi_init(void)
 	 */
 	c16 = (efi_char16_t *) boot_ioremap(efi.systab->fw_vendor, 2);
 	if (c16) {
-		for (i = 0; i < sizeof(vendor) && *c16; ++i)
+		for (i = 0; i < sizeof(vendor) - 1 && *c16; ++i)
 			vendor[i] = *c16++;
 		vendor[i] = '\0';
 	} else




