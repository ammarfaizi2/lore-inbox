Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277733AbRJRQB2>; Thu, 18 Oct 2001 12:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277782AbRJRQBP>; Thu, 18 Oct 2001 12:01:15 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:17156 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S277733AbRJRQAj>; Thu, 18 Oct 2001 12:00:39 -0400
Date: Thu, 18 Oct 2001 18:01:10 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: James D Strandboge <jstrand1@rochester.rr.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: [patch] Re: joypad bug
Message-ID: <20011018180110.A1402@suse.cz>
In-Reply-To: <000801c15672$bed14210$1300a8c0@marcelo> <20011017212342.A552@suse.cz> <20011017153214.A12797@rochester.rr.com> <20011017224337.A319@suse.cz> <20011017172507.B16514@rochester.rr.com> <20011017235112.A1741@suse.cz> <20011018085329.A728@rochester.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011018085329.A728@rochester.rr.com>; from jstrand1@rochester.rr.com on Thu, Oct 18, 2001 at 08:53:29AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 08:53:29AM -0400, James D Strandboge wrote:

> On Wed, Oct 17, 2001 at 11:51:12PM +0200 or thereabouts, Vojtech Pavlik wrote:
> > But if you could provide some more detail about when it stopped to work
> > exactly (did it work with 2.4.9?) that might help.
> 
> I posted a message to the kernel mailing list and you a few minutes ago
> regarding the driver working in 2.4.9.  It did, however, when I made the
> original post, I was using vanilla 2.4.10 and 2.4.12.  However, I just
> tried 2.4.12-ac3 and it is in fact working.  Hope this helps.

It's because a fix didn't make it into Linus's tree. Fix is attached.
Linus: Please apply it. Thanks.

-- 
Vojtech Pavlik
SuSE Labs


--- linux/drivers/char/joystick/analog.c	Fri Sep 14 23:40:00 2001
+++ linux-fixed/drivers/char/joystick/analog.c	Thu Oct 18 17:57:06 2001
@@ -138,7 +138,7 @@
 
 #ifdef __i386__
 #define TSC_PRESENT	(test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability))
-#define GET_TIME(x)	do { if (TSC_PRESENT) rdtscl(x); else outb(0, 0x43); x = inb(0x40); x |= inb(0x40) << 8; } while (0)
+#define GET_TIME(x)	do { if (TSC_PRESENT) rdtscl(x); else { outb(0, 0x43); x = inb(0x40); x |= inb(0x40) << 8; } } while (0)
 #define DELTA(x,y)	(TSC_PRESENT?((y)-(x)):((x)-(y)+((x)<(y)?1193180L/HZ:0)))
 #define TIME_NAME	(TSC_PRESENT?"TSC":"PIT")
 #elif __x86_64__
@@ -499,7 +499,9 @@
 	else
 		printk(" [%s timer, %d %sHz clock, %d ns res]\n", TIME_NAME,
 		port->speed > 10000 ? (port->speed + 800) / 1000 : port->speed,
-		port->speed > 10000 ? "M" : "k", (port->loop * 1000000) / port->speed);
+		port->speed > 10000 ? "M" : "k",
+		port->speed > 10000 ? (port->loop * 1000) / (port->speed / 1000)
+				    : (port->loop * 1000000) / port->speed);
 }
 
 /*
