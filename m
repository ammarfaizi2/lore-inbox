Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131744AbQLRMbG>; Mon, 18 Dec 2000 07:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130208AbQLRMa4>; Mon, 18 Dec 2000 07:30:56 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:24292 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S131744AbQLRMas>;
	Mon, 18 Dec 2000 07:30:48 -0500
Message-ID: <3A3DFB6A.B4806C76@yahoo.com>
Date: Mon, 18 Dec 2000 13:56:26 +0200
From: Bali <ext-balazs.kilvady@nokia.com>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: psaux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

As i saw the most of the mouse drivers are using busmouse.c as a base
module. I modified the pc_keyb.c to let the psaux device use the same
base as others (there is a q????? driver which could be modified this
way, but i can't test that).
Advantages:
- no queue buffer needed
- common base code with other drivers
- much less code in pc_keyb.c
- easier to detect reconnect because now it collects the 3 bytes input
so the previous bytes could be checked. The original handles all the
0xaa as a reconnect info but it could be a delta_x or a delta_y as well.
Disadvantages:
- pc_keyb.c compiled as built-in part of the kernel (keyboard of default
vga console, ...) so busmouse.c has to be compiled in instead of as a
kernel module.
- busmouse.c doesn't support reading less than 3 bytes (by the way, why
not? That would be closer to POSIX read standard, wouldn't it?) but the
current tools (X, gpm) read one byte at a time from the psaux device. So
i configured them to read from /dev/psaux but use busmouse protocol and
i added a code which translates from ps/2 to busmouse protocol. But this
way the ps/2 mouse could use the /dev/busmouse device file name (or what
it's name?) so it would be used as a real busmouse.

So if anyone thinks it is worth a try than test it and/or mail me what
You think about it.

The patch:
--- v2.4.0-test12/linux/drivers/char/pc_keyb.c	Mon Dec 18 13:37:16 2000
+++ linux/pc_keyb.c	Mon Dec 18 13:35:10 2000
@@ -13,9 +13,12 @@
  * Code fixes to handle mouse ACKs properly.
  * C. Scott Ananian <cananian@alumni.princeton.edu> 1999-01-29.
  *
+ * Converted to use generic busmouse code.  13 Dec 2000
+ *   Balazs Kilvady <balitm@yahoo.org>
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 
 #include <linux/spinlock.h>
 #include <linux/sched.h>
@@ -32,6 +35,7 @@
 #include <linux/malloc.h>
 #include <linux/kbd_kern.h>
 #include <linux/smp_lock.h>
+#include "busmouse.h"
 
 #include <asm/keyboard.h>
 #include <asm/bitops.h>
@@ -82,11 +86,14 @@
 
 #define AUX_RECONNECT 170 /* scancode when ps2 device is plugged (back)
in */
  
-static struct aux_queue *queue;	/* Mouse data buffer. */
 static int aux_count;
 /* used when we send commands to the mouse that expect an ACK. */
 static unsigned char mouse_reply_expected;
 
+static char tmp_byte[ 3 ];	/* byte buffer to collect a whole event */
+static int b_num;		/* position in tmp_byte */
+static int msedev;		/* busmouse device id */
+
 #define AUX_INTS_OFF (KBD_MODE_KCC | KBD_MODE_DISABLE_MOUSE |
KBD_MODE_SYS | KBD_MODE_KBD_INT)
 #define AUX_INTS_ON  (KBD_MODE_KCC | KBD_MODE_SYS | KBD_MODE_MOUSE_INT
| KBD_MODE_KBD_INT)
 
@@ -395,6 +402,8 @@
 static inline void handle_mouse_event(unsigned char scancode)
 {
 #ifdef CONFIG_PSMOUSE
+	static int is_recon;
+
 	if (mouse_reply_expected) {
 		if (scancode == AUX_ACK) {
 			mouse_reply_expected--;
@@ -402,23 +411,58 @@
 		}
 		mouse_reply_expected = 0;
 	}
-	else if(scancode == AUX_RECONNECT){
-		queue->head = queue->tail = 0;  /* Flush input queue */
+
+	/*
+	 * reconnect 'message' is 2 bytes long: 0xaa, 0x00
+	 */
+	if (is_recon && scancode == '\0') {
+		printk(KERN_INFO "psmintr: reconnect catched at: %d, scode: 0x%02x,
prevs: %02x, %02x, %02x!\n",
+			b_num,
+			(unsigned)scancode,
+			(unsigned)*((unsigned char *)tmp_byte),
+			(unsigned)*((unsigned char *)(tmp_byte + 1)),
+			(unsigned)*((unsigned char *)(tmp_byte + 2)));
+		is_recon = 0;
+		b_num = 0;
 		aux_write_ack(AUX_ENABLE_DEV);  /* ping the mouse :) */
 		return;
-	}
+	} else if (scancode == AUX_RECONNECT) {
+		is_recon = 1;
+		printk(KERN_INFO "psmintr: reconnect code at: %d\n", b_num);
+	} else
+		is_recon = 0;
 
 	add_mouse_randomness(scancode);
 	if (aux_count) {
-		int head = queue->head;
+		int button;
 
-		queue->buf[head] = scancode;
-		head = (head + 1) & (AUX_BUF_SIZE-1);
-		if (head != queue->tail) {
-			queue->head = head;
-			kill_fasync(&queue->fasync, SIGIO, POLL_IN);
-			wake_up_interruptible(&queue->proc_list);
+		tmp_byte[ b_num ] = (signed char)scancode;
+		if (b_num < 2) {
+			/*
+			 * first byte?
+			 */
+			if (b_num != 0
+				|| (scancode & AUX_CHECK_BITS) == AUX_CHECK_RES)
+				++b_num;
+			else
+				printk(KERN_INFO "psmintr: it shouldn't happen, 0th byte: 0x%02x,
prevs: %02x, %02x!\n",
+					(unsigned)scancode,
+					(unsigned)*((unsigned char *)(tmp_byte + 1)),
+					(unsigned)*((unsigned char *)(tmp_byte + 2)));
+			return;
 		}
+		b_num = 0;
+
+		/*
+		 * translate to busmouse protocol
+		 */
+		button = (int)(~tmp_byte[ 0 ]);
+		button = ((button >> 1) & 3) | ((button << 2) & 4);
+		busmouse_add_movementbuttons(
+				msedev,
+				(int)tmp_byte[ 1 ],
+				(int)tmp_byte[ 2 ],
+				button);
 	}
 #endif
 }
@@ -801,21 +845,6 @@
 }
 
 /*
- * Send a byte to the mouse.
- */
-static void aux_write_dev(int val)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&kbd_controller_lock, flags);
-	kb_wait();
-	kbd_write_command(KBD_CCMD_WRITE_MOUSE);
-	kb_wait();
-	kbd_write_output(val);
-	spin_unlock_irqrestore(&kbd_controller_lock, flags);
-}
-
-/*
  * Send a byte to the mouse & handle returned ack
  */
 static void aux_write_ack(int val)
@@ -833,44 +862,29 @@
 	spin_unlock_irqrestore(&kbd_controller_lock, flags);
 }
 
-static unsigned char get_from_queue(void)
-{
-	unsigned char result;
-	unsigned long flags;
-
-	spin_lock_irqsave(&kbd_controller_lock, flags);
-	result = queue->buf[queue->tail];
-	queue->tail = (queue->tail + 1) & (AUX_BUF_SIZE-1);
-	spin_unlock_irqrestore(&kbd_controller_lock, flags);
-	return result;
-}
-
-
-static inline int queue_empty(void)
-{
-	return queue->head == queue->tail;
-}
-
-static int fasync_aux(int fd, struct file *filp, int on)
-{
-	int retval;
-
-	retval = fasync_helper(fd, filp, on, &queue->fasync);
-	if (retval < 0)
-		return retval;
-	return 0;
-}
-
-
 /*
  * Random magic cookie for the aux device
  */
-#define AUX_DEV ((void *)queue)
+#define AUX_DEV ((void *)tmp_byte)
 
 static int release_aux(struct inode * inode, struct file * file)
 {
 	lock_kernel();
-	fasync_aux(-1, file, 0);
+
+	/*
+	 * temp checking: The mouse sends 3 bytes but we haven't read all of
it
+	 * but close the device. It's (almost) sure that free_irq solves it,
+	 * but... 
+	 */
+	if (b_num != 0)
+		printk(KERN_INFO "release_aux: called when not at 3 bytes boundary,
b_num: %d\n",
+			b_num);
+
+	/*
+	 * fasync call commented out, it can be a problem but busmouse handles
+	 * fasync things inside :-(
+	 */
+	//fasync_aux(-1, file, 0);
 	if (--aux_count) {
 		unlock_kernel();
 		return 0;
@@ -892,7 +906,14 @@
 	if (aux_count++) {
 		return 0;
 	}
-	queue->head = queue->tail = 0;		/* Flush input queue */
+	/*
+	 * temp checking: It can cause problem when more then one program
+	 * read the device but it's not supported in busmouse
+	 */
+	if (b_num != 0)
+		printk(KERN_INFO "open_aux: called when not at 3 bytes boundary,
b_num: %d\n",
+			b_num);
+	b_num = 0;
 	if (aux_request_irq(keyboard_interrupt, AUX_DEV)) {
 		aux_count--;
 		return -EBUSY;
@@ -909,96 +930,10 @@
 }
 
 /*
- * Put bytes from input queue to buffer.
- */
-
-static ssize_t read_aux(struct file * file, char * buffer,
-			size_t count, loff_t *ppos)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	ssize_t i = count;
-	unsigned char c;
-
-	if (queue_empty()) {
-		if (file->f_flags & O_NONBLOCK)
-			return -EAGAIN;
-		add_wait_queue(&queue->proc_list, &wait);
-repeat:
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (queue_empty() && !signal_pending(current)) {
-			schedule();
-			goto repeat;
-		}
-		current->state = TASK_RUNNING;
-		remove_wait_queue(&queue->proc_list, &wait);
-	}
-	while (i > 0 && !queue_empty()) {
-		c = get_from_queue();
-		put_user(c, buffer++);
-		i--;
-	}
-	if (count-i) {
-		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
-		return count-i;
-	}
-	if (signal_pending(current))
-		return -ERESTARTSYS;
-	return 0;
-}
-
-/*
- * Write to the aux device.
- */
-
-static ssize_t write_aux(struct file * file, const char * buffer,
-			 size_t count, loff_t *ppos)
-{
-	ssize_t retval = 0;
-
-	if (count) {
-		ssize_t written = 0;
-
-		if (count > 32)
-			count = 32; /* Limit to 32 bytes. */
-		do {
-			char c;
-			get_user(c, buffer++);
-			aux_write_dev(c);
-			written++;
-		} while (--count);
-		retval = -EIO;
-		if (written) {
-			retval = written;
-			file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
-		}
-	}
-
-	return retval;
-}
-
-/* No kernel lock held - fine */
-static unsigned int aux_poll(struct file *file, poll_table * wait)
-{
-	poll_wait(file, &queue->proc_list, wait);
-	if (!queue_empty())
-		return POLLIN | POLLRDNORM;
-	return 0;
-}
-
-struct file_operations psaux_fops = {
-	read:		read_aux,
-	write:		write_aux,
-	poll:		aux_poll,
-	open:		open_aux,
-	release:	release_aux,
-	fasync:		fasync_aux,
-};
-
-/*
  * Initialize driver.
  */
-static struct miscdevice psaux_mouse = {
-	PSMOUSE_MINOR, "psaux", &psaux_fops
+static struct busmouse psaux_mouse = {
+	PSMOUSE_MINOR, "psaux", THIS_MODULE, open_aux, release_aux, 7
 };
 
 static int __init psaux_init(void)
@@ -1006,11 +941,8 @@
 	if (!detect_auxiliary_port())
 		return -EIO;
 
-	misc_register(&psaux_mouse);
-	queue = (struct aux_queue *) kmalloc(sizeof(*queue), GFP_KERNEL);
-	memset(queue, 0, sizeof(*queue));
-	queue->head = queue->tail = 0;
-	init_waitqueue_head(&queue->proc_list);
+	b_num = 0;
+	msedev = register_busmouse(&psaux_mouse);
 
 #ifdef INITIALIZE_MOUSE
 	kbd_write_command_w(KBD_CCMD_MOUSE_ENABLE); /* Enable Aux. */
@@ -1023,7 +955,11 @@
 	kbd_write_command(KBD_CCMD_MOUSE_DISABLE); /* Disable aux device. */
 	kbd_write_cmd(AUX_INTS_OFF); /* Disable controller ints. */
 
-	return 0;
+	if (msedev < 0)
+		printk(KERN_WARNING "Unable to register psaux driver.\n");
+	else
+		printk(KERN_INFO "PS/2 mouse detected and installed.\n");
+	return msedev < 0 ? msedev : 0;
 }
 
 #endif /* CONFIG_PSMOUSE */
--- v2.4.0-test12/linux/include/linux/pc_keyb.h	Mon Dec 18 13:37:33 2000
+++ linux/pc_keyb.h	Wed Dec 13 14:27:23 2000
@@ -115,16 +115,12 @@
 #define AUX_DISABLE_DEV		0xF5	/* Disable aux device */
 #define AUX_RESET		0xFF	/* Reset aux device */
 #define AUX_ACK			0xFA	/* Command byte ACK. */
+#define AUX_CHECK_BITS		0xC8	/* At normal data C bits should be 0,
+					   8 bit should be 1 */
+#define AUX_CHECK_RES		0x08
 
 #define AUX_BUF_SIZE		2048	/* This might be better divisible by
 					   three to make overruns stay in sync
 					   but then the read function would need
 					   a lock etc - ick */
 
-struct aux_queue {
-	unsigned long head;
-	unsigned long tail;
-	wait_queue_head_t proc_list;
-	struct fasync_struct *fasync;
-	unsigned char buf[AUX_BUF_SIZE];
-};
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
