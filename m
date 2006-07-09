Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161221AbWGIXwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbWGIXwr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWGIXwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:52:47 -0400
Received: from aun.it.uu.se ([130.238.12.36]:666 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1161221AbWGIXwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:52:46 -0400
Date: Mon, 10 Jul 2006 01:52:35 +0200 (MEST)
Message-Id: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: johnstul@us.ibm.com, mikpe@it.uu.se
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jul 2006 14:20:56 -0700, john stultz wrote:
>> I've traced the cause of this problem to the i386 time-keeping
>> changes in kernel 2.6.17-git11. What happens is that:
>> - The kernel autoselects TSC as my clocksource, which is
>>   reasonable since it's a PentiumII. 2.6.17 also chose the TSC.
>> - Immediately after APM resumes (arch/i386/kernel/apm.c line
>>   1231 in 2.6.18-rc1) there is an interrupt from the PIT,
>>   which takes us to kernel/timer.c:update_wall_time().
>> - update_wall_time() does a clocksource_read() and computes
>>   the offset from the previous read. However, the TSC was
>>   reset by HW or BIOS during the APM suspend/resume cycle and
>>   is now smaller than it was at the prevous read. On my machine,
>>   the offset is 0xffffffd598e0a566 at this point, which appears
>>   to throw update_wall_time() into a very very long loop.
>
>Huh. It seems you're getting an interrupt before timekeeping_resume()
>runs (which resets cycle_last). I'll look over the code and see if I can
>sort out why it works w/ ACPI suspend, but not APM, or if the
>resume/interrupt-enablement bit is just racy in general.

I forgot to mention this, but I had a debug printk() in apm.c
which showed that irqs_disabled() == 0 at the point when APM
resumes the kernel.

/Mikael
