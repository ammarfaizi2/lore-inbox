Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbRBELdK>; Mon, 5 Feb 2001 06:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBELdA>; Mon, 5 Feb 2001 06:33:00 -0500
Received: from smtp6.mail.yahoo.com ([128.11.69.103]:41994 "HELO
	smtp6.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129130AbRBELcr>; Mon, 5 Feb 2001 06:32:47 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A7C5EE9.D6B190E@yahoo.com>
Date: Sat, 03 Feb 2001 14:41:29 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: lgb@lgb.hu
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/REQ] Increase kmsg buffer from 16K to 32K, kernel/printk.c
In-Reply-To: <3A72804A.E6052E1B@linux.com> <E14O0hv-0002hY-00@the-village.bc.nu> <20010131182124.A1890@supervisor.hu>
Content-Type: multipart/mixed; boundary="------------1F8CAD3C52D9D8D83D92014E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--------------1F8CAD3C52D9D8D83D92014E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Gabor Lenart wrote:
> 
> On Wed, Jan 31, 2001 at 05:06:07PM +0000, Alan Cox wrote:
> > > Does Linus or anyone object to raising the ksmg buffer from 16K to 32K?
> > > 4/5 systems I have now overflow the buffer during boot before init is
> > > even launched.
> >
> > Thats just an indication that 2.4.x is currently printking too much crap on
> > boot
> 
> Would it be possible to grow and shring that buffer on demand? Let's say
> we have a default size and let it grow to a maximum value. After some
> timeout, buffer size can be shrinked to default value if it's enough at
> that moment. Or something similar.

I agree that 16k is too much crap being dumped to the console, as people 
will just zone out as it scrolls by at 100lines/sec.  However, it is 
possible to cut it down in size - here is something I have in store for 
2.5 (posted a while ago, the zero initializer for bootlog_buf can go).

Paul.

|Date: Mon, 21 Aug 2000 05:36:18 -0400
|From: Paul Gortmaker <p_gortmaker@yahoo.com>
|To: linux-kernel@vger.kernel.org
|Subject: [PATCH] resizeable printk ring buffer

The printk ring buffer has doubled in size several times to accomodate
the amount of boot messages spewed out by kernels with lots of drivers.
This always seemed like a bit of a waste to me since after the boot
messages had been logged to disk, the original 4k buffer is more than
adequate during normal operation.  To others, the idea of having a big
128k ring buffer might be appealing.  Hence this patch.

The buffer used at bootstrap is marked initdata and an initcall is
used to bounce the messages into a kmalloc'd region before the
initdata is freed.  With a minor extension to the dmesg program (and
kernel syscall) the admin can resise the ring buffer from 4k to 128k.
Messages in the buffer are preserved if the buffer hasn't wrapped
yet and if they will fit in the new size.

To resize without yet having the modified dmesg, you essentially do:

 i = syscall(103 /*syslog*/ , 9, NULL, kbytes);

where kbytes is 4, 8, 16 ... 128.

I'm not advocating this for 2.4 as it isn't a bugfix, but thought
others might want to play with it between now and 2.5.x

Paul.

--- linux~/kernel/printk.c	Fri Jul  7 03:47:57 2000
+++ linux/kernel/printk.c	Tue Aug 15 05:17:24 2000
@@ -12,18 +12,20 @@
  * Modified for sysctl support, 1/8/97, Chris Horn.
  * Fixed SMP synchronization, 08/08/99, Manfred Spraul 
  *     manfreds@colorfullife.com
+ * Dynamically resizeable printk ring buffer, 07/2000, Paul Gortmaker.
  */
 
 #include <linux/mm.h>
 #include <linux/tty_driver.h>
 #include <linux/smp_lock.h>
 #include <linux/console.h>
+#include <linux/slab.h>
 #include <linux/init.h>
 
 #include <asm/uaccess.h>
 
-#define LOG_BUF_LEN	(16384)
-#define LOG_BUF_MASK	(LOG_BUF_LEN-1)
+#define BOOTLOG_BUF_LEN	(16384)
+#define LOG_BUF_MASK	(log_buf_len-1)
 
 static char buf[1024];
 
@@ -46,7 +48,9 @@
 spinlock_t console_lock = SPIN_LOCK_UNLOCKED;
 
 struct console *console_drivers = NULL;
-static char log_buf[LOG_BUF_LEN];
+static char bootlog_buf[BOOTLOG_BUF_LEN] __initdata = {0, };
+static unsigned int log_buf_len = BOOTLOG_BUF_LEN;
+static char *log_buf = bootlog_buf;
 static unsigned long log_start;
 static unsigned long logged_chars;
 struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
@@ -119,13 +123,13 @@
  * 	6 -- Disable printk's to console
  * 	7 -- Enable printk's to console
  *	8 -- Set level of messages printed to console
+ *	9 -- Set ring buffer size in kB (4k -> 128k, 2^n)
  */
 int do_syslog(int type, char * buf, int len)
 {
 	unsigned long i, j, limit, count;
-	int do_clear = 0;
-	char c;
-	int error = -EPERM;
+	int error, do_clear = 0;
+	char c, *new_buf;
 
 	error = 0;
 	switch (type) {
@@ -175,8 +179,8 @@
 		if (error)
 			goto out;
 		count = len;
-		if (count > LOG_BUF_LEN)
-			count = LOG_BUF_LEN;
+		if (count > log_buf_len)
+			count = log_buf_len;
 		spin_lock_irq(&console_lock);
 		if (count > logged_chars)
 			count = logged_chars;
@@ -191,7 +195,7 @@
 		 */
 		for(i=0;i < count;i++) {
 			j = limit-1-i;
-			if (j+LOG_BUF_LEN < log_start+log_size)
+			if (j+log_buf_len < log_start+log_size)
 				break;
 			c = log_buf[ j  & LOG_BUF_MASK ];
 			spin_unlock_irq(&console_lock);
@@ -236,6 +240,30 @@
 		spin_unlock_irq(&console_lock);
 		error = 0;
 		break;
+	case 9:	
+		error = -EINVAL;
+		i = 128;
+		while (i != len && i != 4) i>>=1;
+		if (i != len)
+			goto out;
+		error = -ENOMEM;
+		new_buf = kmalloc(len*1024, GFP_KERNEL);
+		if (new_buf == NULL) 
+			goto out;
+		memset(new_buf, 0, len*1024);
+		spin_lock_irq(&console_lock);
+		limit = log_start + log_size;
+		/* Copy iff it hasn't wrapped & will fit.  */
+		if (limit < log_buf_len && logged_chars <= len*1024)
+			memcpy(new_buf, log_buf, logged_chars);
+		else
+			logged_chars = log_size = log_start = 0;
+		kfree(log_buf);
+		log_buf = new_buf;
+		log_buf_len = len*1024;
+		spin_unlock_irq(&console_lock);
+		error = 0;
+		break;
 	default:
 		error = -EINVAL;
 		break;
@@ -285,7 +313,7 @@
 		line_feed = 0;
 		for (; p < buf_end; p++) {
 			log_buf[(log_start+log_size) & LOG_BUF_MASK] = *p;
-			if (log_size < LOG_BUF_LEN)
+			if (log_size < log_buf_len)
 				log_size++;
 			else
 				log_start++;
@@ -495,3 +523,26 @@
 		tty->driver.write(tty, 0, msg, strlen(msg));
 	return;
 }
+
+/*
+ * Kernel boot messages are 1st stored in __initdata, then copied to
+ * kmalloc so you can use do_syslog() above to resize buffer later.
+ */
+static int __init printk_ring_copy(void)
+{
+	char *new_buf;
+	unsigned long flags;
+
+	new_buf = kmalloc(BOOTLOG_BUF_LEN, GFP_KERNEL);
+	if (new_buf == NULL) {
+		printk(KERN_EMERG "No memory for new printk buffer!?!\n");
+		return -ENOMEM;
+	}
+	spin_lock_irqsave(&console_lock, flags);
+	memcpy(new_buf, log_buf, BOOTLOG_BUF_LEN);
+	log_buf = new_buf;
+	spin_unlock_irqrestore(&console_lock, flags);
+	return 0;
+}
+
+__initcall(printk_ring_copy);





_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
--------------1F8CAD3C52D9D8D83D92014E--
