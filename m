Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274893AbRIVLTh>; Sat, 22 Sep 2001 07:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274894AbRIVLT1>; Sat, 22 Sep 2001 07:19:27 -0400
Received: from e3serv0.hedonism.cx ([213.69.21.147]:34945 "EHLO
	e3serv0.hedonism.cx") by vger.kernel.org with ESMTP
	id <S274893AbRIVLTM>; Sat, 22 Sep 2001 07:19:12 -0400
From: Christian Vogel <chris@obelix.hedonism.cx>
Date: Sat, 22 Sep 2001 13:19:16 +0200
To: linux-kernel@vger.kernel.org
Subject: [Newbie] Interrupt Handling and sleep/wake_up
Message-ID: <20010922131916.A1188@emil.frop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

-- Warning, newbie qeustion! --

currently I'm trying to write a very simple driver for the NI-GPIB-PCII
card and I'm mostly copying what was linux-gpib a long time ago.

Why am I writing to this list? I think I miss some obvious solution to a
problem. The problem lies within my handling of interrupts, let my try a
simplified example:

The board signals arrival of new data, it's ability to accept new data
or errors via the interrupt. I want my program to sleep until enough
data has been accepted or an error has occured.

Unfortunately on errors the interrupt hits just before I call
sleep_on_timeout() and because it's the only interrupt in this case
that's being generated I have to wait until sleep_on_timeout()
timeout's.

The old driver mostly uses
	while(!condition && !i++>threshold)
		udelay()
which I would like to avoid.

What would be the preferred way of doing this and what am I missing?

Some simple pseudocode follows to illustrate my point: bdIrq
is the interrupt-service-routine, bdDoSomething is called via
device->file-operations->read/write->... and wants to fetch something
from the card or write to it.

void bdIrq(int irq,void *data, struct pt_regs *regs){
	query_board_for_status();
	if( board_has_data_available )
		readbuf[readcounter++]=inb(data_port);
	if( board_can_accept_data )
		outb(wrbuf[writecounter++],data_port);
	if( board_has_error_condition_set )
		board_has_error = 1;
	if( buffer_full_or_end_of_data || board_has_error )
		wake_up_interruptible(&irq_wqueue);
}

void bdDoSomething(){
	setup_buffers_for_interrupt_routing();
	tell_board_to_start_reading_or_writing();
	/***** BOARD THROWS ITS INTERRUPTS HERE!!! *****/
	interruptible_sleep_on_timeout(&irq_wqueue,PCIIA_SLEEP_TIMEOUT);
}

	Chris

-- 
Is it true that cannibals won't eat clowns because they taste funny?
