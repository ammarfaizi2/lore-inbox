Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbTDHLZO (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 07:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTDHLZO (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 07:25:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36090 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261317AbTDHLZN (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 07:25:13 -0400
Date: Tue, 8 Apr 2003 13:36:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christer Weinigel <wingel@nano-system.com>,
       linux-i2c@pelican.tk.uni-linz.ac.at
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] fix drivers/i2c/scx200_i2c.c compilation
Message-ID: <20030408113646.GE5046@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.5.67:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/i2c/.scx200_i2c.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=scx200_i2c -DKBUILD_MODNAME=scx200_i2c 
-c -o drivers/i2c/scx200_i2c.o drivers/i2c/scx200_i2c.c
drivers/i2c/scx200_i2c.c:85: unknown field `name' specified in initializer
drivers/i2c/scx200_i2c.c:85: warning: initialization makes integer from 
pointer without a cast
drivers/i2c/scx200_i2c.c: In function `scx200_i2c_init':
drivers/i2c/scx200_i2c.c:113: structure has no member named `name'
make[2]: *** [drivers/i2c/scx200_i2c.o] Error 1


<--  snip  -->


The following patch is needed:

--- linux-2.5.67-notfull/drivers/i2c/scx200_i2c.c.old	2003-04-08 13:04:22.000000000 +0200
+++ linux-2.5.67-notfull/drivers/i2c/scx200_i2c.c	2003-04-08 13:07:14.000000000 +0200
@@ -82,9 +82,11 @@
 
 static struct i2c_adapter scx200_i2c_ops = {
 	.owner		   = THIS_MODULE,
-	.name              = "NatSemi SCx200 I2C",
 	.id		   = I2C_HW_B_VELLE,
 	.algo_data	   = &scx200_i2c_data,
+	.dev		   = {
+		.name	   = "NatSemi SCx200 I2C",
+	},
 };
 
 int scx200_i2c_init(void)
@@ -110,7 +112,7 @@
 
 	if (i2c_bit_add_bus(&scx200_i2c_ops) < 0) {
 		printk(KERN_ERR NAME ": adapter %s registration failed\n", 
-		       scx200_i2c_ops.name);
+		       scx200_i2c_ops.dev.name);
 		return -ENODEV;
 	}
 	


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

