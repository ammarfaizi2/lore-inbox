Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130271AbRA3RXP>; Tue, 30 Jan 2001 12:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130761AbRA3RXG>; Tue, 30 Jan 2001 12:23:06 -0500
Received: from npt12056206.cts.com ([216.120.56.206]:22798 "HELO
	forty.spoke.nols.com") by vger.kernel.org with SMTP
	id <S130271AbRA3RW6>; Tue, 30 Jan 2001 12:22:58 -0500
Date: Tue, 30 Jan 2001 09:22:53 -0800
From: David Rees <dbr@spoke.nols.com>
To: linux-kernel@vger.kernel.org
Subject: Re: klogd is acting strange with 2.4
Message-ID: <20010130092253.A1156@spoke.nols.com>
Mail-Followup-To: David Rees <dbr@spoke.nols.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010130093035.A31970@dragon.universe> <20010130085359.A817@spoke.nols.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010130085359.A817@spoke.nols.com>; from dbr@spoke.nols.com on Tue, Jan 30, 2001 at 08:53:59AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 08:53:59AM -0800, David Rees wrote:
> On Tue, Jan 30, 2001 at 09:30:36AM -0500, newsreader@mediaone.net wrote:
> > celeron 433 intel i810.  320MB ram.
> > 
> > Before 2.2.18.  Now I've tested with both
> > 2.4.1-pre12 and 2.4.1.  2.4 kernel klogd is
> > always using 99% cpu.  What gives?
> > 
> > I've three other less powerful boxes running
> > 2.4.x kernels and none of them behave
> > like this.  This server isn't taking any
> > more hits than it usually does.
> > 
> > What more information I should post here?
> > I've two apache servers, pgsql and sendmail
> > and some other processes running on this
> > server.
> 
> Can you try 2.4.0?  Are you using the 3c59x ethernet driver?  I've got the 
> same problem on one of my machines, (see message with subject "2.4.1-pre10 
> -> 2.4.1 klogd at 100% CPU ; 2.4.0 OK") and the last thing that is logged 
> is a message from the 3c59x ethernet driver.
> 
> I'm doing a bit more digging to see what changed in the driver between 
> revisions.  /proc/pci lists my 3c905B as this:
> 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 48)

After digging through the archive, it seems that the klogd program doesn't
handle nulls very nicely.  Anyway, by commenting out one of the
initialization printks introduced in the 3c59x driver in 2.4.1, I can run
2.4.1 without having klogd suck up all my CPU time.  The patch is below.

-Dave

--- linux/drivers/net/3c59x.c.orig      Sat Jan  6 09:27:42 2001
+++ linux/drivers/net/3c59x.c   Tue Jan 30 09:05:20 2001
@@ -1049,9 +1049,11 @@
 
        EL3WINDOW(4);
        step = (inb(ioaddr + Wn4_NetDiag) & 0x1e) >> 1;
+/*
        printk(KERN_INFO "  product code '%c%c' rev %02x.%d date %02d-"
                   "%02d-%02d\n", eeprom[6]&0xff, eeprom[6]>>8, eeprom[0x14],
                   step, (eeprom[4]>>5) & 15, eeprom[4] & 31, eeprom[4]>>9);
+*/
 
 
        if (pdev && vci->drv_flags & HAS_CB_FNS) {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
