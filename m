Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTJNCMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 22:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTJNCMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 22:12:18 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:62436 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262156AbTJNCMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 22:12:17 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initcall ordering of driver w/respect to tty_init?
References: <buo65j0f9vi.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20031010080212.6ddb02ff.rddunlap@osdl.org>
	<20031010181251.GA32720@fencepost>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 14 Oct 2003 11:12:01 +0900
In-Reply-To: <20031010181251.GA32720@fencepost>
Message-ID: <buohe2ctvny.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader <miles@gnu.org> writes:
> I think that would solve the problem, but is it the right solution?  How
> about all those other drivers that call tty_register_driver?  module_init
> becomes __initcall when driver is statically linked into the kernel...

I've looked more at <linux/init.h>, and I think for my driver, which is
always statically linked, I can use `late_initcall' instead of
`__initcall' (it makes me slightly nervous to use the last init slot,
but whatever).

But what about all those tty drivers that are suppose to work as
modules?  They use `module_init' to do their initialization, which will
work fine when they _are_ a module, but if they get statically linked,
the module_init will turn into `__initcall', and run into the same
problem I'm having.  Presumably they _could_ use `late_initcall', since
<linux/init.h> contains code that makes it work in modules too, but the
comment in the code says you shouldn't do that.

[To recap: tty drivers that use module_init to initialize themselves,
which turns into __initcall if statically linked, will only work if they
happen to be initialized _after_ tty_io.c (because of the kobj stuff) --
and there seems to be nothing enforcing this ordering.]

-Miles
-- 
97% of everything is grunge
