Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTGXR1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 13:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTGXR1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 13:27:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:28817 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263355AbTGXR1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 13:27:44 -0400
Date: Thu, 24 Jul 2003 10:30:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-yoann@ifrance.com, linux-kernel@vger.kernel.org, akpm@digeo.com,
       vortex@scyld.com, jgarzik@pobox.com
Subject: Re: another must-fix: major PS/2 mouse problem
Message-Id: <20030724103047.31e91a96.akpm@osdl.org>
In-Reply-To: <1058921044.943.12.camel@cube>
References: <1054431962.22103.744.camel@cube>
	<3EDCF47A.1060605@ifrance.com>
	<1054681254.22103.3750.camel@cube>
	<3EDD8850.9060808@ifrance.com>
	<1058921044.943.12.camel@cube>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> wrote:
>
> Using the lockmeter on a 2.5.75 kernel, I discovered
> that boomerang_interrupt() grabs a spinlock for over
> 1/4 second. No joke, 253 ms. Interrupts are off AFAIK.

boomerang_interrupt() doesn't disable interrupts.  Is the NIC sharing the
mouse's IRQ line?

boomerang_interrupt() is only used by nasty old NICs and yes, I guess it is
possible that something has gone wrong and is causing occasional long spins
in there.

But I am more suspecting that you're not really using boomerang_interrupt()
at all, and that something has gone wrong with lockmeter.  What sort of NIC
are you using?

Bear in mind that if some other device generates an interrupt while the CPU
is running boomerang_interrupt(), lockmeter will count the time spent in
that other device's interrupt as "time spent in boomerand_interrupt()". 
Which is very true, but it is not much help when one is trying to identify
the source of the problem.

Perhaps what you should do is to do an rdtsc on entry and exit of do_IRQ()
and print stuff out when "long" periods of time in do_IRQ() are noticed.

