Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284908AbRLKGaC>; Tue, 11 Dec 2001 01:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284911AbRLKG3o>; Tue, 11 Dec 2001 01:29:44 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:54031 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284908AbRLKG3d>; Tue, 11 Dec 2001 01:29:33 -0500
Message-ID: <3C15A79A.98EC0ADB@zip.com.au>
Date: Mon, 10 Dec 2001 22:28:42 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: gordo@pincoya.com, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] console close race fix resend
In-Reply-To: <20011210191630.A13679@furble>,
		<1008035512.4287.1.camel@phantasy> 
		<20011210191630.A13679@furble> <1008050718.4287.11.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Mon, 2001-12-10 at 22:16, Gordon Oliver wrote:
> 
> > and (c) appears to still have a race... You should extract
> > the value from the structure inside the lock, otherwise you
> > will still race with con_close (though perhaps a smaller race)
> > but since the call to acquire_console_sem() can sleep, the
> > vt handle you have may be stale.
> 
> Ehh, I don't think so.  Here is the whole patched function:
> 
> static void con_flush_chars(struct tty_struct *tty)
> {
>         struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
>         if (in_interrupt())     /* from flush_to_ldisc */
>                 return;
>         pm_access(pm_con);
>         acquire_console_sem();
>         if (vt)
>                 set_cursor(vt->vc_num);
>         release_console_sem();
> }
> 

It could be improved - we really should test tty->driver_data inside
lock_kernel(), and after the possible sleep.

How does this look (and how does it test?)

--- linux-2.4.17-pre8/drivers/char/console.c	Mon Dec 10 13:46:20 2001
+++ linux-akpm/drivers/char/console.c	Mon Dec 10 22:27:05 2001
@@ -100,6 +100,7 @@
 #include <linux/tqueue.h>
 #include <linux/bootmem.h>
 #include <linux/pm.h>
+#include <linux/smp_lock.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -2350,15 +2351,18 @@ static void con_start(struct tty_struct 
 
 static void con_flush_chars(struct tty_struct *tty)
 {
-	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
+	struct vt_struct *vt;
 
 	if (in_interrupt())	/* from flush_to_ldisc */
 		return;
-
 	pm_access(pm_con);
+	lock_kernel();		/* versus con_close() */
 	acquire_console_sem();
-	set_cursor(vt->vc_num);
+	vt = (struct vt_struct *)tty->driver_data;
+	if (vt)
+		set_cursor(vt->vc_num);
 	release_console_sem();
+	unlock_kernel();
 }
 
 /*
