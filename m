Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbUKBQlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbUKBQlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 11:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbUKBQkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 11:40:07 -0500
Received: from atarelbas04.hp.com ([156.153.255.214]:18380 "EHLO
	atlrel9.hp.com") by vger.kernel.org with ESMTP id S262206AbUKBQjm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 11:39:42 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
Date: Tue, 2 Nov 2004 09:39:25 -0700
User-Agent: KMail/1.7
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
References: <200409301014.00725.bjorn.helgaas@hp.com> <20041006082919.B18379@flint.arm.linux.org.uk> <1099329348.13633.2192.camel@hades.cambridge.redhat.com>
In-Reply-To: <1099329348.13633.2192.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411020939.25851.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 November 2004 10:15 am, David Woodhouse wrote:
> The problem is that 'console=ttySx' doesn't actually do anything unless
> port numer 'x' is already registered and working. We should fix that --
> we ought to be able to use 'console=ttySx' on the command line and have
> the console get registered with the core printk code later, when some
> 8250 sub-driver (8250_platform, 8250_pci, etc.) actually registers the
> port which becomes number 'x'. 

See serial8250_late_console_init(); does this do what you want?

> That would allow 'early' serial consoles to have none of the horrible
> special-cased 'earlyconsole' crap -- we just call register_serial() (or
> early_serial_setup() or whatever) as soon as it's actually possible to
> poke at the port.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/broken-out/early-uart-console-support.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/broken-out/move-hcdp-pcdp-to-early-uart-console.patch

For platforms that define SERIAL_PORT_DFNS, early boot code could easily
recognize "console=ttyS0" and use SERIAL_PORT_DFNS to register
"console=uart,io,0x3f8".

If you don't have SERIAL_PORT_DFNS, early boot code doesn't know anything
about 'ttySx', so you need some other mechanism to find the device (the
user could specify it directly, or firmware could supply it).
