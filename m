Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUJaA0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUJaA0w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 20:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbUJaA0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 20:26:51 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:36175 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261443AbUJaA0t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 20:26:49 -0400
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP
	kernel
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Tim_T_Murphy@Dell.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1099176190.25178.7.camel@localhost.localdomain>
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC4@ausx2kmps304.aus.amer.dell.com>
	 <20041029212029.I31627@flint.arm.linux.org.uk>
	 <1099093258.5965.41.camel@at2.pipehead.org>
	 <1099176190.25178.7.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1099182383.6000.99.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 30 Oct 2004 19:26:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 17:43, Alan Cox wrote:
> On Sad, 2004-10-30 at 00:40, Paul Fulghum wrote:
> > Would it make sense to do something like (in tty_io.c) the following?
> 
> Not really because it can legally occur if you flip the low latency
> flag while a transaction is queued. It might work if you waited for
> scheduled work to complete in the flag changing.

I don't see how having flush_to_ldisc() queued
or already running (on another processor) negates
the prohibition on calling tty_flip_buffer_push()
with low_latency set in interrupt context.

The comments for tty_flip_buffer_push() state the
function should not be called in interrupt context
if low_latency is set (no exceptions are listed).
Meaning flush_to_ldisc() should only be called
in process context.

If flush_to_ldisc() is queued or already executing,
there is no protection against calling
flush_to_ldisc() again, directly in interrupt context.
TTY_DONT_FLIP is no protection, that is only set
in read_chan() of n_tty.c

If I'm missing something, please point it out.

-- 
Paul Fulghum
paulkf@microgate.com


