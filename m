Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbTAZPM4>; Sun, 26 Jan 2003 10:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbTAZPM4>; Sun, 26 Jan 2003 10:12:56 -0500
Received: from [195.208.223.236] ([195.208.223.236]:11136 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266936AbTAZPMn>; Sun, 26 Jan 2003 10:12:43 -0500
Date: Sun, 26 Jan 2003 18:13:26 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: geert@linux-m68k.org, mj@ucw.cz, Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030126181326.A799@localhost.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well known problem - the legacy in/out functions do not work on machines
that have separate ioport address space for each root level PCI bus.
On alpha, we didn't care about this too much until recently: older
platforms have the dedicated hose (root bus) #0 with the IO port
offset 0 (where the ISA bridge with all legacy stuff resides), and
the graphic console used to be supported by firmware only on that hose.

But on modern systems (titan and marvel), the firmware supports vga
on *any* bus. Even worse, marvel doesn't have dedicated "legacy"
hose at all.
So we have to decode and fix IO port addresses inside our in/out
functions, which is awful.

The patch is pretty straightforward - it adds "vga_" prefix to every
in/out call in vgacon.c, adds __HAVE_ARCH_IOPORT_REMAP hook and
falls back to current in/out stuff if the latter is undefined.

I think it might be useful for other 64-bit architectures as well.

Thanks to Jeff for coding this up and testing on privateer
and marvel.

Ivan.

--- 2.5.59/drivers/video/console/vgacon.c	Tue Dec 10 09:07:11 2002
+++ linux/drivers/video/console/vgacon.c	Sat Jan 25 21:27:43 2003
@@ -152,13 +152,13 @@ static inline void write_vga(unsigned ch
 #ifndef SLOW_VGA
 	v1 = reg + (val & 0xff00);
 	v2 = reg + 1 + ((val << 8) & 0xff00);
-	outw(v1, vga_video_port_reg);
-	outw(v2, vga_video_port_reg);
+	vga_outw(v1, vga_video_port_reg);
+	vga_outw(v2, vga_video_port_reg);
 #else
-	outb_p(reg, vga_video_port_reg);
-	outb_p(val >> 8, vga_video_port_val);
-	outb_p(reg+1, vga_video_port_reg);
-	outb_p(val & 0xff, vga_video_port_val);
+	vga_outb_p(reg, vga_video_port_reg);
+	vga_outb_p(val >> 8, vga_video_port_val);
+	vga_outb_p(reg+1, vga_video_port_reg);
+	vga_outb_p(val & 0xff, vga_video_port_val);
 #endif
 	spin_unlock_irqrestore(&vga_lock, flags);
 }
@@ -247,8 +247,8 @@ static const char __init *vgacon_startup
 				 */
 				vga_vram_base = 0xa0000;
 				vga_vram_end = 0xb0000;
-				outb_p (6, 0x3ce) ;
-				outb_p (6, 0x3cf) ;
+				vga_outb_p (6, 0x3ce) ;
+				vga_outb_p (6, 0x3cf) ;
 #endif
 
 				/*
@@ -258,20 +258,20 @@ static const char __init *vgacon_startup
 				 */
 
 				for (i=0; i<16; i++) {
-					inb_p (0x3da) ;
-					outb_p (i, 0x3c0) ;
-					outb_p (i, 0x3c0) ;
+					vga_inb_p (0x3da) ;
+					vga_outb_p (i, 0x3c0) ;
+					vga_outb_p (i, 0x3c0) ;
 				}
-				outb_p (0x20, 0x3c0) ;
+				vga_outb_p (0x20, 0x3c0) ;
 
 				/* now set the DAC registers back to their
 				 * default values */
 
 				for (i=0; i<16; i++) {
-					outb_p (color_table[i], 0x3c8) ;
-					outb_p (default_red[i], 0x3c9) ;
-					outb_p (default_grn[i], 0x3c9) ;
-					outb_p (default_blu[i], 0x3c9) ;
+					vga_outb_p (color_table[i], 0x3c8) ;
+					vga_outb_p (default_red[i], 0x3c9) ;
+					vga_outb_p (default_grn[i], 0x3c9) ;
+					vga_outb_p (default_blu[i], 0x3c9) ;
 				}
 			}
 		}
@@ -417,18 +417,18 @@ static void vgacon_set_cursor_size(int x
 	lastfrom = from; lastto = to;
 
 	spin_lock_irqsave(&vga_lock, flags);
-	outb_p(0x0a, vga_video_port_reg);		/* Cursor start */
-	curs = inb_p(vga_video_port_val);
-	outb_p(0x0b, vga_video_port_reg);		/* Cursor end */
-	cure = inb_p(vga_video_port_val);
+	vga_outb_p(0x0a, vga_video_port_reg);		/* Cursor start */
+	curs = vga_inb_p(vga_video_port_val);
+	vga_outb_p(0x0b, vga_video_port_reg);		/* Cursor end */
+	cure = vga_inb_p(vga_video_port_val);
 
 	curs = (curs & 0xc0) | from;
 	cure = (cure & 0xe0) | to;
 
-	outb_p(0x0a, vga_video_port_reg);		/* Cursor start */
-	outb_p(curs, vga_video_port_val);
-	outb_p(0x0b, vga_video_port_reg);		/* Cursor end */
-	outb_p(cure, vga_video_port_val);
+	vga_outb_p(0x0a, vga_video_port_reg);		/* Cursor start */
+	vga_outb_p(curs, vga_video_port_val);
+	vga_outb_p(0x0b, vga_video_port_reg);		/* Cursor end */
+	vga_outb_p(cure, vga_video_port_val);
 	spin_unlock_irqrestore(&vga_lock, flags);
 }
 
@@ -495,10 +495,10 @@ static void vga_set_palette(struct vc_da
 	int i, j ;
 
 	for (i=j=0; i<16; i++) {
-		outb_p (table[i], dac_reg) ;
-		outb_p (c->vc_palette[j++]>>2, dac_val) ;
-		outb_p (c->vc_palette[j++]>>2, dac_val) ;
-		outb_p (c->vc_palette[j++]>>2, dac_val) ;
+		vga_outb_p (table[i], dac_reg) ;
+		vga_outb_p (c->vc_palette[j++]>>2, dac_val) ;
+		vga_outb_p (c->vc_palette[j++]>>2, dac_val) ;
+		vga_outb_p (c->vc_palette[j++]>>2, dac_val) ;
 	}
 }
 
@@ -535,40 +535,40 @@ static void vga_vesa_blank(int mode)
 	/* save original values of VGA controller registers */
 	if(!vga_vesa_blanked) {
 		spin_lock_irq(&vga_lock);
-		vga_state.SeqCtrlIndex = inb_p(seq_port_reg);
-		vga_state.CrtCtrlIndex = inb_p(vga_video_port_reg);
-		vga_state.CrtMiscIO = inb_p(video_misc_rd);
+		vga_state.SeqCtrlIndex = vga_inb_p(seq_port_reg);
+		vga_state.CrtCtrlIndex = vga_inb_p(vga_video_port_reg);
+		vga_state.CrtMiscIO = vga_inb_p(video_misc_rd);
 		spin_unlock_irq(&vga_lock);
 
-		outb_p(0x00,vga_video_port_reg);	/* HorizontalTotal */
-		vga_state.HorizontalTotal = inb_p(vga_video_port_val);
-		outb_p(0x01,vga_video_port_reg);	/* HorizDisplayEnd */
-		vga_state.HorizDisplayEnd = inb_p(vga_video_port_val);
-		outb_p(0x04,vga_video_port_reg);	/* StartHorizRetrace */
-		vga_state.StartHorizRetrace = inb_p(vga_video_port_val);
-		outb_p(0x05,vga_video_port_reg);	/* EndHorizRetrace */
-		vga_state.EndHorizRetrace = inb_p(vga_video_port_val);
-		outb_p(0x07,vga_video_port_reg);	/* Overflow */
-		vga_state.Overflow = inb_p(vga_video_port_val);
-		outb_p(0x10,vga_video_port_reg);	/* StartVertRetrace */
-		vga_state.StartVertRetrace = inb_p(vga_video_port_val);
-		outb_p(0x11,vga_video_port_reg);	/* EndVertRetrace */
-		vga_state.EndVertRetrace = inb_p(vga_video_port_val);
-		outb_p(0x17,vga_video_port_reg);	/* ModeControl */
-		vga_state.ModeControl = inb_p(vga_video_port_val);
-		outb_p(0x01,seq_port_reg);		/* ClockingMode */
-		vga_state.ClockingMode = inb_p(seq_port_val);
+		vga_outb_p(0x00,vga_video_port_reg);	/* HorizontalTotal */
+		vga_state.HorizontalTotal = vga_inb_p(vga_video_port_val);
+		vga_outb_p(0x01,vga_video_port_reg);	/* HorizDisplayEnd */
+		vga_state.HorizDisplayEnd = vga_inb_p(vga_video_port_val);
+		vga_outb_p(0x04,vga_video_port_reg);	/* StartHorizRetrace */
+		vga_state.StartHorizRetrace = vga_inb_p(vga_video_port_val);
+		vga_outb_p(0x05,vga_video_port_reg);	/* EndHorizRetrace */
+		vga_state.EndHorizRetrace = vga_inb_p(vga_video_port_val);
+		vga_outb_p(0x07,vga_video_port_reg);	/* Overflow */
+		vga_state.Overflow = vga_inb_p(vga_video_port_val);
+		vga_outb_p(0x10,vga_video_port_reg);	/* StartVertRetrace */
+		vga_state.StartVertRetrace = vga_inb_p(vga_video_port_val);
+		vga_outb_p(0x11,vga_video_port_reg);	/* EndVertRetrace */
+		vga_state.EndVertRetrace = vga_inb_p(vga_video_port_val);
+		vga_outb_p(0x17,vga_video_port_reg);	/* ModeControl */
+		vga_state.ModeControl = vga_inb_p(vga_video_port_val);
+		vga_outb_p(0x01,seq_port_reg);		/* ClockingMode */
+		vga_state.ClockingMode = vga_inb_p(seq_port_val);
 	}
 
 	/* assure that video is enabled */
 	/* "0x20" is VIDEO_ENABLE_bit in register 01 of sequencer */
 	spin_lock_irq(&vga_lock);
-	outb_p(0x01,seq_port_reg);
-	outb_p(vga_state.ClockingMode | 0x20,seq_port_val);
+	vga_outb_p(0x01,seq_port_reg);
+	vga_outb_p(vga_state.ClockingMode | 0x20,seq_port_val);
 
 	/* test for vertical retrace in process.... */
 	if ((vga_state.CrtMiscIO & 0x80) == 0x80)
-		outb_p(vga_state.CrtMiscIO & 0xef,video_misc_wr);
+		vga_outb_p(vga_state.CrtMiscIO & 0xef,video_misc_wr);
 
 	/*
 	 * Set <End of vertical retrace> to minimum (0) and
@@ -576,12 +576,12 @@ static void vga_vesa_blank(int mode)
 	 * Result: turn off vertical sync (VSync) pulse.
 	 */
 	if (mode & VESA_VSYNC_SUSPEND) {
-		outb_p(0x10,vga_video_port_reg);	/* StartVertRetrace */
-		outb_p(0xff,vga_video_port_val); 	/* maximum value */
-		outb_p(0x11,vga_video_port_reg);	/* EndVertRetrace */
-		outb_p(0x40,vga_video_port_val);	/* minimum (bits 0..3)  */
-		outb_p(0x07,vga_video_port_reg);	/* Overflow */
-		outb_p(vga_state.Overflow | 0x84,vga_video_port_val); /* bits 9,10 of vert. retrace */
+		vga_outb_p(0x10,vga_video_port_reg);	/* StartVertRetrace */
+		vga_outb_p(0xff,vga_video_port_val); 	/* maximum value */
+		vga_outb_p(0x11,vga_video_port_reg);	/* EndVertRetrace */
+		vga_outb_p(0x40,vga_video_port_val);	/* minimum (bits 0..3)  */
+		vga_outb_p(0x07,vga_video_port_reg);	/* Overflow */
+		vga_outb_p(vga_state.Overflow | 0x84,vga_video_port_val); /* bits 9,10 of vert. retrace */
 	}
 
 	if (mode & VESA_HSYNC_SUSPEND) {
@@ -590,15 +590,15 @@ static void vga_vesa_blank(int mode)
 		 *  <Start of horizontal Retrace> to maximum
 		 * Result: turn off horizontal sync (HSync) pulse.
 		 */
-		outb_p(0x04,vga_video_port_reg);	/* StartHorizRetrace */
-		outb_p(0xff,vga_video_port_val);	/* maximum */
-		outb_p(0x05,vga_video_port_reg);	/* EndHorizRetrace */
-		outb_p(0x00,vga_video_port_val);	/* minimum (0) */
+		vga_outb_p(0x04,vga_video_port_reg);	/* StartHorizRetrace */
+		vga_outb_p(0xff,vga_video_port_val);	/* maximum */
+		vga_outb_p(0x05,vga_video_port_reg);	/* EndHorizRetrace */
+		vga_outb_p(0x00,vga_video_port_val);	/* minimum (0) */
 	}
 
 	/* restore both index registers */
-	outb_p(vga_state.SeqCtrlIndex,seq_port_reg);
-	outb_p(vga_state.CrtCtrlIndex,vga_video_port_reg);
+	vga_outb_p(vga_state.SeqCtrlIndex,seq_port_reg);
+	vga_outb_p(vga_state.CrtCtrlIndex,vga_video_port_reg);
 	spin_unlock_irq(&vga_lock);
 }
 
@@ -606,30 +606,30 @@ static void vga_vesa_unblank(void)
 {
 	/* restore original values of VGA controller registers */
 	spin_lock_irq(&vga_lock);
-	outb_p(vga_state.CrtMiscIO,video_misc_wr);
+	vga_outb_p(vga_state.CrtMiscIO,video_misc_wr);
 
-	outb_p(0x00,vga_video_port_reg);		/* HorizontalTotal */
-	outb_p(vga_state.HorizontalTotal,vga_video_port_val);
-	outb_p(0x01,vga_video_port_reg);		/* HorizDisplayEnd */
-	outb_p(vga_state.HorizDisplayEnd,vga_video_port_val);
-	outb_p(0x04,vga_video_port_reg);		/* StartHorizRetrace */
-	outb_p(vga_state.StartHorizRetrace,vga_video_port_val);
-	outb_p(0x05,vga_video_port_reg);		/* EndHorizRetrace */
-	outb_p(vga_state.EndHorizRetrace,vga_video_port_val);
-	outb_p(0x07,vga_video_port_reg);		/* Overflow */
-	outb_p(vga_state.Overflow,vga_video_port_val);
-	outb_p(0x10,vga_video_port_reg);		/* StartVertRetrace */
-	outb_p(vga_state.StartVertRetrace,vga_video_port_val);
-	outb_p(0x11,vga_video_port_reg);		/* EndVertRetrace */
-	outb_p(vga_state.EndVertRetrace,vga_video_port_val);
-	outb_p(0x17,vga_video_port_reg);		/* ModeControl */
-	outb_p(vga_state.ModeControl,vga_video_port_val);
-	outb_p(0x01,seq_port_reg);		/* ClockingMode */
-	outb_p(vga_state.ClockingMode,seq_port_val);
+	vga_outb_p(0x00,vga_video_port_reg);		/* HorizontalTotal */
+	vga_outb_p(vga_state.HorizontalTotal,vga_video_port_val);
+	vga_outb_p(0x01,vga_video_port_reg);		/* HorizDisplayEnd */
+	vga_outb_p(vga_state.HorizDisplayEnd,vga_video_port_val);
+	vga_outb_p(0x04,vga_video_port_reg);		/* StartHorizRetrace */
+	vga_outb_p(vga_state.StartHorizRetrace,vga_video_port_val);
+	vga_outb_p(0x05,vga_video_port_reg);		/* EndHorizRetrace */
+	vga_outb_p(vga_state.EndHorizRetrace,vga_video_port_val);
+	vga_outb_p(0x07,vga_video_port_reg);		/* Overflow */
+	vga_outb_p(vga_state.Overflow,vga_video_port_val);
+	vga_outb_p(0x10,vga_video_port_reg);		/* StartVertRetrace */
+	vga_outb_p(vga_state.StartVertRetrace,vga_video_port_val);
+	vga_outb_p(0x11,vga_video_port_reg);		/* EndVertRetrace */
+	vga_outb_p(vga_state.EndVertRetrace,vga_video_port_val);
+	vga_outb_p(0x17,vga_video_port_reg);		/* ModeControl */
+	vga_outb_p(vga_state.ModeControl,vga_video_port_val);
+	vga_outb_p(0x01,seq_port_reg);		/* ClockingMode */
+	vga_outb_p(vga_state.ClockingMode,seq_port_val);
 
 	/* restore index/control registers */
-	outb_p(vga_state.SeqCtrlIndex,seq_port_reg);
-	outb_p(vga_state.CrtCtrlIndex,vga_video_port_reg);
+	vga_outb_p(vga_state.SeqCtrlIndex,seq_port_reg);
+	vga_outb_p(vga_state.CrtCtrlIndex,vga_video_port_reg);
 	spin_unlock_irq(&vga_lock);
 }
 
@@ -638,10 +638,10 @@ static void vga_pal_blank(void)
 	int i;
 
 	for (i=0; i<16; i++) {
-		outb_p (i, dac_reg) ;
-		outb_p (0, dac_val) ;
-		outb_p (0, dac_val) ;
-		outb_p (0, dac_val) ;
+		vga_outb_p (i, dac_reg) ;
+		vga_outb_p (0, dac_val) ;
+		vga_outb_p (0, dac_val) ;
+		vga_outb_p (0, dac_val) ;
 	}
 }
 
@@ -752,21 +752,21 @@ vgacon_do_font_op(char *arg, int set, in
 #endif
 
 	spin_lock_irq(&vga_lock);
-	outb_p( 0x00, seq_port_reg );   /* First, the sequencer */
-	outb_p( 0x01, seq_port_val );   /* Synchronous reset */
-	outb_p( 0x02, seq_port_reg );
-	outb_p( 0x04, seq_port_val );   /* CPU writes only to map 2 */
-	outb_p( 0x04, seq_port_reg );
-	outb_p( 0x07, seq_port_val );   /* Sequential addressing */
-	outb_p( 0x00, seq_port_reg );
-	outb_p( 0x03, seq_port_val );   /* Clear synchronous reset */
-
-	outb_p( 0x04, gr_port_reg );    /* Now, the graphics controller */
-	outb_p( 0x02, gr_port_val );    /* select map 2 */
-	outb_p( 0x05, gr_port_reg );
-	outb_p( 0x00, gr_port_val );    /* disable odd-even addressing */
-	outb_p( 0x06, gr_port_reg );
-	outb_p( 0x00, gr_port_val );    /* map start at A000:0000 */
+	vga_outb_p( 0x00, seq_port_reg );   /* First, the sequencer */
+	vga_outb_p( 0x01, seq_port_val );   /* Synchronous reset */
+	vga_outb_p( 0x02, seq_port_reg );
+	vga_outb_p( 0x04, seq_port_val );   /* CPU writes only to map 2 */
+	vga_outb_p( 0x04, seq_port_reg );
+	vga_outb_p( 0x07, seq_port_val );   /* Sequential addressing */
+	vga_outb_p( 0x00, seq_port_reg );
+	vga_outb_p( 0x03, seq_port_val );   /* Clear synchronous reset */
+
+	vga_outb_p( 0x04, gr_port_reg );    /* Now, the graphics controller */
+	vga_outb_p( 0x02, gr_port_val );    /* select map 2 */
+	vga_outb_p( 0x05, gr_port_reg );
+	vga_outb_p( 0x00, gr_port_val );    /* disable odd-even addressing */
+	vga_outb_p( 0x06, gr_port_reg );
+	vga_outb_p( 0x00, gr_port_val );    /* map start at A000:0000 */
 	spin_unlock_irq(&vga_lock);
 	
 	if (arg) {
@@ -795,25 +795,25 @@ vgacon_do_font_op(char *arg, int set, in
 	}
 	
 	spin_lock_irq(&vga_lock);
-	outb_p( 0x00, seq_port_reg );   /* First, the sequencer */
-	outb_p( 0x01, seq_port_val );   /* Synchronous reset */
-	outb_p( 0x02, seq_port_reg );
-	outb_p( 0x03, seq_port_val );   /* CPU writes to maps 0 and 1 */
-	outb_p( 0x04, seq_port_reg );
-	outb_p( 0x03, seq_port_val );   /* odd-even addressing */
+	vga_outb_p( 0x00, seq_port_reg );   /* First, the sequencer */
+	vga_outb_p( 0x01, seq_port_val );   /* Synchronous reset */
+	vga_outb_p( 0x02, seq_port_reg );
+	vga_outb_p( 0x03, seq_port_val );   /* CPU writes to maps 0 and 1 */
+	vga_outb_p( 0x04, seq_port_reg );
+	vga_outb_p( 0x03, seq_port_val );   /* odd-even addressing */
 	if (set) {
-		outb_p( 0x03, seq_port_reg ); /* Character Map Select */
-		outb_p( font_select, seq_port_val );
+		vga_outb_p( 0x03, seq_port_reg ); /* Character Map Select */
+		vga_outb_p( font_select, seq_port_val );
 	}
-	outb_p( 0x00, seq_port_reg );
-	outb_p( 0x03, seq_port_val );   /* clear synchronous reset */
+	vga_outb_p( 0x00, seq_port_reg );
+	vga_outb_p( 0x03, seq_port_val );   /* clear synchronous reset */
 
-	outb_p( 0x04, gr_port_reg );    /* Now, the graphics controller */
-	outb_p( 0x00, gr_port_val );    /* select map 0 for CPU */
-	outb_p( 0x05, gr_port_reg );
-	outb_p( 0x10, gr_port_val );    /* enable even-odd addressing */
-	outb_p( 0x06, gr_port_reg );
-	outb_p( beg, gr_port_val );     /* map starts at b800:0 or b000:0 */
+	vga_outb_p( 0x04, gr_port_reg );    /* Now, the graphics controller */
+	vga_outb_p( 0x00, gr_port_val );    /* select map 0 for CPU */
+	vga_outb_p( 0x05, gr_port_reg );
+	vga_outb_p( 0x10, gr_port_val );    /* enable even-odd addressing */
+	vga_outb_p( 0x06, gr_port_reg );
+	vga_outb_p( beg, gr_port_val );     /* map starts at b800:0 or b000:0 */
 
 	/* if 512 char mode is already enabled don't re-enable it. */
 	if ((set)&&(ch512!=vga_512_chars)) {	/* attribute controller */
@@ -826,13 +826,13 @@ vgacon_do_font_op(char *arg, int set, in
 		vga_512_chars=ch512;
 		/* 256-char: enable intensity bit
 		   512-char: disable intensity bit */
-		inb_p( video_port_status );	/* clear address flip-flop */
-		outb_p ( 0x12, attrib_port ); /* color plane enable register */
-		outb_p ( ch512 ? 0x07 : 0x0f, attrib_port );
+		vga_inb_p( video_port_status );	/* clear address flip-flop */
+		vga_outb_p ( 0x12, attrib_port ); /* color plane enable register */
+		vga_outb_p ( ch512 ? 0x07 : 0x0f, attrib_port );
 		/* Wilton (1987) mentions the following; I don't know what
 		   it means, but it works, and it appears necessary */
-		inb_p( video_port_status );
-		outb_p ( 0x20, attrib_port );
+		vga_inb_p( video_port_status );
+		vga_outb_p ( 0x20, attrib_port );
 	}
 	spin_unlock_irq(&vga_lock);
 	return 0;
@@ -866,10 +866,10 @@ vgacon_adjust_height(unsigned fontheight
 	   are all don't care bits on EGA, so I guess it doesn't matter. */
 
 	spin_lock_irq(&vga_lock);
-	outb_p( 0x07, vga_video_port_reg );		/* CRTC overflow register */
-	ovr = inb_p(vga_video_port_val);
-	outb_p( 0x09, vga_video_port_reg );		/* Font size register */
-	fsr = inb_p(vga_video_port_val);
+	vga_outb_p( 0x07, vga_video_port_reg );	/* CRTC overflow register */
+	ovr = vga_inb_p(vga_video_port_val);
+	vga_outb_p( 0x09, vga_video_port_reg );	/* Font size register */
+	fsr = vga_inb_p(vga_video_port_val);
 	spin_unlock_irq(&vga_lock);
 
 	vde = maxscan & 0xff;			/* Vertical display end reg */
@@ -879,12 +879,12 @@ vgacon_adjust_height(unsigned fontheight
 	fsr = (fsr & 0xe0) + (fontheight-1);    /*  Font size register */
 
 	spin_lock_irq(&vga_lock);
-	outb_p( 0x07, vga_video_port_reg );		/* CRTC overflow register */
-	outb_p( ovr, vga_video_port_val );
-	outb_p( 0x09, vga_video_port_reg );		/* Font size */
-	outb_p( fsr, vga_video_port_val );
-	outb_p( 0x12, vga_video_port_reg );		/* Vertical display limit */
-	outb_p( vde, vga_video_port_val );
+	vga_outb_p( 0x07, vga_video_port_reg );	/* CRTC overflow register */
+	vga_outb_p( ovr, vga_video_port_val );
+	vga_outb_p( 0x09, vga_video_port_reg );	/* Font size */
+	vga_outb_p( fsr, vga_video_port_val );
+	vga_outb_p( 0x12, vga_video_port_reg );	/* Vertical display limit */
+	vga_outb_p( vde, vga_video_port_val );
 	spin_unlock_irq(&vga_lock);	
 
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
--- 2.5.59/include/linux/vt_buffer.h	Mon Mar 18 23:37:17 2002
+++ linux/include/linux/vt_buffer.h	Sat Jan 25 21:27:43 2003
@@ -17,6 +17,11 @@
 
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
 #include <asm/vga.h>
+#ifndef __HAVE_ARCH_IOPORT_REMAP
+#define vga_outb_p	outb_p
+#define vga_outw	outw
+#define vga_inb_p	inb_p
+#endif
 #endif
 
 #ifndef VT_BUF_HAVE_RW
