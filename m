Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267874AbTAMGOJ>; Mon, 13 Jan 2003 01:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267904AbTAMGOJ>; Mon, 13 Jan 2003 01:14:09 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:42756 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267874AbTAMGOF>;
	Mon, 13 Jan 2003 01:14:05 -0500
Date: Sun, 12 Jan 2003 22:23:00 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113062300.GA3804@kroah.com>
References: <20030112171744.A11040@infradead.org> <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 11:15:52AM -0800, Linus Torvalds wrote:
> 
> Anybody willing to test it and see if the above works? 

Hm, I just did, and it seems to work for me.  I ran a bunch of different
usb-serial drivers through some tests, but these worked for me without
this patch.  I don't know what stress tests Alan was running to show up
a problem.

Anyway, here's a patch with your new lock, if you want to apply it.

thanks,

greg k-h


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Sun Jan 12 22:27:42 2003
+++ b/drivers/char/tty_io.c	Sun Jan 12 22:27:42 2003
@@ -159,6 +159,58 @@
 extern void tx3912_rs_init(void);
 extern void hvc_console_init(void);
 
+
+/*
+* This isn't even _trying_ to be fast!
+*/
+struct recursive_spinlock {
+	spinlock_t lock;
+	int lock_count;
+	struct task_struct *lock_owner;
+};
+
+static struct recursive_spinlock tty_lock = {
+	.lock = SPIN_LOCK_UNLOCKED,
+	.lock_count = 0,
+	.lock_owner = NULL
+};
+
+unsigned long tty_spin_lock(void)
+{
+	unsigned long flags;
+	struct task_struct *tsk;
+
+	local_irq_save(flags);
+	preempt_disable();
+	tsk = current;
+	if (spin_trylock(&tty_lock.lock))
+		goto got_lock;
+	if (tsk == tty_lock.lock_owner) {
+		WARN_ON(!tty_lock.lock_count);
+		tty_lock.lock_count++;
+		return flags;
+	}
+	spin_lock(&tty_lock.lock);
+got_lock:
+	WARN_ON(tty_lock.lock_owner);
+	WARN_ON(tty_lock.lock_count);
+	tty_lock.lock_owner = tsk;
+	tty_lock.lock_count = 1;
+	return flags;
+}
+
+void tty_spin_unlock(unsigned long flags)
+{
+	WARN_ON(tty_lock.lock_owner != current);
+	WARN_ON(!tty_lock.lock_count);
+	if (!--tty_lock.lock_count) {
+		tty_lock.lock_owner = NULL;
+		spin_unlock(&tty_lock.lock);
+	}
+	preempt_enable();
+	local_irq_restore(flags);
+}
+
 static struct tty_struct *alloc_tty_struct(void)
 {
 	struct tty_struct *tty;
@@ -460,7 +512,7 @@
 	{
 		unsigned long flags;
 
-		local_irq_save(flags); // FIXME: is this safe?
+		flags = tty_spin_lock();
 		if (tty->ldisc.flush_buffer)
 			tty->ldisc.flush_buffer(tty);
 		if (tty->driver.flush_buffer)
@@ -468,7 +520,7 @@
 		if ((test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
 		    tty->ldisc.write_wakeup)
 			(tty->ldisc.write_wakeup)(tty);
-		local_irq_restore(flags); // FIXME: is this safe?
+		tty_spin_unlock(flags);
 	}
 
 	wake_up_interruptible(&tty->write_wait);
@@ -1926,7 +1978,7 @@
 		fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
 		tty->flip.buf_num = 0;
 
-		local_irq_save(flags); // FIXME: is this safe?
+		flags = tty_spin_lock();
 		tty->flip.char_buf_ptr = tty->flip.char_buf;
 		tty->flip.flag_buf_ptr = tty->flip.flag_buf;
 	} else {
@@ -1934,13 +1986,13 @@
 		fp = tty->flip.flag_buf;
 		tty->flip.buf_num = 1;
 
-		local_irq_save(flags); // FIXME: is this safe?
+		flags = tty_spin_lock();
 		tty->flip.char_buf_ptr = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
 		tty->flip.flag_buf_ptr = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
 	}
 	count = tty->flip.count;
 	tty->flip.count = 0;
-	local_irq_restore(flags); // FIXME: is this safe?
+	tty_spin_unlock(flags);
 	
 	tty->ldisc.receive_buf(tty, cp, fp, count);
 }
