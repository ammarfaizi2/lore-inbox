Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTDHP7A (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTDHP7A (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:59:00 -0400
Received: from [12.47.58.221] ([12.47.58.221]:48791 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261595AbTDHP66 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 11:58:58 -0400
Date: Tue, 8 Apr 2003 09:10:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm1
Message-Id: <20030408091048.002a2e08.akpm@digeo.com>
In-Reply-To: <200304080917.15648.tomlins@cam.org>
References: <20030408042239.053e1d23.akpm@digeo.com>
	<200304080917.15648.tomlins@cam.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2003 16:10:31.0545 (UTC) FILETIME=[60F19E90:01C2FDE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
> Hi,
> 
> This does not boot here.  I loop with the following message. 
> 
> i8042.c: Can't get irq 12 for AUX, unregistering the port.
> 
> irq 12 is used (correctly) by my 20267 ide card.  My mouse is
> usb and AUX is not used.
> 

Does the below patch help?  Probably not...

And does reverting
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm1/broken-out/earlier-keyboard-init.patch
fix it?

Thanks.

diff -puN drivers/input/serio/i8042.c~i8042-share-irqs drivers/input/serio/i8042.c
--- 25/drivers/input/serio/i8042.c~i8042-share-irqs	2003-04-08 09:05:16.000000000 -0700
+++ 25-akpm/drivers/input/serio/i8042.c	2003-04-08 09:05:59.000000000 -0700
@@ -235,7 +235,8 @@ static int i8042_open(struct serio *port
 		if (i8042_mux_open++)
 			return 0;
 
-	if (request_irq(values->irq, i8042_interrupt, 0, "i8042", NULL)) {
+	if (request_irq(values->irq, i8042_interrupt,
+			SA_SHIRQ, "i8042", NULL)) {
 		printk(KERN_ERR "i8042.c: Can't get irq %d for %s, unregistering the port.\n", values->irq, values->name);
 		values->exists = 0;
 		serio_unregister_port(port);
@@ -570,7 +571,7 @@ static int __init i8042_check_mux(struct
  * Check if AUX irq is available.
  */
 
-	if (request_irq(values->irq, i8042_interrupt, 0, "i8042", NULL))
+	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ, "i8042", NULL))
                 return -1;
 	free_irq(values->irq, NULL);
 
@@ -641,7 +642,7 @@ static int __init i8042_check_aux(struct
  * in trying to detect AUX presence.
  */
 
-	if (request_irq(values->irq, i8042_interrupt, 0, "i8042", NULL))
+	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ, "i8042", NULL))
                 return -1;
 	free_irq(values->irq, NULL);
 

_

