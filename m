Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287516AbSALVug>; Sat, 12 Jan 2002 16:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287558AbSALVuS>; Sat, 12 Jan 2002 16:50:18 -0500
Received: from a178d15hel.dial.kolumbus.fi ([212.54.8.178]:43285 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S287516AbSALVt6>; Sat, 12 Jan 2002 16:49:58 -0500
Message-ID: <3C40AF23.18C811A8@kolumbus.fi>
Date: Sat, 12 Jan 2002 23:48:19 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org, linux-audio-dev@music.columbia.edu
Subject: [PATCH] Additions to full lowlatency patch
Content-Type: multipart/mixed;
 boundary="------------5FE714B51D668033F4958BA8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5FE714B51D668033F4958BA8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I've done some changes to lowlatency patched kernel. Mainly "fixes" to DRM
drivers and few network drivers. Most probably I have done something really
stupid, but those work here(tm). Especially the Radeon driver patch has got
a lot of testing and seems to have huge impact to latencies in my system.


Best regards,

	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
--------------5FE714B51D668033F4958BA8
Content-Type: text/plain; charset=us-ascii;
 name="all-ll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="all-ll.patch"

diff -ur linux-2.4.17-lowlatency/drivers/char/drm/mga_dma.c linux-2.4.17-lowlatency-jl/drivers/char/drm/mga_dma.c
--- linux-2.4.17-lowlatency/drivers/char/drm/mga_dma.c	Wed Aug  8 19:42:15 2001
+++ linux-2.4.17-lowlatency-jl/drivers/char/drm/mga_dma.c	Mon Dec 31 22:05:06 2001
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
 
diff -ur linux-2.4.17-lowlatency/drivers/char/drm/r128_cce.c linux-2.4.17-lowlatency-jl/drivers/char/drm/r128_cce.c
--- linux-2.4.17-lowlatency/drivers/char/drm/r128_cce.c	Mon Aug 27 17:40:33 2001
+++ linux-2.4.17-lowlatency-jl/drivers/char/drm/r128_cce.c	Mon Dec 31 22:08:38 2001
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
 
diff -ur linux-2.4.17-lowlatency/drivers/char/drm/radeon_cp.c linux-2.4.17-lowlatency-jl/drivers/char/drm/radeon_cp.c
--- linux-2.4.17-lowlatency/drivers/char/drm/radeon_cp.c	Sat Sep 15 00:29:41 2001
+++ linux-2.4.17-lowlatency-jl/drivers/char/drm/radeon_cp.c	Mon Dec 31 21:59:45 2001
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
 
diff -ur linux-2.4.17-lowlatency/drivers/net/3c59x.c linux-2.4.17-lowlatency-jl/drivers/net/3c59x.c
--- linux-2.4.17-lowlatency/drivers/net/3c59x.c	Fri Dec 21 19:41:54 2001
+++ linux-2.4.17-lowlatency-jl/drivers/net/3c59x.c	Mon Dec 31 22:31:10 2001
@@ -1368,6 +1368,7 @@
 					   dev->name, cmd, i * 10);
 			return;
 		}
+		conditional_schedule();
 		udelay(10);
 	}
 	printk(KERN_ERR "%s: command 0x%04x did not complete! Status=0x%x\n",
diff -ur linux-2.4.17-lowlatency/drivers/net/8139too.c linux-2.4.17-lowlatency-jl/drivers/net/8139too.c
--- linux-2.4.17-lowlatency/drivers/net/8139too.c	Fri Dec 21 19:41:54 2001
+++ linux-2.4.17-lowlatency-jl/drivers/net/8139too.c	Mon Dec 31 22:33:00 2001
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
diff -ur linux-2.4.17-lowlatency/drivers/net/eepro100.c linux-2.4.17-lowlatency-jl/drivers/net/eepro100.c
--- linux-2.4.17-lowlatency/drivers/net/eepro100.c	Fri Dec 21 19:41:54 2001
+++ linux-2.4.17-lowlatency-jl/drivers/net/eepro100.c	Mon Dec 31 22:41:42 2001
@@ -324,7 +324,11 @@
 static inline void wait_for_cmd_done(long cmd_ioaddr)
 {
 	int wait = 1000;
-	do  udelay(1) ;
+	do
+	{
+			conditional_schedule();
+			udelay(1) ;
+	}
 	while(inb(cmd_ioaddr) && --wait >= 0);
 #ifndef final_version
 	if (wait < 0)

--------------5FE714B51D668033F4958BA8--


