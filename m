Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVCALLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVCALLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVCALLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:11:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11469 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261871AbVCALL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:11:29 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       barryn@pobox.com, <marado@student.dei.uc.pt>,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
References: <20050228231721.GA1326@elf.ucw.cz>
	<20050301015231.091b5329.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Mar 2005 04:08:24 -0700
In-Reply-To: <20050301015231.091b5329.akpm@osdl.org>
Message-ID: <m1u0nvr5cn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > In `subj` kernel, machine no longer powers down at the end of
> >  swsusp. 2.6.11-rc5-pavel works ok, as does 2.6.11-bk.
> 
> Binary searching indicates that this is due to
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc5/2.6.11-rc5-mm1/broken-out/acpi_power_off-bug-fix.patch.
> 
> 
> I'll drop it.  That patch is pretty ugly-looking anyway (ACPI code in
> drivers/base/power/?).
> 
> Perhaps someone who is hitting the problem which that patch addresses could
> raise a bugzilla entry.
> 
> Oh.  It has one.  http://bugme.osdl.org/show_bug.cgi?id=4041
> 
> Anyway.  It needs more work.

Agreed.

I threw it together to test a specific code path, and the fact it
fails in software suspend is actually almost confirmation that I am on
the right track.  This actually fixed the case I was testing.

In this case the failure is simply because system_state is
not set to SYSTEM_POWER_OFF before
kernel/power/disk.c:power_down() calls device_shutdown().
The appropriate reboot notifier is also not called..

So to fix this properly all of the places
that call machine_power_off now need to call a wrapper
that does all of the appropriate things and then calls
machine_power_off.

Likewise with the other reboot functions.

In addition a clean way to get device_shutdown() to 
call acpi_power_off_prepare() at roughly the location
I have it hard coded.  

The fundamental issue this patch was starting to address
before I ran out of steam, is that acpi_power_off_prepare()
must be called with interrupts enabled and after we have shut down
the system devices (i.e. the interrupt controllers) we can't
guarantee interrupts, are working.

I'm don't know how much earlier it is safe to
acpi_power_off_prepare().  But mostly I think we need to
throw in a fake device to attach acpi_power_off_prepare to.

Eric
