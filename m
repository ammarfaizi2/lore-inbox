Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137053AbREKFic>; Fri, 11 May 2001 01:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137054AbREKFiX>; Fri, 11 May 2001 01:38:23 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:46086 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S137053AbREKFiG>;
	Fri, 11 May 2001 01:38:06 -0400
Date: Thu, 10 May 2001 21:39:30 -0700
From: Greg KH <greg@kroah.com>
To: clameter@lameter.com, linux-kernel@vger.kernel.org
Cc: Drew Bertola <drew@drewb.com>
Subject: Re: USB broken in 2.4.4? Serial Ricochet works, USB performance sucks.
Message-ID: <20010510213930.A8483@kroah.com>
In-Reply-To: <20010509222456.A4960@kroah.com> <Pine.LNX.4.10.10105092324130.30061-100000@melchi.fuller.edu> <20010510200750.A29230@drewb.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010510200750.A29230@drewb.com>; from drew@drewb.com on Thu, May 10, 2001 at 08:07:50PM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 10, 2001 at 08:07:50PM -0700, Drew Bertola wrote:
> 
> Joey Hess had a problem similar to what you described, though he noticed
> it while using the pcmcia ricochet modem.  He passed along this patch:

Doh!  I've only fixed this same kind of problem about 3 different times
in the usb-serial drivers.  clameter, could you try the attached patch
against 2.4.4 and see if that fixes the MTU issue for you?

Thanks Drew for reminding me of this.

greg k-h


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-acm-2.4.4.patch"

--- linux-2.4.4/drivers/usb/acm.c	Fri Feb 16 16:06:17 2001
+++ linux-2.4/drivers/usb/acm.c	Thu May 10 21:29:29 2001
@@ -233,8 +240,14 @@
 		dbg("nonzero read bulk status received: %d", urb->status);
 
 	if (!urb->status & !acm->throttle)  {
-		for (i = 0; i < urb->actual_length && !acm->throttle; i++)
+		for (i = 0; i < urb->actual_length && !acm->throttle; i++) {
+			/* if we insert more than TTY_FLIPBUF_SIZE characters, 
+			 * we drop them. */
+			if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
+				tty_flip_buffer_push(tty);
+			}
 			tty_insert_flip_char(tty, data[i], 0);
+		}
 		tty_flip_buffer_push(tty);
 	}
 

--IS0zKkzwUGydFO0o--
