Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVE3Wie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVE3Wie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVE3Wie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:38:34 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:64851 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261795AbVE3Wia convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:38:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WToj5v5NsvikHnXSjxT6n8wr4xgx2pnnxeuXvmen2TblTDffyw/mjkMTNngx3Oj0N0GDCYlyIRVxcwbogzORsNi8LCKGurGypFhZUOMfE6XRWE1LSeZfb+61uM/gKavLU/zuzahUsfRpvZJBwbwmcfSkPJe4TEcH55MELQuAHcY=
Message-ID: <4789af9e05053015385667923@mail.gmail.com>
Date: Mon, 30 May 2005 16:38:29 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
Reply-To: Jim Ramsay <jim.ramsay@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bug in 8520.c - port.type not set for serial console
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to get the 8520.c driver's serial console working with
a 16550A UART implementation, and have run into what I consider to be
a bug:  In short, the proper 'port.type' for this serial port is not
set until the module init (serial8250_init) is called, so the FCR is
set incorrectly during serial8250_console_init for any port type which
is different than UNKNOWN.

The exact problem is that the FCR is being set to '0x0' for a port
type of 'UNKNOWN', when for my specific 16550A, it should be set to
'0xC1' - and this makes my screen fill with empty characters instead
of the printk output I need.  It appears that after some time (once
the kernel actually calls serial8250_init) the problem clears up, but
I still lose a large section of the output before this point.

The proper flags are sitting there in the uart_config array for the
proper type, and this type is properly deduced by the 'autoconfig'
routine that eventually gets called by serial8250_init.  The problem
is that the autoconfig is isn't called by serial8250_console_init
which of course happens much earlier than serial8250_init.

I have a workaround that works for me, telling the
serial8250_set_termios() routine to only set the FCR if the type is
not UNKNOWN, changing
    if (up->port.type != PORT_16750 ) {
to
    if (up->port.type != PORT_16750 && up->port.type != PORT_UNKNOWN) {

This will leave the FCR at whatever it was at boot time, which for me
is correct.

Would this be a "good enough" fix in general, or would there be a
better way of doing this?

I suppose the other way would be to duplicate some of what
serial8250_init does (like call 'autoconfig') in
serial8250_console_init, but I haven't tried this yet... maybe it
depends on too much kernel magic to be called as early as
'console_init'?

Any suggestions on the best way to fix this would be great, I'd be
happy to develop this more, test a bit, and submit a patch.

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
