Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbTFLTAO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbTFLTAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:00:14 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:5824 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S264953AbTFLTAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:00:06 -0400
Date: Thu, 12 Jun 2003 21:13:44 +0200
From: Robert Schwebel <robert@schwebel.de>
To: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: init does not run on 405GP system
Message-ID: <20030612191344.GR9379@pengutronix.de>
References: <20030610141047.GU9379@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030610141047.GU9379@pengutronix.de>
User-Agent: Mutt/1.4i
X-Spam-Score: -5.0 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19QXVy-00056f-00*vi85T.hHvbM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 04:10:47PM +0200, Robert Schwebel wrote:
> I'm currently porting u-boot and Linux to an IBM 405GP based board.
> The problem is now that init seems not to be running and does not give
> any output.

We have some new information about what happens on that machine, and the
more I know the stranger it is :-(

When you look at fs/exec.c:setup_arg_pages() there is a call to
put_dirty_pages(). After that call the argv and env data should be found
on the stack, at 0x7fffffda, which can also be looked at when you
generate a kernel mapping with kmap(page) plus an offset of 0xfba. These
both addresses should point to the same piece of physical RAM. I have
printed out the content of the TLBs and they look correct: 

...
TLB 7, v = 1, sz = 1, flags = 0x0110, EPN 0x7ffff000, RPN 0x0014a000
...
TLB 63, v = 1, sz = 7, flags = 0x0300, EPN 0xc1000000, RPN 0x01000000
...

Nevertheless, when I set a breakpoint to the location after the
put_dirty_pages() call I see different memory. The kernel mapping
contains correct content: 

	"init",0,"HOME=/",0,"TERM=linux",0,"/sbin/init"

But the user mapping (0x7fffffda) shows crap. It is a writable piece of
memory, I can place something in it by writing after the
put_dirty_pages(). When I write a "unique" pattern to that place, stop
the processor with the BDI and read out a complete memory dump I don't
find the pattern any more - this looks like a caching problem, but I'm
not entirely sure. I've tried an invalidate_dcache_range() to the user
space mapping addresses without success. 

-+-+-

What could happen here? Is the cache handling code bullet proof? I'm
running out of ideas. 

Kernel is still 2.4.21-rc2-ppc20030515 plus port to the board in
question. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
