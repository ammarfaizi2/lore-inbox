Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287565AbSAMCt2>; Sat, 12 Jan 2002 21:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287950AbSAMCtJ>; Sat, 12 Jan 2002 21:49:09 -0500
Received: from a178d15hel.dial.kolumbus.fi ([212.54.8.178]:55724 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S287565AbSAMCs5>; Sat, 12 Jan 2002 21:48:57 -0500
Message-ID: <3C40F53D.3F9B524C@kolumbus.fi>
Date: Sun, 13 Jan 2002 04:47:25 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org, linux-audio-dev@music.columbia.edu
Subject: Re: [PATCH] Additions to full lowlatency patch
In-Reply-To: <3C40AF23.18C811A8@kolumbus.fi> <3C40B6F3.1531F931@zip.com.au> <3C40BEBF.6EE60D2@kolumbus.fi>
Content-Type: multipart/mixed;
 boundary="------------9950D0D44A2CE858DAC5730D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9950D0D44A2CE858DAC5730D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Here's my second try. I read through the code once more and made some fixes.
Is this correct way to avoid conditional_schedule() when holding spinlock?
Both eepro100 and 3c90x drivers call the command completion wait routine
with spinlock held in few places. I didn't find such situations in 8139too
nor the DRM drivers.


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
--------------9950D0D44A2CE858DAC5730D
Content-Type: text/plain; charset=us-ascii;
 name="all-ll-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="all-ll-2.patch"

diff -urN linux/drivers/char/drm/mga_dma.c linux-2.4.17-jl7-ll/drivers/char/drm/mga_dma.c
--- linux/drivers/char/drm/mga_dma.c	Wed Aug  8 19:42:15 2001
+++ linux-2.4.17-jl7-ll/drivers/char/drm/mga_dma.c	Sun Jan 13 02:07:13 2002
@@ -61,6 +61,7 @@
 			MGA_WRITE8( MGA_CRTC_INDEX, 0 );
 			return 0;
 		}
+		conditional_schedule();
 		udelay( 1 );
 	}
 
@@ -80,6 +81,7 @@
 	for ( i = 0 ; i < dev_priv->usec_timeout ; i++ ) {
 		status = MGA_READ( MGA_STATUS ) & MGA_DMA_IDLE_MASK;
 		if ( status == MGA_ENDPRDMASTS ) return 0;
+		conditional_schedule();
 		udelay( 1 );
 	}
 
@@ -121,6 +123,7 @@
 	 * How about we clean up after ourselves?
 	 */
 	MGA_WRITE( MGA_RST, MGA_SOFTRESET );
+	conditional_schedule();		/* We shouldn't get here anyway... */
 	udelay( 15 );				/* Wait at least 10 usecs */
 	MGA_WRITE( MGA_RST, 0 );
 
diff -urN linux/drivers/char/drm/r128_cce.c linux-2.4.17-jl7-ll/drivers/char/drm/r128_cce.c
--- linux/drivers/char/drm/r128_cce.c	Mon Aug 27 17:40:33 2001
+++ linux-2.4.17-jl7-ll/drivers/char/drm/r128_cce.c	Sun Jan 13 02:07:14 2002
@@ -128,6 +128,7 @@
 		if ( !(R128_READ( R128_PC_NGUI_CTLSTAT ) & R128_PC_BUSY) ) {
 			return 0;
 		}
+		conditional_schedule();
 		udelay( 1 );
 	}
 
@@ -144,6 +145,7 @@
 	for ( i = 0 ; i < dev_priv->usec_timeout ; i++ ) {
 		int slots = R128_READ( R128_GUI_STAT ) & R128_GUI_FIFOCNT_MASK;
 		if ( slots >= entries ) return 0;
+		conditional_schedule();
 		udelay( 1 );
 	}
 
@@ -165,6 +167,7 @@
 			r128_do_pixcache_flush( dev_priv );
 			return 0;
 		}
+		conditional_schedule();
 		udelay( 1 );
 	}
 
@@ -225,6 +228,7 @@
 				return r128_do_pixcache_flush( dev_priv );
 			}
 		}
+		conditional_schedule();
 		udelay( 1 );
 	}
 
@@ -928,6 +932,7 @@
 				return buf;
 			}
 		}
+		conditional_schedule();
 		udelay( 1 );
 	}
 
@@ -961,6 +966,7 @@
 		r128_update_ring_snapshot( ring );
 		if ( ring->space >= n )
 			return 0;
+		conditional_schedule();
 		udelay( 1 );
 	}
 
diff -urN linux/drivers/char/drm/radeon_cp.c linux-2.4.17-jl7-ll/drivers/char/drm/radeon_cp.c
--- linux/drivers/char/drm/radeon_cp.c	Sat Sep 15 00:29:41 2001
+++ linux-2.4.17-jl7-ll/drivers/char/drm/radeon_cp.c	Sun Jan 13 02:07:14 2002
@@ -356,6 +356,7 @@
 		       & RADEON_RB2D_DC_BUSY) ) {
 			return 0;
 		}
+		conditional_schedule();
 		udelay( 1 );
 	}
 
@@ -375,6 +376,7 @@
 		int slots = ( RADEON_READ( RADEON_RBBM_STATUS )
 			      & RADEON_RBBM_FIFOCNT_MASK );
 		if ( slots >= entries ) return 0;
+		conditional_schedule();
 		udelay( 1 );
 	}
 
@@ -398,6 +400,7 @@
 			radeon_do_pixcache_flush( dev_priv );
 			return 0;
 		}
+		conditional_schedule();
 		udelay( 1 );
 	}
 
@@ -1316,6 +1319,7 @@
 			start = 0;
 #endif
 		}
+		conditional_schedule();
 		udelay( 1 );
 	}
 
@@ -1355,6 +1359,7 @@
 		radeon_update_ring_snapshot( ring );
 		if ( ring->space > n )
 			return 0;
+		conditional_schedule();
 		udelay( 1 );
 	}
 
diff -urN linux/drivers/net/3c59x.c linux-2.4.17-jl7-ll/drivers/net/3c59x.c
--- linux/drivers/net/3c59x.c	Fri Dec 21 19:41:54 2001
+++ linux-2.4.17-jl7-ll/drivers/net/3c59x.c	Sun Jan 13 03:16:30 2002
@@ -1353,6 +1353,7 @@
 issue_and_wait(struct net_device *dev, int cmd)
 {
 	int i;
+	struct vortex_private *vp = (struct vortex_private *)dev->priv
 
 	outw(cmd, dev->base_addr + EL3_CMD);
 	for (i = 0; i < 2000; i++) {
@@ -1368,6 +1369,8 @@
 					   dev->name, cmd, i * 10);
 			return;
 		}
+		if (!spin_is_locked(&vp->lock))
+			conditional_schedule();
 		udelay(10);
 	}
 	printk(KERN_ERR "%s: command 0x%04x did not complete! Status=0x%x\n",
diff -urN linux/drivers/net/8139too.c linux-2.4.17-jl7-ll/drivers/net/8139too.c
--- linux/drivers/net/8139too.c	Fri Dec 21 19:41:54 2001
+++ linux-2.4.17-jl7-ll/drivers/net/8139too.c	Sun Jan 13 02:07:14 2002
@@ -707,6 +707,7 @@
 		barrier();
 		if ((RTL_R8 (ChipCmd) & CmdReset) == 0)
 			break;
+		conditional_schedule();
 		udelay (10);
 	}
 }
@@ -1774,6 +1775,7 @@
 	RTL_W8_F (ChipCmd, CmdTxEnb);
 	tmp_work = 200;
 	while (--tmp_work > 0) {
+		conditional_schedule();
 		udelay(1);
 		tmp8 = RTL_R8 (ChipCmd);
 		if (!(tmp8 & CmdRxEnb))
@@ -1785,6 +1787,7 @@
 	tmp_work = 200;
 	while (--tmp_work > 0) {
 		RTL_W8_F (ChipCmd, CmdRxEnb | CmdTxEnb);
+		conditional_schedule();
 		udelay(1);
 		tmp8 = RTL_R8 (ChipCmd);
 		if ((tmp8 & CmdRxEnb) && (tmp8 & CmdTxEnb))
diff -urN linux/drivers/net/eepro100.c linux-2.4.17-jl7-ll/drivers/net/eepro100.c
--- linux/drivers/net/eepro100.c	Sun Jan 13 01:20:33 2002
+++ linux-2.4.17-jl7-ll/drivers/net/eepro100.c	Sun Jan 13 03:59:25 2002
@@ -321,10 +321,17 @@
 
 /* How to wait for the command unit to accept a command.
    Typically this takes 0 ticks. */
-static inline void wait_for_cmd_done(long cmd_ioaddr)
+#define wait_for_cmd_done(x)	_wait_for_cmd_done(&sp->lock, x)
+static inline void _wait_for_cmd_done(spinlock_t *lelock, 
+	long cmd_ioaddr)
 {
 	int wait = 1000;
-	do  udelay(1) ;
+
+	do {
+		if (!spin_is_locked(lelock))
+			conditional_schedule();
+		udelay(1) ;
+	}
 	while(inb(cmd_ioaddr) && --wait >= 0);
 #ifndef final_version
 	if (wait < 0)

--------------9950D0D44A2CE858DAC5730D--


