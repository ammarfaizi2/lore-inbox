Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTFGQJi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTFGQJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:09:38 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32990 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263205AbTFGQJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:09:35 -0400
Date: Sat, 7 Jun 2003 18:22:39 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Jean Tourrilhes <jt@bougret.hpl.hp.com>, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <trivial@rustcorp.com.au>
Subject: Re: [patch] fix vlsi_ir.c compile if !CONFIG_PROC_FS
In-Reply-To: <20030607152434.GQ15311@fs.tum.de>
Message-ID: <Pine.SOL.4.30.0306071815120.6449-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apply something like this:

--- linux-2.5.70-bk11/include/proc_fs.h	Fri Jun  6 18:43:49 2003
+++ linux/include/proc_fs.h	Sat Jun  7 18:11:22 2003
@@ -205,7 +205,7 @@
 static inline struct proc_dir_entry *create_proc_entry(const char *name,
 	mode_t mode, struct proc_dir_entry *parent) { return NULL; }

-static inline void remove_proc_entry(const char *name, struct proc_dir_entry *parent) {};
+#define remove_proc_entry(name, parent)	/* nothing */
 static inline struct proc_dir_entry *proc_symlink(const char *name,
 		struct proc_dir_entry *parent,char *dest) {return NULL;}
 static inline struct proc_dir_entry *proc_mknod(const char *name,mode_t mode,

And you wil not have to readd #ifdef/#endif pair.

I've seen Sam's mail but this is generic solution to quiet compiler
and will work for any remove_proc_entry() user.

Thanks,
--
Bartlomiej

On Sat, 7 Jun 2003, Adrian Bunk wrote:

> I got the following compile error with !CONFIG_PROC_FS:
>
> <--  snip  -->
>
> ...
>   CC      drivers/net/irda/vlsi_ir.o
> drivers/net/irda/vlsi_ir.c: In function `vlsi_irda_probe':
> drivers/net/irda/vlsi_ir.c:1826: warning: label `out_unregister' defined but not used
> drivers/net/irda/vlsi_ir.c: In function `vlsi_mod_exit':
> drivers/net/irda/vlsi_ir.c:2047: `PROC_DIR' undeclared (first use in this function)
> drivers/net/irda/vlsi_ir.c:2047: (Each undeclared identifier is reported only once
> drivers/net/irda/vlsi_ir.c:2047: for each function it appears in.)
> make[3]: *** [drivers/net/irda/vlsi_ir.o] Error 1
>
> <--  snip  -->
>
>
> The following patch fixes it:
>
>
> --- linux-2.5.70-mm5/drivers/net/irda/vlsi_ir.c.old	2003-06-07 17:01:26.000000000 +0200
> +++ linux-2.5.70-mm5/drivers/net/irda/vlsi_ir.c	2003-06-07 17:02:25.000000000 +0200
> @@ -2044,7 +2044,11 @@
>  static void __exit vlsi_mod_exit(void)
>  {
>  	pci_unregister_driver(&vlsi_irda_driver);
> +
> +#ifdef CONFIG_PROC_FS
>  	remove_proc_entry(PROC_DIR, 0);
> +#endif
> +
>  }
>
>  module_init(vlsi_mod_init);

