Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266475AbUANXwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUANXwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:52:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:14008 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266475AbUANXwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:52:00 -0500
Date: Wed, 14 Jan 2004 15:48:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "David Rees" <drees@greenhydrant.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe failed: digest_null
Message-Id: <20040114154836.35614a92.rddunlap@osdl.org>
In-Reply-To: <3156.208.48.139.163.1074037125.squirrel@www.greenhydrant.com>
References: <20040113215355.GA3882@piper.madduck.net>
	<20040113143053.1c44b97d.rddunlap@osdl.org>
	<20040113223739.GA6268@piper.madduck.net>
	<20040113144141.1d695c3d.rddunlap@osdl.org>
	<20040113225047.GA6891@piper.madduck.net>
	<20040113150319.1e309dcb.rddunlap@osdl.org>
	<3156.208.48.139.163.1074037125.squirrel@www.greenhydrant.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 15:38:45 -0800 (PST) "David Rees" <drees@greenhydrant.com> wrote:

> kernel: request_module: failed /sbin/modprobe -- digest_null. error = 256

Chris Wright tells me that this is a null digest crypto plugin
for testing.  It might show up in your /etc/modprobe.conf file
(or it might not).
 
| request_module: failed /sbin/modprobe -- n. error = 256

This is looking for a module named "n".  Don't know where that
comes from.

In both cases, error = 256 is 0x100, which is the value returned
from kernel/kmod.c::call_usermodehelper(), which execs /sbin/modprobe
in this case.  /sbin/modprobe does exit(1) for modules that are
not found, and that 1 becomes 0x100 in call_usermodehelper().


| Running on Fedora Core 1 compiled with gcc 3.3.2.  Didn't see these with
| 2.6.0.


and I wrote yesterday:
| request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16

This one comes from drivers/char/lp.c::lp_init() calling
parport_register_driver(), which calls get_lowlevel_driver(),
which calls request_module("parport_lowlevel").
Since I have lp.o and parport code built into the kernel image,
these calls happen during early init, before <system_running>
is set to 1, so call_usermodehelper() returns -EBUSY (-16 on x86).

| request_module: failed /sbin/modprobe -- fb0. error = 256

Same as first case above, but for a framebuffer device.

I don't know what needs to be done about these, if anything.

Comments, suggestions?

--
~Randy
