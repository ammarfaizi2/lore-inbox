Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265914AbUBBVfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUBBVfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 16:35:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:52941 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265914AbUBBVfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 16:35:16 -0500
Date: Mon, 2 Feb 2004 13:29:25 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Max Asbock <masbock@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver for IBM RSA service processor (1/2)
Message-Id: <20040202132925.10164aac.rddunlap@osdl.org>
In-Reply-To: <200402021129.53193.masbock@us.ibm.com>
References: <200402021129.53193.masbock@us.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Feb 2004 11:29:53 -0800 Max Asbock <masbock@us.ibm.com> wrote:

| Here is a device driver for the IBM xSeries RSA service processor.
| The ibmasm driver is mainly intended to be used in conjunction with a user space 
| API and systems management applications that need to get in-band access to
| the service processor, such as sending commands or waiting for events.
| For the remote video feature the driver relays remote mouse and keyboard 
| events to user space. 
| By itself the driver also allows the OS to make use the UART on the service
| processor board as a regular serial line.
| 
| The user interface to the driver is a custom file system. It does not use sysfs since
| the operations on the files are somewhat beyond the one file / one value rule for sysfs.
| Since it is not strictly a char driver I put it into the drivers/misc directory.
| 
| The patch is fairly big, therefore I split it up into the file system part and the
| everything-else part.
| 
| Any feedback is greatly appreciated.

Hi,

Need to be consistent with spacing in "if" -- don't add spaces
on both sides of '(' and ')'.



| +	if (buffer_size > IBMASM_CMD_MAX_BUFFER_SIZE)
| +		return NULL;

Several good, like above....


| +static struct command *dequeue_command(struct service_processor *sp)
| +{
| +	struct command *cmd;
| +	struct list_head *next;
| +
| +	if ( list_empty(&sp->command_queue) )
| +		return NULL;

Nope, no cookie for this one and others below...

| +static inline void do_exec_command(struct service_processor *sp)
| +{
| +	if ( ibmasm_send_i2o_message(sp) ) {
| +		sp->current_command->status = IBMASM_CMD_FAILED;
| +		exec_next_command(sp);
| +	}
| +}


| +	if ( !sp->current_command ) {
| +		command_get(cmd);
| +		sp->current_command = cmd;
| +		spin_unlock_irqrestore(&sp->lock, flags);
| +
| +		do_exec_command(sp);


| +	if ( sp->current_command ) {
| +		command_get(sp->current_command);
| +		spin_unlock_irqrestore(&sp->lock, flags);
| +		do_exec_command(sp);
| +	} else {
| +		spin_unlock_irqrestore(&sp->lock, flags);
| +	}



| diff -urN linux-2.6.1/drivers/misc/ibmasm/dot_command.c linux-2.6.1-ibmasm/drivers/misc/ibmasm/dot_command.c
| --- linux-2.6.1/drivers/misc/ibmasm/dot_command.c	1969-12-31 16:00:00.000000000 -0800
| +++ linux-2.6.1-ibmasm/drivers/misc/ibmasm/dot_command.c	2004-01-22 11:10:20.000000000 -0800


| diff -urN linux-2.6.1/drivers/misc/ibmasm/event.c linux-2.6.1-ibmasm/drivers/misc/ibmasm/event.c
| --- linux-2.6.1/drivers/misc/ibmasm/event.c	1969-12-31 16:00:00.000000000 -0800
| +++ linux-2.6.1-ibmasm/drivers/misc/ibmasm/event.c	2004-01-20 11:16:29.000000000 -0800

| +/**
| + * receive_event
| + * Called by the interrupt handler when a dot command of type sp_event is
| + * received.
| + * Store the event in the circular event buffer, wake up any sleeping
| + * event readers.
| + * There is no reader marker in the buffer, therefore readers are
| + * responsible for keeping up with the writer, or they will loose events.
                                                               lose


| +	/* advance indices in the buffer */
| +	buffer->next_index = ++(buffer->next_index) % IBMASM_NUM_EVENTS;
| +	buffer->next_serial_number++;

Is
+#define IBMASM_NUM_EVENTS	10
not configurable?


| +	if ( wait_event_interruptible(reader->wait, event_available(buffer, reader)) )
| +		return -ERESTARTSYS;

:(


| +	if (!event_available(buffer, reader))
| +		return 0;

:)



I'll try to look at more of it later today.

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
