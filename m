Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbWGIXxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbWGIXxT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbWGIXxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:53:19 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6810 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1161224AbWGIXxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:53:18 -0400
Date: Mon, 10 Jul 2006 01:53:09 +0200 (MEST)
Message-Id: <200607092353.k69Nr9op029210@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: Valdis.Kletnieks@vt.edu, mikpe@it.uu.se
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org, pavel@ucw.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jul 2006 17:31:39 -0400, Valdis.Kletnieks wrote:
>On Sun, 09 Jul 2006 22:58:31 +0200, Mikael Pettersson said:
>
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
>Does applying this patch make it work?
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/broken-out/adjust-clock-for-lost-ticks.patch
>
>Or is this a different breakage?

I haven't tried it, but I'm 99% certain it's unrelated breakage.
In my case the TSC jumped backwards not forwards as would be the
case in a lost ticks scenario, and the patch above doesn't touch
the code that gets into an semi-infinite loop in my case.

/Mikael
