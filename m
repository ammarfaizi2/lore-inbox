Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQKCSKu>; Fri, 3 Nov 2000 13:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129449AbQKCSKk>; Fri, 3 Nov 2000 13:10:40 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:36368 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129066AbQKCSKe>;
	Fri, 3 Nov 2000 13:10:34 -0500
Date: Fri, 3 Nov 2000 17:10:52 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: tytso@mit.edu, kaos@ocs.com.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <200011031509.eA3F9V719729@trampoline.thunk.org>
Message-ID: <Pine.LNX.4.21.0011031700150.17266-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>      * VGA Console can cause SMP deadlock when doing printk {CRITICAL}
>        (Keith Owens)

Still not fixed :-( Here is the patch again. Keith give it a try and tell
me if it solves your problems.

--- vgacon.c.orig	Tue Oct 24 18:45:58 2000
+++ vgacon.c	Tue Oct 24 19:08:51 2000
@@ -46,11 +46,13 @@
 #include <linux/malloc.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
+#include <linux/spinlock.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 
 #include <asm/io.h>
 
+static spinlock_t vga_lock = SPIN_LOCK_UNLOCKED;
 
 #define BLANK 0x0020
 
@@ -152,8 +154,7 @@
 	 * ddprintk might set the console position from interrupt
 	 * handlers, thus the write has to be IRQ-atomic.
 	 */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&vga_lock, flags);	
 
 #ifndef SLOW_VGA
 	v1 = reg + (val & 0xff00);
@@ -166,7 +167,7 @@
 	outb_p(reg+1, vga_video_port_reg);
 	outb_p(val & 0xff, vga_video_port_val);
 #endif
-	restore_flags(flags);
+	spin_unlock_irqrestore(&vga_lock, flags);
 }
 
 static const char __init *vgacon_startup(void)
@@ -415,7 +416,7 @@
 	if ((from == lastfrom) && (to == lastto)) return;
 	lastfrom = from; lastto = to;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&vga_lock, flags);
 	outb_p(0x0a, vga_video_port_reg);		/* Cursor start */
 	curs = inb_p(vga_video_port_val);
 	outb_p(0x0b, vga_video_port_reg);		/* Cursor end */
@@ -428,7 +429,7 @@
 	outb_p(curs, vga_video_port_val);
 	outb_p(0x0b, vga_video_port_reg);		/* Cursor end */
 	outb_p(cure, vga_video_port_val);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&vga_lock, flags);
 }
 
 static void vgacon_cursor(struct vc_data *c, int mode)
@@ -533,11 +534,11 @@
 {
 	/* save original values of VGA controller registers */
 	if(!vga_vesa_blanked) {
-		cli();
+		spin_lock_irq(&vga_lock);
 		vga_state.SeqCtrlIndex = inb_p(seq_port_reg);
 		vga_state.CrtCtrlIndex = inb_p(vga_video_port_reg);
 		vga_state.CrtMiscIO = inb_p(video_misc_rd);
-		sti();
+		spin_unlock_irq(&vga_lock);
 
 		outb_p(0x00,vga_video_port_reg);	/* HorizontalTotal */
 		vga_state.HorizontalTotal = inb_p(vga_video_port_val);
@@ -561,7 +562,7 @@
 
 	/* assure that video is enabled */
 	/* "0x20" is VIDEO_ENABLE_bit in register 01 of sequencer */
-	cli();
+	spin_lock_irq(&vga_lock);
 	outb_p(0x01,seq_port_reg);
 	outb_p(vga_state.ClockingMode | 0x20,seq_port_val);
 
@@ -598,13 +599,13 @@
 	/* restore both index registers */
 	outb_p(vga_state.SeqCtrlIndex,seq_port_reg);
 	outb_p(vga_state.CrtCtrlIndex,vga_video_port_reg);
-	sti();
+	spin_unlock_irq(&vga_lock);
 }
 
 static void vga_vesa_unblank(void)
 {
 	/* restore original values of VGA controller registers */
-	cli();
+	spin_lock_irq(&vga_lock);
 	outb_p(vga_state.CrtMiscIO,video_misc_wr);
 
 	outb_p(0x00,vga_video_port_reg);		/* HorizontalTotal */
@@ -629,7 +630,7 @@
 	/* restore index/control registers */
 	outb_p(vga_state.SeqCtrlIndex,seq_port_reg);
 	outb_p(vga_state.CrtCtrlIndex,vga_video_port_reg);
-	sti();
+	spin_unlock_irq(&vga_lock);
 }
 
 static void vga_pal_blank(void)
@@ -750,7 +751,7 @@
 		charmap += 4*cmapsz;
 #endif
 
-	cli();
+	spin_lock_irq(&vga_lock);
 	outb_p( 0x00, seq_port_reg );   /* First, the sequencer */
 	outb_p( 0x01, seq_port_val );   /* Synchronous reset */
 	outb_p( 0x02, seq_port_reg );
@@ -766,7 +767,7 @@
 	outb_p( 0x00, gr_port_val );    /* disable odd-even addressing */
 	outb_p( 0x06, gr_port_reg );
 	outb_p( 0x00, gr_port_val );    /* map start at A000:0000 */
-	sti();
+	spin_unlock_irq(&vga_lock);
 	
 	if (arg) {
 		if (set)
@@ -793,7 +794,7 @@
 		}
 	}
 	
-	cli();
+	spin_lock_irq(&vga_lock);
 	outb_p( 0x00, seq_port_reg );   /* First, the sequencer */
 	outb_p( 0x01, seq_port_val );   /* Synchronous reset */
 	outb_p( 0x02, seq_port_reg );
@@ -833,8 +834,7 @@
 		inb_p( video_port_status );
 		outb_p ( 0x20, attrib_port );
 	}
-	sti();
-
+	spin_unlock_irq(&vga_lock);
 	return 0;
 }
 
@@ -865,12 +865,12 @@
 	   registers; they are write-only on EGA, but it appears that they
 	   are all don't care bits on EGA, so I guess it doesn't matter. */
 
-	cli();
+	spin_lock_irq(&vga_lock);
 	outb_p( 0x07, vga_video_port_reg );		/* CRTC overflow register */
 	ovr = inb_p(vga_video_port_val);
 	outb_p( 0x09, vga_video_port_reg );		/* Font size register */
 	fsr = inb_p(vga_video_port_val);
-	sti();
+	spin_lock_irq(&vga_lock);
 
 	vde = maxscan & 0xff;			/* Vertical display end reg */
 	ovr = (ovr & 0xbd) +			/* Overflow register */
@@ -878,14 +878,14 @@
 	      ((maxscan & 0x200) >> 3);
 	fsr = (fsr & 0xe0) + (fontheight-1);    /*  Font size register */
 
-	cli();
+	spin_lock_irq(&vga_lock);
 	outb_p( 0x07, vga_video_port_reg );		/* CRTC overflow register */
 	outb_p( ovr, vga_video_port_val );
 	outb_p( 0x09, vga_video_port_reg );		/* Font size */
 	outb_p( fsr, vga_video_port_val );
 	outb_p( 0x12, vga_video_port_reg );		/* Vertical display limit */
 	outb_p( vde, vga_video_port_val );
-	sti();
+	spin_unlock_irq(&vga_lock);	
 
 	vc_resize_all(rows, 0);			/* Adjust console size */
 	return 0;



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
