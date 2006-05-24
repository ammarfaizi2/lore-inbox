Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWEXAlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWEXAlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 20:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWEXAlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 20:41:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932520AbWEXAlH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 20:41:07 -0400
Date: Tue, 23 May 2006 17:40:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Carlos =?ISO-8859-1?B?TWFydO1u?= <carlos@cmartin.tk>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: A couple of oops.
Message-Id: <20060523174030.3b52ca71.akpm@osdl.org>
In-Reply-To: <1148408930.7726.11.camel@kiopa>
References: <1148408930.7726.11.camel@kiopa>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Martín <carlos@cmartin.tk> wrote:
>
> Hi,
> 
> I've nailed this down to something that happened in 2.6.17-rc4. The
> system locks up with either a NULL dereference or an unhandable paging
> request. The stack trace shows this:
> 
> paging request            NULL dereference
> 
> _raw_spin_trylock+12    _raw_spin_trylock+20
> __spin_lock+22
> main_timer_handler+22
> timer_interrupt+18
> handle_IRQ_event+41
> __do_IRQ+156
> do_IRQ+51
> default_idle+0
> _spin_unlock_irq+43
> thread_return+187
> generic_unplug_device+0
> default_idle+45
> dev_idle+95 (I can't read the func clearly in this handwriting)
> start_secondary+1129
> 
> I'm guessing this is the same problem only that it once manifests itself
> as one and another time as the other. The problem is in the call to
> write_seqlock(&xtime_lock) from main_timer_handler().
> 
> I've not been able to determine what patch has caused this to happen,
> but it is between 2.6.17-rc3 and -rc4. I'm bisecting, but if anybody has
> a good candidate, it'd probably be faster than doing a complete bisect.

hm, so an attempt to access xtime_lock.lock results in a null-pointer deref?

x86_64 does novel things, putting xtime_lock into a linker section all of
its own.  At a guess I'd say that your compiler/assembler/linker toolchain
got confused and generated the incorrect address for xtime_lock.  But if
that was the case you'd get oopses 100% of the time - it wouldn't be
intermittent, as your description seems to imply (although it's quite
unclear?).

You could do:

gdb vmlinux
(gdb) p &xtime_lock
(gdb) x/40i main_timer_handler

