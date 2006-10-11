Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030794AbWJKEsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030794AbWJKEsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 00:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030793AbWJKEsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 00:48:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29199 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030794AbWJKEsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 00:48:41 -0400
Date: Wed, 11 Oct 2006 06:48:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Rogier Wolff <R.E.Wolff@bitwizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [2.6.19 patch] drivers/char/specialix.c: fix the baud conversion
Message-ID: <20061011044838.GG721@stusta.de>
References: <20061008221818.GL6755@stusta.de> <20061009063744.GB2877@bitwizard.nl> <20061010061747.GC3650@stusta.de> <200610101401.20295.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610101401.20295.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 02:01:19PM +0200, Rolf Eike Beer wrote:
> Adrian Bunk wrote:
> > On Mon, Oct 09, 2006 at 08:37:45AM +0200, Rogier Wolff wrote:
> > > On Mon, Oct 09, 2006 at 12:18:19AM +0200, Adrian Bunk wrote:
> > > > +       if (baud == 38400) {
> > > >                 if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
> > > >                         baud ++;
> > > >                 if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
> > > >                         baud += 2;
> > > >         }
> > > >
> > > > Increasing the index for baud_table[] by 1 or 2 is quite different from
> > > > increasing baud by 1 or 2.
> > >
> > > In that range,
> > > 	baud <<= 1;
> > > and
> > > 	baud <<= 2;
> > >
> > > should work.
> >
> > Thanks for the hint.
> >
> > What about the patch below?
> 
> > @@ -1090,9 +1085,9 @@
> >
> >  	if (baud == 38400) {
> >  		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
> > -			baud ++;
> > +			baud <<= 1;
> >  		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
> > -			baud += 2;
> > +			baud <<= 2;
> >  	}
> >
> >  	if (!baud) {
> 
> Neither is 38400 <<= 1 == 57600 nor is 38400 <<= 2 == 115200. You should just 
> set baud to the value you want instead of doing tricks here.

Damn, I should have checked the numbers myself...  :-(

Thanks for the correction, an updated patch is below.

> Eike

cu
Adrian


<--  snip  -->


This patch corrects the following bugs introduced by
commit 67cc0161ecc9ebee6eba4af6cbfdba028090b1b9:
- remove one remaining and now incorrect baud_table[] usage
- "baud +=" is no longer correct

The former bug was spotted by the Coverity checker.

Rolf Eike Beer spotted a bug in the initial version of my patch.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/specialix.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

--- linux-2.6/drivers/char/specialix.c.old	2006-10-11 06:35:44.000000000 +0200
+++ linux-2.6/drivers/char/specialix.c	2006-10-11 06:36:52.000000000 +0200
@@ -183,11 +183,6 @@
 
 static struct tty_driver *specialix_driver;
 
-static unsigned long baud_table[] =  {
-	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
-	9600, 19200, 38400, 57600, 115200, 0,
-};
-
 static struct specialix_board sx_board[SX_NBOARD] =  {
 	{ 0, SX_IOBASE1,  9, },
 	{ 0, SX_IOBASE2, 11, },
@@ -1090,9 +1085,9 @@
 
 	if (baud == 38400) {
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-			baud ++;
+			baud = 57600;
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-			baud += 2;
+			baud = 115200;
 	}
 
 	if (!baud) {
@@ -1150,11 +1145,9 @@
 	sx_out(bp, CD186x_RBPRL, tmp & 0xff);
 	sx_out(bp, CD186x_TBPRL, tmp & 0xff);
 	spin_unlock_irqrestore(&bp->lock, flags);
-	if (port->custom_divisor) {
+	if (port->custom_divisor)
 		baud = (SX_OSCFREQ + port->custom_divisor/2) / port->custom_divisor;
-		baud = ( baud + 5 ) / 10;
-	} else
-		baud = (baud_table[baud] + 5) / 10;   /* Estimated CPS */
+	baud = (baud + 5) / 10;		/* Estimated CPS */
 
 	/* Two timer ticks seems enough to wakeup something like SLIP driver */
 	tmp = ((baud + HZ/2) / HZ) * 2 - CD186x_NFIFO;

