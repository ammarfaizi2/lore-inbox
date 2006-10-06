Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWJFUu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWJFUu1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWJFUu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:50:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932628AbWJFUu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:50:26 -0400
Date: Fri, 6 Oct 2006 13:50:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] sound/oss/btaudio.c: ioremap balanced with iounmap
Message-Id: <20061006135018.ec3c55de.akpm@osdl.org>
In-Reply-To: <1160113132.19143.128.camel@amol.verismonetworks.com>
References: <1160113132.19143.128.camel@amol.verismonetworks.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006 11:08:52 +0530
Amol Lad <amol@verismonetworks.com> wrote:

> ioremap must be balanced by an iounmap and failing to do so can result
> in a memory leak.
> 
> Tested (compilation only):
> - using allmodconfig
> - making sure the files are compiling without any warning/error due to
> new changes
> 
> Signed-off-by: Amol Lad <amol@verismonetworks.com>
> ---
> Forwarding to lkml as got no response from linux-sound
> ---
>  btaudio.c |    2 ++
>  1 files changed, 2 insertions(+)
> ---
> diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/sound/oss/btaudio.c linux-2.6.19-rc1/sound/oss/btaudio.c
> --- linux-2.6.19-rc1-orig/sound/oss/btaudio.c	2006-09-21 10:15:52.000000000 +0530
> +++ linux-2.6.19-rc1/sound/oss/btaudio.c	2006-10-05 15:21:32.000000000 +0530
> @@ -1013,6 +1013,7 @@ static int __devinit btaudio_probe(struc
>          return 0;
>  
>   fail4:
> +	iounmap(bta->mmio);
>  	unregister_sound_dsp(bta->dsp_analog);
>   fail3:
>  	if (digital)
> @@ -1051,6 +1052,7 @@ static void __devexit btaudio_remove(str
>          free_irq(bta->irq,bta);
>  	release_mem_region(pci_resource_start(pci_dev,0),
>  			   pci_resource_len(pci_dev,0));
> +	iounmap(bta->mmio);
>  
>  	/* remove from linked list */
>  	if (bta == btaudios) {

No, that misses several cases.  Please review this version:

--- a/sound/oss/btaudio.c~sound-oss-btaudioc-ioremap-balanced-with-iounmap
+++ a/sound/oss/btaudio.c
@@ -1020,6 +1020,7 @@ static int __devinit btaudio_probe(struc
  fail2:
         free_irq(bta->irq,bta);	
  fail1:
+	iounmap(bta->mmio);
 	kfree(bta);
  fail0:
 	release_mem_region(pci_resource_start(pci_dev,0),
@@ -1051,6 +1052,7 @@ static void __devexit btaudio_remove(str
         free_irq(bta->irq,bta);
 	release_mem_region(pci_resource_start(pci_dev,0),
 			   pci_resource_len(pci_dev,0));
+	iounmap(bta->mmio);
 
 	/* remove from linked list */
 	if (bta == btaudios) {
_

