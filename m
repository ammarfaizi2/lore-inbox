Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSGIOnw>; Tue, 9 Jul 2002 10:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSGIOnw>; Tue, 9 Jul 2002 10:43:52 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:43043 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S315442AbSGIOnu>; Tue, 9 Jul 2002 10:43:50 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A783A7B56@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Cc: "'axboe@suse.de'" <axboe@suse.de>
Subject: (RE:  using 2.5.25 with IDE) On sparc64..... 
Date: Tue, 9 Jul 2002 09:46:10 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Contrary to the popular belief 2.5.25 has only Martin's IDE-93
> and has broken locking...
> 
> If you want to run IDE on 2.5.25 get and apply:

I am running a Sparc64 Ultra5 with IDE [insert flame here] which uses a
CMD646 PCI controller, and since at least 2.5.20 it has not booted.  I
currently run 2.5.13, which boots and runs fine, and all is well with 2.4
series.  

I have tried current bk, with IDE 94,95, and 96 applied with the same
result, all hang after printing the partition list of the hard drive.  

I most recently tried Jen's 2.4 forward port, with about the same result,
though the following errors were printed before the kernel hung.  (BTW,
Jen's a modified asm-sparc64/ide.h is below if you want to keep with your
2.4 port)

I am running in PIO mode, and saw that may be broken?  And I realize that
there is probably not much interest/need for IDE to get working on this yet,
but I am wondering if you can point to some ideas to help me along with
figuring out what's going on.  I am going to insert some printk's to see if
I can narrow down where I am hanging at, and if you have any thoughts on
where's the best place to look, I'd be most appreciative.

Thanks
Bruce H.

Patch below to get 2.4 forward port of IDE to compile on Sparc64...
--- linus-2.5/include/asm-sparc64/ide.h	Tue Jul  9 08:53:10 2002
+++ sparctest/include/asm-sparc64/ide.h	Tue Jul  9 09:11:24 2002
@@ -64,7 +64,11 @@
 	for (index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0,
NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
+#if defined(CONFIG_IDE_25)
 		ide_register_hw(&hw);
+#elif defined(CONFIG_IDE_24)
+		ide_register_hw(&hw, NULL);
+#endif
 	}
 #endif
 }
@@ -178,6 +182,20 @@
 #endif
 }
 
+#define ide_request_irq(irq,hand,flg,dev,id)
request_irq((irq),(hand),(flg),(dev),(id))
+#define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
+#define ide_check_region(from,extent)		check_region((from),
(extent))
+#define ide_request_region(from,extent,name)	request_region((from),
(extent), (name))
+#define ide_release_region(from,extent)
release_region((from), (extent))
+
+/*
+ * The following are not needed for the non-m68k ports
+ */
+#define ide_ack_intr(hwif)		(1)
+#define ide_fix_driveid(id)		do {} while (0)
+#define ide_release_lock(lock)		do {} while (0)
+#define ide_get_lock(lock, hdlr, data)	do {} while (0)
+ 
 #endif /* __KERNEL__ */
 
 #endif /* _SPARC64_IDE_H */
