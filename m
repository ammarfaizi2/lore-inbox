Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbTIQSMH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 14:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbTIQSMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 14:12:07 -0400
Received: from oasis.frogfoot.net ([168.210.54.51]:34787 "HELO
	oasis.frogfoot.net") by vger.kernel.org with SMTP id S262613AbTIQSMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 14:12:03 -0400
Date: Wed, 17 Sep 2003 20:11:38 +0200
From: Abraham vd Merwe <abz@frogfoot.net>
To: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: HELP PLEASE: i2c in interrupt?
Message-ID: <20030917181138.GA18892@oasis.frogfoot.net>
Mail-Followup-To: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Frogfoot Networks CC
X-Operating-System: Debian GNU/Linux oasis 2.4.21 (i686)
X-GPG-Public-Key: http://oasis.frogfoot.net/keys/
X-Uptime: 19:59:37 up 29 days, 1:14, 9 users, load average: 0.00, 0.01, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm working on a keypad driver which is sitting on an I/O expander on an I2C
bus. Whenever a key is pressed, the I2C chip (the I/O expander) generates an
interrupt and then I have to read the events from the I2C chip.

The problem is

 (a) This operation is time critical. If I don't read the data from the I2C
     chip very fast (after the interrupt occurred) the events get lost

 (b) I2C is done in hardware which means a read goes like this: START
     WRITE_DATA wait_for_interrupt ... STOP.

The important part here is the wait_for_interrupt. That means i2c_transfer()
will wait on a wait queue which I can't do from an interupt so I created a
task to do this for me and from the keypad interrupt routine, I do 

        queue_task (&keypad.task,&tq_immediate);
        mark_bh (IMMEDIATE_BH);

However that triggers a BUG

------------< snip <------< snip <------< snip <------------
Scheduling in interrupt
kernel BUG at sched.c:566!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
------------< snip <------< snip <------< snip <------------

so it is obviously illegal to do that from an interrupt. So my question is,
how do I execute a function which will sleep _very_soon_ after an interrupt
occurs (i.e. what I don't want to do is interrupt -> poll wakes up ->
process does read -> i2c_transfer() - that's too long)

-- 

Regards
 Abraham

You will not be elected to public office this year.

___________________________________________________
 Abraham vd Merwe - Frogfoot Networks CC
 9 Kinnaird Court, 33 Main Street, Newlands, 7700
 Phone: +27 21 686 1665 Cell: +27 82 565 4451
 Http: http://www.frogfoot.net/ Email: abz@frogfoot.net

