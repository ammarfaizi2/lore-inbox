Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130496AbRCIM4J>; Fri, 9 Mar 2001 07:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRCIM4A>; Fri, 9 Mar 2001 07:56:00 -0500
Received: from apegate.roma1.infn.it ([141.108.7.31]:35575 "EHLO sensei.ape")
	by vger.kernel.org with ESMTP id <S130496AbRCIMzs>;
	Fri, 9 Mar 2001 07:55:48 -0500
Date: Fri, 9 Mar 2001 13:53:53 +0100 (CET)
From: "davide.rossetti" <rossetti@roma1.infn.it>
Reply-To: <davide.rossetti@roma1.infn.it>
To: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.2.19pre16 - ip auto config problem
In-Reply-To: <E14TWGf-00013r-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103091339120.16723-100000@sensei.ape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
after a long time, I tried to upgrade the kernel I use to boot some
diskless PIII Katmai, C-PCI hosts (attached lspci -vv) with DEC ethernet
chips.

I had trouble to use "IP auto configure" feature... It seems like it is
skipped; even more, net/core/dev.c:net_dev_init() call by
drivers/block/genhd.c:device_setup() is never called.

I remember that:
1) the IDE hd scan was done, with no devices found (it is diskless:-)
2) the net device driver was started, and it found 2 DEC chips

but a few lines later NFS root couldn't be mounted as no NFS server was
set... anyway I had activated debug stuff in ipconfig.c and put a lot
of printk/console_print in dev.c and none of them was displayed so I guess
that code was never called actually.

then I added a bunch of printk/console_print in device_setup(), especially
before blk_dev_init

-------------------------------------------
#ifdef CONFIG_PARPORT
	parport_init();
#endif
	chr_dev_init();
	console_print("before blk_dev_init()\n");
	blk_dev_init();
	sti();
#ifdef CONFIG_I2O
	i2o_init();
#endif
#ifdef CONFIG_BLK_DEV_DAC960
	DAC960_Initialize();
#endif
#ifdef CONFIG_FC4_SOC
	/* This has to be done before scsi_dev_init */
	soc_probe();
#endif
#ifdef CONFIG_SCSI
	console_print("before scsi_dev_init()\n");
	scsi_dev_init();
#endif
#ifdef CONFIG_BLK_CPQ_DA
	cpqarray_init();
#endif
#ifdef CONFIG_BLK_CPQ_CISS_DA
        cciss_init();
#endif
#ifdef CONFIG_NET
	console_print("before net_dev_init()\n");
	net_dev_init();
#endif
------------------------------------------------

(I used console_print as I was scared it could mess with irq by the sti()
code...)

and all of a sudded it was all ok, I got all the printk/console_print...etc.
I got NFS root mounting... everything OK!

hope it is useful to you.

ciao


-- 
+------------------------------------------------------------------+
|Rossetti Davide   INFN - Sezione Roma I - gruppo V, prog. APEmille|
|                  web    : http://apegate.roma1.infn.it/~rossetti |
|    """""         E-mail : davide.rossetti@roma1.infn.it          |
|    |o o|         phone  : (+39)-06-49914412                      |
|--o00O-O00o--     fax    : (+39)-06-49914423   (+39)-06-4957697   |
|                  address: Dipartimento di Fisica (V.E.)          |
|                           Universita' di Roma "La Sapienza"      |
|                           P.le Aldo Moro,5 I - 00185 Roma - Italy|
|  gnupg pub. key: http://apegate.roma1.infn.it/~rossetti/gnupg.txt|
|                                                                  |
|"Outside of a dog,a book is a man's best friend. Inside of a dog, |
| it's too dark to read." - Groucho Marx                           |
+------------------------------------------------------------------+

