Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbTEFSjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbTEFSjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:39:03 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:4551 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264012AbTEFSi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:38:59 -0400
Date: Tue, 6 May 2003 20:47:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: serial ioctl emulation done right
Message-ID: <20030506184731.GA5419@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

What about this one? This makes it possible to kill copy from
x86-64/ia32/ia32_ioctl.c, and adds support for setserial on all
architectures...

							Pavel

Index: linux/drivers/serial/core.c
===================================================================
--- linux.orig/drivers/serial/core.c	2003-05-06 00:50:12.000000000 +0200
+++ linux/drivers/serial/core.c	2003-05-06 19:38:50.000000000 +0200
@@ -1147,6 +1147,66 @@
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+struct serial_struct32 {
+	int	type;
+	int	line;
+	unsigned int	port;
+	int	irq;
+	int	flags;
+	int	xmit_fifo_size;
+	int	custom_divisor;
+	int	baud_base;
+	unsigned short	close_delay;
+	char	io_type;
+	char	reserved_char[1];
+	int	hub6;
+	unsigned short	closing_wait; /* time to wait before closing */
+	unsigned short	closing_wait2; /* no longer used... */
+	__u32 iomem_base;
+	unsigned short	iomem_reg_shift;
+	unsigned int	port_high;
+	int	reserved[1];
+};
+
+static int serial_struct_ioctl(unsigned fd, unsigned cmd,  void *ptr) 
+{
+	typedef struct serial_struct SS;
+	struct serial_struct32 *ss32 = ptr; 
+	int err;
+	struct serial_struct ss; 
+	mm_segment_t oldseg = get_fs(); 
+	if (cmd == TIOCSSERIAL) { 
+		if (copy_from_user(&ss, ss32, sizeof(struct serial_struct32)))
+			return -EFAULT;
+		memmove(&ss.iomem_reg_shift, ((char*)&ss.iomem_base)+4, 
+			sizeof(SS)-offsetof(SS,iomem_reg_shift)); 
+		ss.iomem_base = (void *)((unsigned long)ss.iomem_base & 0xffffffff);
+	}
+	set_fs(KERNEL_DS);
+		err = sys_ioctl(fd,cmd,(unsigned long)(&ss)); 
+	set_fs(oldseg);
+	if (cmd == TIOCGSERIAL && err >= 0) { 
+		if (__copy_to_user(ss32,&ss,offsetof(SS,iomem_base)) ||
+		    __put_user((unsigned long)ss.iomem_base  >> 32 ? 
+			       0xffffffff : (unsigned)(unsigned long)ss.iomem_base,
+			       &ss32->iomem_base) ||
+		    __put_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift) ||
+		    __put_user(ss.port_high, &ss32->port_high))
+			return -EFAULT;
+	} 
+	return err;	
+}
+
+static void __init init_compat(void)
+{
+    register_ioctl32_conversion(TIOCGSERIAL, serial_struct_ioctl);
+    register_ioctl32_conversion(TIOCSSERIAL, serial_struct_ioctl);
+}
+
+__initcall(init_compat);
+#endif
+
 static void uart_set_termios(struct tty_struct *tty, struct termios *old_termios)
 {
 	struct uart_state *state = tty->driver_data;

%diffstat
 drivers/serial/core.c        |   60 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/compat_ioctl.h |    3 +-
 2 files changed, 62 insertions(+), 1 deletion(-)


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
