Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbULXW6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbULXW6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 17:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbULXW6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 17:58:42 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:41204 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261454AbULXW6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 17:58:30 -0500
Message-ID: <41CC9F2A.9080905@verizon.net>
Date: Fri, 24 Dec 2004 17:58:50 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A general question on SMP-safe driver code.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [209.158.220.243] at Fri, 24 Dec 2004 16:58:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at a few older drivers, I'm trying to figure out the best ways to handle 
some locking.  Using drivers/char/esp.c as an example (since it's the one I'm 
trying to grok right now), here is one example:

static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
{
	struct esp_struct *info = (struct esp_struct *)tty->driver_data;
	unsigned long orig_jiffies, char_time;
	unsigned long flags;

	if (serial_paranoia_check(info, tty->name, "rs_wait_until_sent"))
		return;

	orig_jiffies = jiffies;
	char_time = ((info->timeout - HZ / 50) / 1024) / 5;

	if (!char_time)
		char_time = 1;

	save_flags(flags); cli();
	serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
	serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);

	while ((serial_in(info, UART_ESI_STAT1) != 0x03) ||
		(serial_in(info, UART_ESI_STAT2) != 0xff)) {
		msleep_interruptible(jiffies_to_msecs(char_time));

		if (signal_pending(current))
			break;

		if (timeout && time_after(jiffies, orig_jiffies + timeout))
			break;

		serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
		serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);
	}
	
	restore_flags(flags);
	set_current_state(TASK_RUNNING);
}

Now, it seems like the cli()/sti() pair is to prevent other code from interrupting 
the whole sequence.  It looks like the only things actually need interrupts 
disabled (from a command sequencing perspective) is the serial_out pairs, but you 
want to keep other parts of the driver from sending other commands to the board.

So, would:

	down_interruptible(&info->sem);
	spin_lock_irq(&info->esp_lock);
	serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
	serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);
	spin_unlock_irq(&info->esp_lock);

	while ((serial_in(info, UART_ESI_STAT1) != 0x03) ||
		(serial_in(info, UART_ESI_STAT2) != 0xff)) {
		msleep_interruptible(jiffies_to_msecs(char_time));

		if (signal_pending(current))
			break;

		if (timeout && time_after(jiffies, orig_jiffies + timeout))
			break;

		spin_lock_irq(&info->esp_lock);
		serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
		serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);
		spin_unlock_irq(&info->esp_lock);
	up(&info->esp_sem);

work if all other areas of the driver that send commands to the board also try for 
the semaphore?

Is there an easier way of doing this?

Jim
