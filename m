Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137040AbREKDIc>; Thu, 10 May 2001 23:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137041AbREKDIX>; Thu, 10 May 2001 23:08:23 -0400
Received: from adsl-216-102-91-127.dsl.snfc21.pacbell.net ([216.102.91.127]:22277
	"EHLO ns1.serialhacker.net") by vger.kernel.org with ESMTP
	id <S137040AbREKDIP>; Thu, 10 May 2001 23:08:15 -0400
Date: Thu, 10 May 2001 20:07:50 -0700
From: Drew Bertola <drew@drewb.com>
To: clameter@lameter.com
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: USB broken in 2.4.4? Serial Ricochet works, USB performance sucks.
Message-ID: <20010510200750.A29230@drewb.com>
In-Reply-To: <20010509222456.A4960@kroah.com> <Pine.LNX.4.10.10105092324130.30061-100000@melchi.fuller.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10105092324130.30061-100000@melchi.fuller.edu>; from clameter@lameter.com on Wed, May 09, 2001 at 11:25:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 11:25:26PM -0700, clameter@lameter.com wrote:
> On Wed, 9 May 2001, Greg KH wrote:
> 
> > On Wed, May 09, 2001 at 11:09:36PM -0700, clameter@lameter.com wrote:
> > > 
> > > Allright then you should first check why the ACM driver is unable to
> > > handle an MTU of 1500. I had to set it to 232 or 500 to make it work at
> > > all. With an MTU of 1500 it does ICMP but not long tcp packets. There is
> > > some issue with long packets that might exceed some buffer size(?).
> > 
> > I don't see anything in the ACM driver that would cause a problem for
> > large MTU settings.  It is probably a device limitation, not the driver.
> 
> The Richochet USB stuff uses generic serial I/O. No special driver. And it
> works fine under Win/ME. Have you run a regular PPP connection over the
> ACM driver with an MTU of 1500?

Joey Hess had a problem similar to what you described, though he noticed
it while using the pcmcia ricochet modem.  He passed along this patch:


--- Serial.c.orig       Fri Feb  2 12:55:44 2001
+++ serial.c    Fri Feb  2 12:56:43 2001
@@ -569,10 +569,16 @@

        icount = &info->state->icount;
        do {
-
+               /*
+                * Check if flip buffer is full -- if it is, try to
flip,
+                * and if flipping got queued, return immediately
+                */
+               if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
+                       tty->flip.tqueue.routine((void *) tty);
+                       if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+                               return;
+               }
                ch = serial_inp(info, UART_RX);
-               if (tty->flip.count >= TTY_FLIPBUF_SIZE)
-                       goto ignore_char;
                *tty->flip.char_buf_ptr = ch;
                icount->rx++;


-- 
Drew Bertola  | Send a text message to my pager or cell ... 
              |   http://jpager.com/Drew

