Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268971AbRHTTqL>; Mon, 20 Aug 2001 15:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbRHTTqC>; Mon, 20 Aug 2001 15:46:02 -0400
Received: from hera.cwi.nl ([192.16.191.8]:15762 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268958AbRHTTpx>;
	Mon, 20 Aug 2001 15:45:53 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 20 Aug 2001 19:46:06 GMT
Message-Id: <200108201946.TAA179233@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, lars.segerlund@comsys.se
Subject: Re: BUG: pc_keyb.c
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Due to writing to the status register before it's ready as far as
>> I can see.

Which writes are you thinking of?

>> Fix: change all mdelay(1) in pc_keyb.c to mdelay(2)'s

There are four of them. Any one in particular?

(1) The first is

static void kb_wait(void) {
	do {
		status = handle_kbd_event();
		if (! (status & KBD_STAT_IBF))
			return;
		mdelay(1);
	} ...
}

Here handle_kbd_event() does kbd_read_status() which does
inb(KBD_STATUS_REG).
So, the mdelay(1) separates reads of the status register.

(2) The second is (in send_data, waiting for an ack):
	for (;;) {
		if (acknowledge)
			return 1;
		mdelay(1);
	}
Here the delay seems completely arbitrary.

(3) The third is in kbd_wait_for_input():
	do {
		int retval = kbd_read_data();
		if (retval >= 0)
			return retval;
		mdelay(1);
	}
Here kbd_read_data() does kbd_read_status().
Again the mdelay(1) separates reads of the status register.

(4) The last is in detect_auxiliary_port() which is __init
and hence probably irrelevant.


If it is really necessary to have mdelay(1) or even mdelay(2),
then it seems to me that this implies that there is a minimum
delay between two reads of the status register.
But the present code does not guarantee such a delay at all.
For example, kbd_write_cmd() does
	kb_wait();
	outb(...);
	kb_wait();
where the second kb_wait reads the status very quickly after the first.


So, I am inclined to think that the present mdelay(1) is just random
nonsense. It does not guarantee anything at all. If some delay is required
somewhere then we must introduce a mechanism that enforces the delay.

Andries
