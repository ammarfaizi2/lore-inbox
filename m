Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVHXVqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVHXVqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVHXVqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:46:37 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:41172 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S932293AbVHXVqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:46:35 -0400
Message-ID: <430CEA54.7060803@dresco.co.uk>
Date: Wed, 24 Aug 2005 22:44:52 +0100
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       linux-ide@vger.kernel.org
Subject: Re: [Hdaps-devel] Re: HDAPS, Need to park the head for real
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de>
In-Reply-To: <20050816200708.GE3425@suse.de>
Content-Type: multipart/mixed;
 boundary="------------070207020605000201020501"
X-Hops: 1
X-Originating-Pythagoras-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070207020605000201020501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:

> Ok, I'll give you some hints to get you started... What you really want
>
>to do, is:
>
>- Insert a park request at the front of the queue
>- On completion callback on that request, freeze the block queue and
>  schedule it for unfreeze after a given time
>  
>

Am attaching a first attempt at a patch - for comments only - please 
don't apply to a production system. I've not delved into the IDE code 
before, so I've just been following my nose... In other words - It 
appears to work for me - but I may be doing something crazy ;)

Having said that, I tested with a utility that repeatedly froze/thawed 
hundreds of times while really hammering the disk with file copies, and 
nothing oopsed or failed to checksum afterwards...

To do:

Move the /proc interface to sysfs. At the moment it's just a simple 
'echo -n 1 > /proc/ide/hda/freeze' to freeze, and 0 to thaw.

Address Jens concerns about our userspace code falling over and leaving 
the machine hung. I favour retaining a binary on/off interface (rather 
than specifying a timeout up front), but having the IDE code auto-thaw 
on a timer.. That way we can just keep writing 1's to it while we're 
checking the accelerometer and wanting to keep it frozen, and if we 
should die then it'll wake up by itself after a second or so...

Same again for libata (for T43 owners).

Regards,
Jon.



______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
--------------070207020605000201020501
Content-Type: text/x-patch;
 name="ide_freeze.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_freeze.patch"

diff -urN linux-2.6.13-rc6.original/drivers/ide/ide-io.c linux-2.6.13-rc6/drivers/ide/ide-io.c
--- linux-2.6.13-rc6.original/drivers/ide/ide-io.c	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.13-rc6/drivers/ide/ide-io.c	2005-08-24 20:56:31.000000000 +0100
@@ -1181,6 +1181,16 @@
 		}
 
 		/*
+		 * Don't accept a request when the queue is stopped
+		 * (unless we are resuming from suspend)
+		 */
+		if (test_bit(QUEUE_FLAG_STOPPED, &drive->queue->queue_flags) && !blk_pm_resume_request(rq)) {
+			printk(KERN_ERR "%s: queue is stopped!\n", drive->name);
+			hwgroup->busy = 0;
+			break;
+		}
+
+		/*
 		 * Sanity: don't accept a request that isn't a PM request
 		 * if we are currently power managed. This is very important as
 		 * blk_stop_queue() doesn't prevent the elv_next_request()
@@ -1661,6 +1671,9 @@
 		where = ELEVATOR_INSERT_FRONT;
 		rq->flags |= REQ_PREEMPT;
 	}
+	if (action == ide_next)
+		where = ELEVATOR_INSERT_FRONT;
+
 	__elv_add_request(drive->queue, rq, where, 0);
 	ide_do_request(hwgroup, IDE_NO_IRQ);
 	spin_unlock_irqrestore(&ide_lock, flags);
diff -urN linux-2.6.13-rc6.original/drivers/ide/ide-proc.c linux-2.6.13-rc6/drivers/ide/ide-proc.c
--- linux-2.6.13-rc6.original/drivers/ide/ide-proc.c	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.13-rc6/drivers/ide/ide-proc.c	2005-08-24 21:51:14.000000000 +0100
@@ -264,6 +264,122 @@
 	return -EINVAL;
 }
 
+static int proc_ide_read_freeze
+	(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ide_drive_t	*drive = (ide_drive_t *) data;
+	char		*out = page;
+	int		len;
+
+	proc_ide_settings_warn();
+
+	if (test_bit(QUEUE_FLAG_STOPPED, &drive->queue->queue_flags))
+		out += sprintf(out, "%s: queue is stopped\n", drive->name);
+	else
+		out += sprintf(out, "%s: queue not stopped\n", drive->name);
+
+	len = out - page;
+	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
+}
+
+void ide_end_freeze_rq(struct request *rq)
+{
+	struct completion	*waiting = rq->waiting;
+	u8			*argbuf = rq->buffer;
+
+	/* Spinlock is already acquired */
+	if (argbuf[3] == 0xc4) {
+		blk_stop_queue(rq->q);
+		printk(KERN_ERR "ide_end_freeze_rq(): Queue stopped...\n");
+	}
+	else
+		printk(KERN_ERR "ide_end_freeze_rq(): Head not parked...\n");
+/*
+	blk_stop_queue(rq->q);
+	printk(KERN_ERR "ide_end_freeze_rq(): Queue stopped...\n");
+*/
+	complete(waiting);
+}
+
+static int proc_ide_write_freeze(struct file *file, const char __user *buffer,
+				   unsigned long count, void *data)
+{
+	DECLARE_COMPLETION(wait);
+	unsigned long	val, flags;
+	char 		*buf, *s;	
+	struct request	rq;
+	ide_drive_t	*drive = (ide_drive_t *) data;
+	u8 		args[7], *argbuf = args;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	proc_ide_settings_warn();
+
+	if (count >= PAGE_SIZE)
+		return -EINVAL;
+
+	s = buf = (char *)__get_free_page(GFP_USER);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, buffer, count)) {
+		free_page((unsigned long)buf);
+		return -EFAULT;
+	}
+
+	buf[count] = '\0';
+	memset(&rq, 0, sizeof(rq));
+	memset(&args, 0, sizeof(args));
+
+	/* Ought to check we're the right sort of device - i.e. hard disk only */
+
+	/* STANDY IMMEDIATE COMMAND (spins down drive - more obvious for testing?)
+	argbuf[0] = 0xe0;
+	*/
+
+	/* UNLOAD IMMEDIATE COMMAND */
+	argbuf[0] = 0xe1;
+	argbuf[1] = 0x44;
+	argbuf[3] = 0x4c;
+	argbuf[4] = 0x4e;
+	argbuf[5] = 0x55;
+
+	/* Ought to have some sanity checking around these values */
+	val = simple_strtoul(buf, &s, 10);
+	if (val) {
+		/* Check we're not already frozen */
+		if (!test_bit(QUEUE_FLAG_STOPPED, &drive->queue->queue_flags)) {
+			/* Issue the park command & freeze */
+			ide_init_drive_cmd(&rq);
+
+			rq.flags = REQ_DRIVE_TASK;
+			rq.buffer = argbuf;
+			rq.waiting = &wait;
+			rq.end_io = ide_end_freeze_rq;
+
+			ide_do_drive_cmd(drive, &rq, ide_next);
+			wait_for_completion(&wait);
+			rq.waiting = NULL;
+		}
+		else
+			printk(KERN_ERR "proc_ide_write_freeze(): Queue already stopped...\n");
+	}
+	else {
+		/* Check we are frozen & unfreeze */ 
+		if (test_bit(QUEUE_FLAG_STOPPED, &drive->queue->queue_flags)) {
+			spin_lock_irqsave(&ide_lock, flags);
+			blk_start_queue(drive->queue);
+			spin_unlock_irqrestore(&ide_lock, flags);
+			printk(KERN_ERR "proc_ide_write_freeze(): Queue started...\n");
+		}
+		else
+			printk(KERN_ERR "proc_ide_write_freeze(): Queue not stopped...\n");
+	}
+	free_page((unsigned long)buf);
+	return count;
+}
+
 int proc_ide_read_capacity
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -390,6 +506,7 @@
 	{ "media",	S_IFREG|S_IRUGO,	proc_ide_read_media,	NULL },
 	{ "model",	S_IFREG|S_IRUGO,	proc_ide_read_dmodel,	NULL },
 	{ "settings",	S_IFREG|S_IRUSR|S_IWUSR,proc_ide_read_settings,	proc_ide_write_settings },
+	{ "freeze",	S_IFREG|S_IRUSR|S_IWUSR,proc_ide_read_freeze,	proc_ide_write_freeze },
 	{ NULL,	0, NULL, NULL }
 };
 

--------------070207020605000201020501--
