Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267420AbRGPP0T>; Mon, 16 Jul 2001 11:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267422AbRGPP0J>; Mon, 16 Jul 2001 11:26:09 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:50893 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267420AbRGPPZ4>; Mon, 16 Jul 2001 11:25:56 -0400
Message-ID: <3B5307CB.1BA89A6F@uow.edu.au>
Date: Tue, 17 Jul 2001 01:27:07 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>, crutcher+kernel@datastacks.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-ac5
In-Reply-To: <20010716153702.A21514@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> o       Add snprintf/vsnprintf to the kernel            (Crutcher Dunnavant)

Nice.

Couple of things:

+       if (end < buf - 1) {
+               end = ((void *) -1);
+               size = end - buf + 1;
+       }

This is odd.  It seems to be saying that if we're trying to
wrap around the end of memory, we terminate at the end of
memory, yes?  What is the intent here?


Also, my manpage says that vsnprintf should return -1
if it truncated the output.  Your implementation
doesn't do that, but trivially could.

Alan, we can drop the overrun-detector from printk now.

--- linux-2.4.6-ac5/kernel/printk.c	Tue Jul 17 00:59:21 2001
+++ ac/kernel/printk.c	Tue Jul 17 01:22:59 2001
@@ -394,11 +394,7 @@ asmlinkage int printk(const char *fmt, .
 	unsigned long flags;
 	int printed_len;
 	char *p;
-	unsigned long sr_copy;
-	static struct {
-		char buf[1024];
-		unsigned long semi_random;
-	} printk_buf;
+	static char printk_buf[1024];
 	static int log_level_unknown = 1;
 
 	if (oops_in_progress) {
@@ -412,19 +408,20 @@ asmlinkage int printk(const char *fmt, .
 	spin_lock_irqsave(&logbuf_lock, flags);
 
 	/* Emit the output into the temporary buffer */
-	printk_buf.semi_random += jiffies;
-	sr_copy = printk_buf.semi_random;
 	va_start(args, fmt);
-	printed_len = vsprintf(printk_buf.buf, fmt, args);
+	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
+	if (printed_len == -1) {
+		/* vsnprintf truncated it, but printk() callers don't
+		 * expect a -1 return value */
+		printed_len = sizeof(printk_buf) - 1;
+	}
 	va_end(args);
-	if (sr_copy != printk_buf.semi_random)
-		panic("buffer overrun in printk()");
 
 	/*
 	 * Copy the output into log_buf.  If the caller didn't provide
 	 * appropriate log level tags, we insert them here
 	 */
-	for (p = printk_buf.buf; *p; p++) {
+	for (p = printk_buf; *p; p++) {
 		if (log_level_unknown) {
 			if (p[0] != '<' || p[1] < '0' || p[1] > '7' || p[2] != '>') {
 				emit_log_char('<');
