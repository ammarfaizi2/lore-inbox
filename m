Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263419AbRFAIsk>; Fri, 1 Jun 2001 04:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263421AbRFAIsb>; Fri, 1 Jun 2001 04:48:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36357 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263419AbRFAIsX>; Fri, 1 Jun 2001 04:48:23 -0400
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for real this
To: thockin@sun.com (Tim Hockin)
Date: Fri, 1 Jun 2001 09:46:17 +0100 (BST)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B17025B.E5E23095@sun.com> from "Tim Hockin" at May 31, 2001 07:47:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155kZV-0000Db-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +		/* setup osb4 i/o regions */
> +		if ((reg = get_reg(OSB4_INDEX_PORT, OSB4_DATA_PORT, 0x20)))
> +			request_region(reg, 4, "OSB4 (pm1a_evt_blk)");

Check request_region worked

> +static int 
> +i2c_wait_for_smi(void)

Obvious question - why duplicate the i2c layer

> +/* device structure */
> +static struct miscdevice lcd_dev = {
> +	COBALT_LCD_MINOR,

Is this an officially allocated minor ?

> +	/* Get the current cursor position */
> +        case LCD_Get_Cursor_Pos:
> +                display.cursor_address = lcddev_read_inst();
> +                display.cursor_address = display.cursor_address & 0x07F;
> +                copy_to_user((struct lcd_display *)arg, &display, dlen);

		Sleeping holding a spinlock

> +        case LCD_Set_Cursor_Pos:
> +                copy_from_user(&display, (struct lcd_display *)arg, dlen);

Ditto. Also should check the return and return -EFAULT if so

> +/* LED daemon sits on this, we wake it up once a key is pressed */
> +static ssize_t 
> +cobalt_lcd_read(struct file *file, char *buf, size_t count, loff_t *ppos)
> +{
> +	int buttons_now;
> +	static atomic_t lcd_waiters = ATOMIC_INIT(0);
> +
> +	if (atomic_read(&lcd_waiters) > 0)
> +		return -EINVAL;
> +	atomic_inc(&lcd_waiters);

Unsafe. Two people can execute the atomic_read before anyone executes
the atomic_inc. You probably want test_and_set_bit() or a semaphore

> +	while (((buttons_now = button_pressed()) == 0) &&
> +	       !(signal_pending(current)))
> +	{
> +		current->state = TASK_INTERRUPTIBLE;

We have a set_ function for this.. ALso what stops an ioctl occuring at
the same instant ?


