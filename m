Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269354AbRHGVxl>; Tue, 7 Aug 2001 17:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269331AbRHGVxd>; Tue, 7 Aug 2001 17:53:33 -0400
Received: from zeus.kernel.org ([209.10.41.242]:22984 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S269380AbRHGVxV>;
	Tue, 7 Aug 2001 17:53:21 -0400
Date: Tue, 7 Aug 2001 14:48:24 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compile failure: 2.2.19 + eide patch on PPC
Message-ID: <20010807144824.D22821@mikef-linux.matchmail.com>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010807122439.A22612@mikef-linux.matchmail.com> <Pine.LNX.4.33.0108071429460.30593-100000@tux.creighton.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108071429460.30593-100000@tux.creighton.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 02:43:53PM -0500, Phil Brutsche wrote:
> A long time ago, in a galaxy far, far way, someone said...
> > I am trying to compile 2.2.19 + ide.2.2.19.05042001.patch.  When doing this,
> > I get the errors below.
> These patches are broken for PPC machines and have been for some time.  I
> suppose I should file a bug report...
> 
> It's simple enough to fix however.
> 
> > but I want to try to get 2.2 working.  Is there another patch I need?
> 
> Yes - see below
> 
> > # gcc -v
> > Reading specs from /usr/lib/gcc-lib/powerpc-linux/2.95.2/specs
> > gcc version 2.95.2 20000220 (Debian GNU/Linux)
> >
> > Error:
> > make[3]: Entering directory /usr/src/lk2.2/2.2.19-ide-05042001/drivers/block'
> > cc -D__KERNEL__ -I/usr/src/lk2.2/2.2.19-ide-05042001/include -Wall
> > -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> > -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2
> > -Wno-uninitialized -mmultiple -mstring   -DEXPORT_SYMTAB -c ll_rw_blk.c
> > In file included from ll_rw_blk.c:28:
> > /usr/src/lk2.2/2.2.19-ide-05042001/include/asm/ide.h:53: parse error before *'
> > /usr/src/lk2.2/2.2.19-ide-05042001/include/asm/ide.h:56: warning: function
> > declaration isn't a prototype
> 
> You need an
> 
> #include <linux/ide.h>
> 
> before the
> 
> #include <asm/ide.h>
> 
> in ll_rw_blk.c.
> 
> Lines 27-30 of ll_rw_blk.c would end up looking like this:
> 
> #ifdef CONFIG_POWERMAC
> #include <linux/ide.h>
> #include <asm/ide.h>
> #endif
>

I'm still getting errors in 2.2.19-ide-05042001/include/asm/ide.h line 53
and 56.

> There are a number of other compilation problems in the code that will
> need similar "fixes".
> 

What more changes do I need to make?  

> Note that you will need the PCI fixup patch from
> http://www.cpu.lu/~mlan/linux/dev/pci.html if you want to be able to use a
> PCI IDE controller card, like the Promise Ultra33/Ultra66/Ultra100, in
> your PowerMac.  It seems that the PCI resources won't get seupt correctly
> by OpenFirmware otherwise.

Ok, patched, and above changes are applied.

I'm including a diff of include/asm/ide.h before and after patching.

I still get the errors:

In file included from ll_rw_blk.c:28:
/usr/src/lk2.2/2.2.19-ide-05042001/include/asm/ide.h:53: parse error before *'
/usr/src/lk2.2/2.2.19-ide-05042001/include/asm/ide.h:56: warning: function
declaration isn't a prototype

diff:
--- 2.2.19/include/asm/ide.h	Tue Aug  7 10:11:56 2001
+++ 2.2.19-ide-05042001/include/asm/ide.h	Tue Aug  7 13:45:17 2001
@@ -18,7 +18,7 @@
 #define MAX_HWIFS	4
 #endif
 
-typedef unsigned int ide_ioreg_t;
+#include <asm/hdreg.h>
 
 #ifdef __KERNEL__
 
@@ -50,16 +50,18 @@
         void        (*release_region)(ide_ioreg_t from,
                                       unsigned int extent);
         void        (*fix_driveid)(struct hd_driveid *id);
-        void        (*ide_init_hwif)(ide_ioreg_t *p,
-                                     ide_ioreg_t base,
-                                     int *irq); 
+        void        (*ide_init_hwif)(hw_regs_t *hw,
+                                     ide_ioreg_t data_port,
+                                     ide_ioreg_t ctrl_port,
+                                     int *irq);
 
         int io_base;
 };
 
 extern struct ide_machdep_calls ppc_ide_md;
 
-void ide_init_hwif_ports(ide_ioreg_t *p, ide_ioreg_t base, int *irq);
+void ide_init_hwif_ports (hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq);
+
 void ide_insw(ide_ioreg_t port, void *buf, int ns);
 void ide_outsw(ide_ioreg_t port, void *buf, int ns);
 void ppc_generic_ide_fix_driveid(struct hd_driveid *id);
@@ -81,6 +83,20 @@
 	return ppc_ide_md.default_io_base(index);
 }
 
+static __inline__ void ide_init_default_hwifs(void)
+{
+#ifndef CONFIG_BLK_DEV_IDEPCI
+	hw_regs_t hw;
+	int index;
+
+	for(index = 0; index < MAX_HWIFS; index++) {
+		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
+		hw.irq = ide_default_irq(ide_default_io_base(index));
+		ide_register_hw(&hw, NULL);
+	}
+#endif /* CONFIG_BLK_DEV_IDEPCI */
+}
+
 static __inline__ int ide_check_region (ide_ioreg_t from, unsigned int extent)
 {
 	return ppc_ide_md.check_region(from, extent);
@@ -96,7 +112,8 @@
 	ppc_ide_md.release_region(from, extent);
 }
 
-static __inline__ void ide_fix_driveid (struct hd_driveid *id) {
+static __inline__ void ide_fix_driveid (struct hd_driveid *id)
+{
         ppc_ide_md.fix_driveid(id);
 }
 
@@ -124,21 +141,13 @@
 	} b;
 } select_t;
 
-static __inline__ int ide_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
-			unsigned long flags, const char *device, void *dev_id)
-{
-	return request_irq(irq, handler, flags, device, dev_id);
-}			
-
-static __inline__ void ide_free_irq(unsigned int irq, void *dev_id)
-{
-	free_irq(irq, dev_id);
-}
+#define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
+#define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
 
 /*
  * The following are not needed for the non-m68k ports
  */
-#define ide_ack_intr(base, irq)		(1)
+#define ide_ack_intr(hwif)		(1)
 #define ide_release_lock(lock)		do {} while (0)
 #define ide_get_lock(lock, hdlr, data)	do {} while (0)
 
