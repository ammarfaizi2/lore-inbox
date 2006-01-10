Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWAJPQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWAJPQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWAJPQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:16:08 -0500
Received: from smarthost2.sentex.ca ([205.211.164.50]:64479 "EHLO
	smarthost2.sentex.ca") by vger.kernel.org with ESMTP
	id S1751125AbWAJPQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:16:03 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Miika Keskinen'" <weeti@usr.fi>, <linux-kernel@vger.kernel.org>
Subject: RE: serial port, custom divisor
Date: Tue, 10 Jan 2006 10:15:40 -0500
Organization: Connect Tech Inc.
Message-ID: <052101c615f8$b7cbd760$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <43C3B4A7.1000501@usr.fi>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of Miika Keskinen
> I read from the Documentation/serial/driver that the custom divisor is
> only applied to ports that have baud 38400. I'm asking if 
> there is some
> reason why custom divisor should not be used for other speeds 
> too? I do

Because it's a hack. The normal method is to specify a baud rate via
the lookup table, say B9600. The table is however a fixed size and has
set entries. At some point it became necessary to be able to specify a
divisor instead, to generate baud rates that are not part of the
normal lookup table. So, to specify that the driver should use a
custom divisor supplied by user space, there's a hack. Set the
appropriate flag, set the lookup table value to B38400 and set the
custom divisor to what you need.

The driver will see that the flag is set, see that the baud rate is
B38400, and use the custom divisor instead of calculating its own. If
you want 9600, you have two options. If it works for you, you can set
B9600. The driver will calculate its own divisor and use that, without
losing the custom information you've supplied. I suppose this is to
make it easy to switch back and forth. Or, you can just alter the
custom divisor to be what you need it to be to generate 9600. The apps
I've written that use the custom divisor, I do that. Switch the flag
on, switch to B38400, and control all my own baud rates via setting
the appropriate custom divisor.

> What I'm doing is to use early_serial_setup with flags containing
> ASYNC_SPD_CUST and cdiv as .custom_divisor. However the serial_core
> doesn't apply that divisor unless the speed is 38400 (and for 

Correct. B38400 is simply being used as a flag here, it's not actually
setting 38400.

> example I
> mostly need to run it in 9600). I'm now asking if I've misunderstood

So, set the flag, B38400, and the custom divisor that generates 9600
for you.

> something or does the removal of baud==38400 from serial_core cause
> problems with other architectures?

If you mean, would taking out that code from the driver be a good
idea? Probably not. This is a long standing well understood hack.
Attempts to change it will probably be resisted.

..Stu

