Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132014AbRA2I0o>; Mon, 29 Jan 2001 03:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132372AbRA2I0d>; Mon, 29 Jan 2001 03:26:33 -0500
Received: from smtp5.mail.yahoo.com ([128.11.69.102]:41223 "HELO
	smtp5.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132014AbRA2I00>; Mon, 29 Jan 2001 03:26:26 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A74D9E8.112A101B@yahoo.com>
Date: Sun, 28 Jan 2001 21:48:08 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.1-pre8 i486)
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Stefani Seibold <stefani@seibold.net>, linux-kernel@vger.kernel.org
Subject: Re: patch for 2.4.0 disable printk
In-Reply-To: <01012723313500.01190@deepthought.seibold.net> <3A736B76.214D4193@uow.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Stefani Seibold wrote:
> >
> > Second, i had change the macro so it calls now a inline funciton
> > printk_inline which always return 0. So it should be now compatibel to the
> > standard printk funciton.
> 
> A #define is better.
> 
> You see, even if printk is a null inline function,
> 
>         printk("foo");
> 
> will still cause "foo" to appear in your output. Apparently
> very recent versions of gcc have fixed this.

I missed earlier parts of this, so maybe I'm not even on the same page...

Here is part of an old patch I made to replace panic messages with
a simple EIP that you could still look up in System.map to cut down on 
the text in the image for small kernels.  One could use the same macro
trickery for printk() which is what I think Andrew is recommending.

Paul.

--- /mnt2/linux/include/linux/kernel.h	Wed Feb 12 14:17:00 1997
+++ linux/include/linux/kernel.h	Wed Feb 12 13:57:47 1997
@@ -34,8 +34,16 @@
 # define NORET_AND     noreturn,
 
 extern void math_error(void);
-NORET_TYPE void panic(const char * fmt, ...)
-	__attribute__ ((NORET_AND format (printf, 1, 2)));
+
+NORET_TYPE void panic_at(const void *location)
+	ATTRIB_NORET;
+
+#define panic(fmt,arg...)	\
+({ __label__ whoops;		\
+whoops:				\
+	panic_at(&&whoops);	\
+})
+ 
 NORET_TYPE void do_exit(long error_code)
 	ATTRIB_NORET;
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
--- /mnt2/linux/kernel/panic.c	Wed Feb 12 14:17:00 1997
+++ linux/kernel/panic.c	Wed Feb 12 14:23:06 1997
@@ -19,50 +19,18 @@
 extern void do_unblank_screen(void);
 extern int C_A_D;
 
-NORET_TYPE void panic(const char * fmt, ...)
+NORET_TYPE void panic_at(const void *location)
 {
-	static char buf[1024];
-	va_list args;
-	int i;
-
-	va_start(args, fmt);
-	vsprintf(buf, fmt, args);
-	va_end(args);
-	printk(KERN_EMERG "Kernel panic: %s\n",buf);
+	printk(KERN_EMERG "Kernel panic at: %p\n",location);
 	if (current == task[0])
 		printk(KERN_EMERG "In swapper task - not syncing\n");
 	else



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
