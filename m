Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129285AbRBCGZG>; Sat, 3 Feb 2001 01:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131108AbRBCGY4>; Sat, 3 Feb 2001 01:24:56 -0500
Received: from saloma.stu.rpi.edu ([128.113.199.230]:7177 "HELO
	incandescent.mp3revolution.net") by vger.kernel.org with SMTP
	id <S129285AbRBCGYj>; Sat, 3 Feb 2001 01:24:39 -0500
From: dilinger@mp3revolution.net
Date: Sat, 3 Feb 2001 01:24:24 -0500
To: David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: xirc2ps_cs driver timeouts/errors
Message-ID: <20010203012424.A16326@incandescent.mp3revolution.net>
In-Reply-To: <20010202235431.A16216@incandescent.mp3revolution.net> <20010202212040.A11161@sonic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010202212040.A11161@sonic.net>; from dhinds@sonic.net on Fri, Feb 02, 2001 at 09:20:40PM -0800
X-Operating-System: Linux incandescent 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I downloaded the pcmcia-cs 3.1.24 package and hand-merged the bugfix(es?)
into 2.4.1's xirc2ps_cs.c.  A(n attempt at a) patch to bring 2.4.1
up to pcmcia-cs's version is attached to this email.  So far, no
problems, but it'll be at least 48 hours before I can say whether
it happens or not..  This is also available at
http://incandescent.mp3revolution.net/kernel/xirc2ps_cs/.


Looking through logs, it appears as though the problem first
appeared in kernel 2.4.1-pre7, and has become frequent enough
to annoy me as of 2.4.1.  Did anything change dealing w/ this
driver/card between 2.4.0 and 2.4.1-pre7?



On Fri, Feb 02, 2001 at 09:20:40PM -0800, David Hinds wrote:
> 
> On Fri, Feb 02, 2001 at 11:54:31PM -0500, dilinger@mp3revolution.net wrote:
> > 
> > Each time I get a transmit timeout, or UDP: short packet error,
> > networking on my laptop seems to go down.  Reinsertion of the
> > card temporarily fixes it, and if I leave it long enough it
> > also fixes itself.
> 
> Does the same happen with a 2.2 kernel and the 3.1.24 PCMCIA drivers?
> There is a bug fix in the 3.1.24 xirc2ps_cs driver that hasn't been
> merged into the kernel tree yet.
> 
> -- Dave

-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xirc2ps_cs.c.diff"

diff -urN linux.old/drivers/net/pcmcia/xirc2ps_cs.c linux/drivers/net/pcmcia/xirc2ps_cs.c
--- linux.old/drivers/net/pcmcia/xirc2ps_cs.c	Thu Oct 26 19:52:16 2000
+++ linux/drivers/net/pcmcia/xirc2ps_cs.c	Sat Feb  3 01:15:49 2001
@@ -382,6 +382,7 @@
 static void do_powerdown(struct net_device *dev);
 static int do_stop(struct net_device *dev);
 
+
 /*=============== Helper functions =========================*/
 static void
 flush_stale_links(void)
@@ -1348,7 +1349,6 @@
 	     * packets */
 	    lp->stats.rx_dropped++;
 	    DEBUG(2, "%s: RX drop, too much done\n", dev->name);
-	    PutWord(XIRCREG0_DO, 0x8000); /* issue cmd: skip_rx_packet */
 	} else if (rsr & PktRxOk) {
 	    struct sk_buff *skb;
 
@@ -1423,8 +1423,7 @@
 		if (!(rsr & PhyPkt))
 		    lp->stats.multicast++;
 	    }
-	    PutWord(XIRCREG0_DO, 0x8000); /* issue cmd: skip_rx_packet */
-	} else {
+	} else { /* bad packet */
 	    DEBUG(5, "rsr=%#02x\n", rsr);
 	}
 	if (rsr & PktTooLong) {
@@ -1439,6 +1438,9 @@
 	    lp->stats.rx_fifo_errors++; /* okay ? */
 	    DEBUG(3, "%s: Alignment error\n", dev->name);
 	}
+	
+	/* clear the received/dropped/error packet */
+	PutWord(XIRCREG0_DO, 0x8000); /* issue cmd: skip_rx_packet */
 
 	/* get the new ethernet status */
 	eth_status = GetByte(XIRCREG_ESR);

--M9NhX3UHpAaciwkO--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
