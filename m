Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268613AbUHLRAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268613AbUHLRAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268614AbUHLRAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:00:31 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:14760 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268613AbUHLRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:00:27 -0400
Message-ID: <411BA214.2060306@eidetix.com>
Date: Thu, 12 Aug 2004 19:00:04 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sascha Wilde <wilde@sha-bang.de>
CC: Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <20040811141408.17933.qmail@web81304.mail.yahoo.com> <20040811175613.GA829@kenny.sha-bang.local>
In-Reply-To: <20040811175613.GA829@kenny.sha-bang.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sascha Wilde wrote:

>>> Is PS/2 supposed to support hotpluging at all?  I guess it's not,
>>>  but I may be wrong...
>> 
>> Yes it is, at least with newer (or rather not ancient) hardware...
> 
> 
> well, so the patch obviously can't be a final solution...

Yes, it doesn't strike me as being ideal.

More playing with the triple fault leads me to this:


static int i8042_command(unsigned char *param, int command)
{
	unsigned long flags;
	int retval = 0, i = 0;

	spin_lock_irqsave(&i8042_lock, flags);

	retval = i8042_wait_write();
	if (!retval) {
		dbg("%02x -> i8042 (command)", command & 0xff);
		i8042_write_command(command & 0xff);
	}

=====> A

	if (!retval)
		for (i = 0; i < ((command >> 12) & 0xf); i++) {
			if ((retval = i8042_wait_write())) break;
			dbg("%02x -> i8042 (parameter)", param[i]);
			i8042_write_data(param[i]);
		}

=====> B

Point 'B' is the "point of no reboot", at A we can still triple fault it
and get a nice normal reboot, so it's the parameter that it's writing
that it causing it to go funny.

I noticed something odd though... I reported this in another email:

*With keyboard* :

mice: PS/2 mouse device common for all mice
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 65 <- i8042 (return) [0]

*Without keyboard* :

mice: PS/2 mouse device common for all mice
drivers/input/serio/i8042.c: fa <- i8042 (flush, aux) [0]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 9a <- i8042 (return) [0]

I noticed that
0x9a is the 'inverse' of 0x65.  If I set it to 0x65 and write that out,
it still reboots afterwards!  Hrm.  I don't know what that means
exactly, but apparently it *is* possible to write something to the
controller and have it keep going.

Sascha, if you want to test it out, try this in i8042_controller_init,
at about line 724 (near this: i8042_initial_ctr = i8042_ctr;)

	{
	    unsigned char pram;
	    pram = (~i8042_ctr) & 0xff ;
	    i8042_command(&pram, I8042_CMD_CTL_WCTR);
	}

	{
	    static struct
	    {
		unsigned short       size __attribute__ ((packed));
		unsigned long long * base __attribute__ ((packed));
	    } no_idt = { 0, 0 };

	    __asm__ __volatile__("lidt %0": :"m" (no_idt));
	    __asm__ __volatile__("int3");
	}

It reboots!

-- 
David N. Welton
davidw@eidetix.com
