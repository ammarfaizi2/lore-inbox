Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTJOA5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 20:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTJOA5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 20:57:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:717 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262038AbTJOA5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 20:57:20 -0400
Date: Tue, 14 Oct 2003 17:59:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7: saa7134 breaks on gcc 2.95
Message-Id: <20031014175938.04d94087.akpm@osdl.org>
In-Reply-To: <3F8C9705.26CA0B63@eyal.emu.id.au>
References: <3F8C9705.26CA0B63@eyal.emu.id.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>
> This compiler does not like dangling comma in funcs, so this patch
>  is needed. For:
> 
>  #define dprintk(fmt, arg...)    if (core_debug) \
>  	printk(KERN_DEBUG "%s/core: " fmt, dev->name, ## arg)
> 
>  Lines like this:
> 
>  	dprintk("hwinit1\n");
> 
>  should be hacked like this:
> 
>  	dprintk("hwinit1\n", "");

I couldn't find a sane way.  Ended up doing this:

diff -puN drivers/media/video/saa7134/saa7134-core.c~saa7134-build-fix drivers/media/video/saa7134/saa7134-core.c
--- 25/drivers/media/video/saa7134/saa7134-core.c~saa7134-build-fix	2003-10-13 22:43:15.000000000 -0700
+++ 25-akpm/drivers/media/video/saa7134/saa7134-core.c	2003-10-13 22:43:15.000000000 -0700
@@ -94,8 +94,13 @@ MODULE_PARM_DESC(latency,"pci latency ti
 struct list_head  saa7134_devlist;
 unsigned int      saa7134_devcount;
 
-#define dprintk(fmt, arg...)	if (core_debug) \
-	printk(KERN_DEBUG "%s/core: " fmt, dev->name, ## arg)
+#define dprintk(fmt, arg...)						\
+	do {								\
+		if (core_debug) {					\
+			printk(KERN_DEBUG "%s/core: ", dev->name);	\
+			printk(fmt, ## arg);				\
+		}							\
+	} while (0)
 
 /* ------------------------------------------------------------------ */
 /* debug help functions                                               */

_

