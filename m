Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276448AbRJURxb>; Sun, 21 Oct 2001 13:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276444AbRJURxQ>; Sun, 21 Oct 2001 13:53:16 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:6149 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S276448AbRJURw7>;
	Sun, 21 Oct 2001 13:52:59 -0400
Date: Sun, 21 Oct 2001 19:53:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Jeremy M. Dolan" <jmd@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: severe ns558 joystick problems with 2.4.12
Message-ID: <20011021195330.A30319@suse.cz>
In-Reply-To: <20011021044630.A745@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011021044630.A745@foozle.turbogeek.org>; from jmd@pobox.com on Sun, Oct 21, 2001 at 04:46:30AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 04:46:30AM -0500, Jeremy M. Dolan wrote:
> I posted to linux-kernel 10 days ago with this problem, didn't really
> get any follow up, except other users having the same problem. So far
> have had 6 users contact me with the same problem, seems to have
> occured as early as 2.4.9 and .10, based on what I've heard from others.
> 
> To recap:
> 
> I have a 2 axis 6 button analog (ns558) gamepad. With 2.4.7,
> everything is fine, as long as I pass js=gamepad, it detects the 2
> axis and 6 buttons.
> 
> With 2.4.12, with js=gamepad and js=12531 (bitfield forced detection),
> the kernel message SAYS it detects 2 axis and 6 buttons, however when
> I use it (for example, with the jstest program), the two axis and
> buttons 4/5 don't register. The first four (0-3) buttons are fine.

The bug was introduced in 2.4.10. I've sent a patch that fixes it to
Linus already, one before 2.4.11, and one after 2.4.12, when I noticed
the fix didn't get in it. Here it is (first chunk is the important
thing, second chunk is just to avoid nonsensical values be printed on
too fast CPUs):

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

-- 
Vojtech Pavlik
SuSE Labs
