Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289580AbSAVXtY>; Tue, 22 Jan 2002 18:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289588AbSAVXtP>; Tue, 22 Jan 2002 18:49:15 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:44559 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289585AbSAVXtE>; Tue, 22 Jan 2002 18:49:04 -0500
Message-ID: <3C4DF8F7.C50486EC@zip.com.au>
Date: Tue, 22 Jan 2002 15:42:47 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Serguei Miridonov <mirsev@cicese.mx>
CC: linux-kernel@vger.kernel.org
Subject: Re: Console output for debugging
In-Reply-To: <3C4DF2AD.66BC3F6C@cicese.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serguei Miridonov wrote:
> 
> Q: Is there any function in the kernel which I can call
> safely from a module to print debug message on the console
> screen?
> 
> I don't want to use printk for some reasons. One of them is
> that I want messages to appear on the screen immediately,
> even from interrupt processing routines. Another is to be
> able to see messages until the system freezes completely in
> case of software or hardware bug.
> 

printk does all this, usually.  It is synchronous, so when
it returns to your code, the text is on the screen.

The only exception to this is when you perform a printk
from within an interrupt handler *while* printk itself
is executing in non-interrupt context.  When this rare
situation occurs, the text is buffered, to be emitted
by the non-interrupt code before it returns to its caller.

If the printk-within-printk buffering is a problem for you,
(which I doubt) then you could disable interrupts while
running printk. Something like this:


--- linux-2.4.18-pre6/kernel/printk.c	Tue Jan 22 12:38:31 2002
+++ linux-akpm/kernel/printk.c	Tue Jan 22 15:40:57 2002
@@ -412,6 +412,10 @@ asmlinkage int printk(const char *fmt, .
 	char *p;
 	static char printk_buf[1024];
 	static int log_level_unknown = 1;
+	static spinlock_t printk_lock = SPIN_LOCK_UNLOCKED;
+	unsigned long xflags;
+
+	spin_lock_irqsave(&printk_lock, xflags);
 
 	if (oops_in_progress) {
 		/* If a crash is occurring, make sure we can't deadlock */
@@ -471,6 +475,7 @@ asmlinkage int printk(const char *fmt, .
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
 out:
+	spin_unlock_irqrestore(&printk_lock, xflags);
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
