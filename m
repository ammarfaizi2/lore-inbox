Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVC3Gax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVC3Gax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVC3Gax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:30:53 -0500
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:61793 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261753AbVC3GaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:30:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alexey Dobriyan <adobriyan@mail.ru>
Subject: Re: 2.6.12-rc1-bk2+PREEMPT_BKL: Oops at serio_interrupt
Date: Wed, 30 Mar 2005 01:30:11 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200503282126.55366.adobriyan@mail.ru> <d120d50005032911027c13436e@mail.gmail.com> <200503292349.55319.adobriyan@mail.ru>
In-Reply-To: <200503292349.55319.adobriyan@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503300130.12736.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 March 2005 14:49, Alexey Dobriyan wrote:
> On Tuesday 29 March 2005 23:02, Dmitry Torokhov wrote:
> > On Tue, 29 Mar 2005 21:28:20 +0400, Alexey Dobriyan <adobriyan@mail.ru> wrote:
> > > On Tuesday 29 March 2005 10:27, Dmitry Torokhov wrote:
> > > > On Monday 28 March 2005 12:26, Alexey Dobriyan wrote:
> > > > > Steps to reproduce for me:
> > > > >     * Boot CONFIG_PREEMPT_BKL=y kernel (.config, dmesg are attached)
> > > > >     * Start rebooting
> > > > >     * Start moving serial mouse (I have Genius NetMouse Pro)
> > > > >     * Right after gpm is shut down I see the oops
> > > > >     * The system continues to reboot
> > > >
> > > > Could you try the patch below, please? Thanks!
> > > 
> > > > Input: serport - fix an Oops when closing port - should not call
> > > >        serio_interrupt when serio port is being unregistered.
> > > 
> > > Doesn't work, sorry. Even worse: rebooting now also produces many pages of
> > > oopsen, then hang the system. I'm willing to test any new patches.
> > 
> > Does it oops at the same place with this patch or at some other place?
> 
> I manage to find this in the logs (nothing more :-( ):
> ============================================================================
> Unable to handle kernel NULL pointer dereference at virtual address 00000068
>  printing eip:
> c0202947
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables binfmt_misc uhci_hcd snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc floppy
> CPU:    0
> EIP:    0060:[<c0202947>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.12-rc1-bk2-serio) 
> ============================================================================
> According to vmlinux, c0202947 is at:
> 
> c020293e <serport_ldisc_write_wakeup>:

Could you please try this one instead? Thanks!

-- 
Dmitry


 serport.c |   98 +++++++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 68 insertions(+), 30 deletions(-)

Index: dtor/drivers/input/serio/serport.c
===================================================================
--- dtor.orig/drivers/input/serio/serport.c
+++ dtor/drivers/input/serio/serport.c
@@ -27,11 +27,15 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS_LDISC(N_MOUSE);
 
 #define SERPORT_BUSY	1
+#define SERPORT_ACTIVE	2
+#define SERPORT_DEAD	3
 
 struct serport {
 	struct tty_struct *tty;
 	wait_queue_head_t wait;
 	struct serio *serio;
+	struct serio_device_id id;
+	spinlock_t lock;
 	unsigned long flags;
 };
 
@@ -45,11 +49,29 @@ static int serport_serio_write(struct se
 	return -(serport->tty->driver->write(serport->tty, &data, 1) != 1);
 }
 
+static int serport_serio_open(struct serio *serio)
+{
+	struct serport *serport = serio->port_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&serport->lock, flags);
+	set_bit(SERPORT_ACTIVE, &serport->flags);
+	spin_unlock_irqrestore(&serport->lock, flags);
+
+	return 0;
+}
+
+
 static void serport_serio_close(struct serio *serio)
 {
 	struct serport *serport = serio->port_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&serport->lock, flags);
+	clear_bit(SERPORT_ACTIVE, &serport->flags);
+	set_bit(SERPORT_DEAD, &serport->flags);
+	spin_unlock_irqrestore(&serport->lock, flags);
 
-	serport->serio->id.type = 0;
 	wake_up_interruptible(&serport->wait);
 }
 
@@ -61,36 +83,21 @@ static void serport_serio_close(struct s
 static int serport_ldisc_open(struct tty_struct *tty)
 {
 	struct serport *serport;
-	struct serio *serio;
-	char name[64];
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	serport = kmalloc(sizeof(struct serport), GFP_KERNEL);
-	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
-	if (unlikely(!serport || !serio)) {
-		kfree(serport);
-		kfree(serio);
+	serport = kcalloc(1, sizeof(struct serport), GFP_KERNEL);
+	if (!serport)
 		return -ENOMEM;
-	}
 
-	memset(serport, 0, sizeof(struct serport));
-	serport->serio = serio;
-	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	serport->tty = tty;
-	tty->disc_data = serport;
-
-	memset(serio, 0, sizeof(struct serio));
-	strlcpy(serio->name, "Serial port", sizeof(serio->name));
-	snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", tty_name(tty, name));
-	serio->id.type = SERIO_RS232;
-	serio->write = serport_serio_write;
-	serio->close = serport_serio_close;
-	serio->port_data = serport;
-
+	spin_lock_init(&serport->lock);
 	init_waitqueue_head(&serport->wait);
 
+	tty->disc_data = serport;
+	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+
 	return 0;
 }
 
@@ -100,7 +107,8 @@ static int serport_ldisc_open(struct tty
 
 static void serport_ldisc_close(struct tty_struct *tty)
 {
-	struct serport *serport = (struct serport*) tty->disc_data;
+	struct serport *serport = (struct serport *) tty->disc_data;
+
 	kfree(serport);
 }
 
@@ -116,9 +124,19 @@ static void serport_ldisc_close(struct t
 static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *cp, char *fp, int count)
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
+	unsigned long flags;
 	int i;
+
+	spin_lock_irqsave(&serport->lock, flags);
+
+	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
+		goto out;
+
 	for (i = 0; i < count; i++)
 		serio_interrupt(serport->serio, cp[i], 0, NULL);
+
+out:
+	spin_unlock_irqrestore(&serport->lock, flags);
 }
 
 /*
@@ -141,16 +159,33 @@ static int serport_ldisc_room(struct tty
 static ssize_t serport_ldisc_read(struct tty_struct * tty, struct file * file, unsigned char __user * buf, size_t nr)
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
+	struct serio *serio;
 	char name[64];
 
 	if (test_and_set_bit(SERPORT_BUSY, &serport->flags))
 		return -EBUSY;
 
+	serport->serio = serio = kcalloc(1, sizeof(struct serio), GFP_KERNEL);
+	if (!serio)
+		return -ENOMEM;
+
+	strlcpy(serio->name, "Serial port", sizeof(serio->name));
+	snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", tty_name(tty, name));
+	serio->id = serport->id;
+	serio->id.type = SERIO_RS232;
+	serio->write = serport_serio_write;
+	serio->open = serport_serio_open;
+	serio->close = serport_serio_close;
+	serio->port_data = serport;
+
 	serio_register_port(serport->serio);
 	printk(KERN_INFO "serio: Serial port %s\n", tty_name(tty, name));
-	wait_event_interruptible(serport->wait, !serport->serio->id.type);
+
+	wait_event_interruptible(serport->wait, test_bit(SERPORT_DEAD, &serport->flags));
 	serio_unregister_port(serport->serio);
+	serport->serio = NULL;
 
+	clear_bit(SERPORT_DEAD, &serport->flags);
 	clear_bit(SERPORT_BUSY, &serport->flags);
 
 	return 0;
@@ -163,16 +198,15 @@ static ssize_t serport_ldisc_read(struct
 static int serport_ldisc_ioctl(struct tty_struct * tty, struct file * file, unsigned int cmd, unsigned long arg)
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
-	struct serio *serio = serport->serio;
 	unsigned long type;
 
 	if (cmd == SPIOCSTYPE) {
 		if (get_user(type, (unsigned long __user *) arg))
 			return -EFAULT;
 
-		serio->id.proto	= type & 0x000000ff;
-		serio->id.id	= (type & 0x0000ff00) >> 8;
-		serio->id.extra	= (type & 0x00ff0000) >> 16;
+		serport->id.proto = type & 0x000000ff;
+		serport->id.id	  = (type & 0x0000ff00) >> 8;
+		serport->id.extra = (type & 0x00ff0000) >> 16;
 
 		return 0;
 	}
@@ -182,9 +216,13 @@ static int serport_ldisc_ioctl(struct tt
 
 static void serport_ldisc_write_wakeup(struct tty_struct * tty)
 {
-	struct serport *sp = (struct serport *) tty->disc_data;
+	struct serport *serport = (struct serport *) tty->disc_data;
+	unsigned long flags;
 
-	serio_drv_write_wakeup(sp->serio);
+	spin_lock_irqsave(&serport->lock, flags);
+	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
+		serio_drv_write_wakeup(serport->serio);
+	spin_unlock_irqrestore(&serport->lock, flags);
 }
 
 /*
