Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbTJ3VXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbTJ3VXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:23:51 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:63939 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262855AbTJ3VXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:23:49 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: 8250 serial issues in 2.6.0-test9
Date: Thu, 30 Oct 2003 14:23:47 -0700
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310301423.47442.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

I know you don't want to mess with the setserial problem I
tripped over, and that's fine -- it's not a huge issue for
me.  While poking around at it, I noticed a couple other
issues, which I'll just mention here in case anybody else
wants to have a go at reworking this code.

Mostly this mail is just because I'm about to go on vacation,
and didn't want all my pondering to be completely wasted :-)

Bjorn


serial8250_release_port():
	When releasing an RSA port, it looks like serial8250_release_port()
	releases the wrong range ("start + offset" rather than "start") 
	for the standard IO port region.

serial8250_request_port():
	The error path ("ret < 0") leaks memory because request_region()
	kmallocs the new resource, but release_resource() doesn't free it.

serial8250_config_port():
	Same leak as in serial8250_request_port().

serial8250_release_port()/serial8250_request_port():
	The problem I mentioned before -- _request_port() doesn't
	ioremap the region that was iounmapped by _release_port(),
	so "setserial /dev/ttyS0 port 0x3f8" causes an oops if
	ttyS0 is an MMIO uart:

	    uart_set_info()
	        serial8250_release_port()
	            iounmap(membase);
	            membase = NULL;
	            release_mem_region(mapbase, ...);
	        serial8250_request_port()
	            request_mem_region(mapbase, ...);
	        serial8250_startup()
	            serial_out()
	                port.iotype == IO_MEM, so
	                    writeb(value, membase);
	                        oops - null pointer dereference (membase == NULL)

