Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUBPTIF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUBPTIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:08:05 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:17106 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S265789AbUBPTH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:07:59 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc3 serial console woes
Date: Mon, 16 Feb 2004 12:07:56 -0700
User-Agent: KMail/1.5.4
Cc: Russell King <rmk@arm.linux.org.uk>
References: <3326.1076937262@ocs3.ocs.com.au>
In-Reply-To: <3326.1076937262@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402161207.56284.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 February 2004 6:14 am, Keith Owens wrote:
> Between 2.6.3-rc2 and 2.6.3-rc3, the serial console initialisation
> changed, due to this patch :-
> 
>   http://linux.bkbits.net:8080/linux-2.5/cset@1.1653?nav=index.html|ChangeSet@-7d
> 
> Now the serial console is not initialised until a long way into the
> boot, just after the disks are probed.  This makes it impossible to use
> a kernel debugger such as kdb or kgdb over a serial console during
> device initialisation.

Hmm....  I suspect the problem is that serial8250_isa_init_ports()
doesn't initialize port->type for the ports in SERIAL_PORT_DFNS,
so we fail the console setup.

Does the attached patch make it work like it used to?  ISTR that
Russell didn't really like testing port->ops, but I can't remember
why, and I don't see anything better.

===== drivers/serial/8250.c 1.44 vs edited =====
--- 1.44/drivers/serial/8250.c	Fri Feb 13 08:19:33 2004
+++ edited/drivers/serial/8250.c	Mon Feb 16 12:03:06 2004
@@ -1976,7 +1976,7 @@
 	if (co->index >= UART_NR)
 		co->index = 0;
 	port = &serial8250_ports[co->index].port;
-	if (port->type == PORT_UNKNOWN)
+	if (!port->ops)
 		return -ENODEV;
 
 	/*

