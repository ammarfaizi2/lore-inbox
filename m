Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTGFNJQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 09:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTGFNJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 09:09:16 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:54924 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S262257AbTGFNJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 09:09:14 -0400
Date: Sun, 6 Jul 2003 15:23:45 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Synaptics: support for pass-through port (stick)
In-Reply-To: <200307060223.15730.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.40.0307061435030.21749-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Jul 2003, Dmitry Torokhov wrote:


> -		psmouse_process_packet(psmouse, regs);
> -		psmouse->pktcnt = 0;
> +
> +	if (psmouse->pktcnt == 1 && psmouse->packet[0] == PSMOUSE_RET_BAT) {
> +		serio_rescan(serio);
>  		goto out;
>  	}
>
> -	if (psmouse->pktcnt == 1 && psmouse->type == PSMOUSE_SYNAPTICS) {
> +	if (psmouse->type == PSMOUSE_SYNAPTICS) {


Why did you move the rescan up above the synaptics test? if the synaptics
is out of sync, any byte can be recieved.


> +static int synaptics_pt_write(struct serio *port, unsigned char c)
> +{
> +	struct psmouse *parent = port->driver;
> +	char client_cmd = 0x28; // indicates that we want pass-through port

Could client_cmd be renamed to f.ex. rate_param?


> +		if (child->init_done) {
> +			serio_interrupt(ptport, packet[1], 0, NULL);
> +			if (child->type >= PSMOUSE_GENPS)
> +				serio_interrupt(ptport, packet[2], 0, NULL);
> +			serio_interrupt(ptport, packet[4], 0, NULL);
> +			serio_interrupt(ptport, packet[5], 0, NULL);

The 4th protocol byte from a guest is the 3rd byte in the encapsulated
packet from the pad. So I would move "if (..." last.

There might be a (de)multiplexing problem here. The button information
(pressed/released) in byte 0 and 3 is lost, and are not repeated in the
guest protocol.


> +	port->type = SERIO_PS_PSTHRU;
> +	port->name = "Synaptics pass-through";
> +	port->phys = "synaptics-pt/serio0";
> +	port->write = synaptics_pt_write;
> +	port->open = synaptics_pt_open;
> +	port->close = synaptics_pt_close;
> +	port->driver = psmouse;
> +
> +	printk(KERN_INFO "serio: %s port at %s\n", port->name, psmouse->phys);
> +	serio_register_slave_port(port);
> +
> +	return 0;
> +}
> +

Bit 2 in the pads second mode byte must be set if the guest uses a 4 bytes
protocol. So you need to check which protocol is negotiated on the slave
port.


Peter


