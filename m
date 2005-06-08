Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVFHPY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVFHPY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFHPY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:24:27 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:34244 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261314AbVFHPYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:24:18 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Paulo Marques <pmarques@grupopie.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00 
In-reply-to: Your message of "Wed, 08 Jun 2005 17:04:23 +0200."
             <42A708F7.9000803@stud.feec.vutbr.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Jun 2005 01:23:50 +1000
Message-ID: <8116.1118244230@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jun 2005 17:04:23 +0200, 
Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
>Paulo Marques wrote:
>> This is probably just bad luck and a known problem that I'm trying to 
>> fix (but hadn't have much time lately).
>> 
>> Can you try to change the line:
>> 
>> #define WORKING_SET        1024
>> 
>> in scripts/kallsyms.c to:
>> 
>> #define WORKING_SET        65536
>> 
>> and disable CONFIG_KALLSYMS_EXTRA_PASS, to see if the problem goes away?
>
>Yes, this helps.
>
>> It it does go away, then it is the same problem, and I'm working on it...

Not the same problem.  The significant difference in the maps is :-

--- .tmp_map1   2005-06-09 01:14:50.303658655 +1000
+++ .tmp_map2   2005-06-09 01:14:52.829274854 +1000
@@ -8326,8 +8326,8 @@
 c02b93b0 T ipv6_skip_exthdr
 c02b9500 T sha_transform
 c02b96e0 T sha_init
-c02b970f T __sched_text_start
 c02b9710 t __compat_down
+c02b9710 T __sched_text_start
 c02b9810 t __compat_down_interruptible
 c02b9948 T __compat_down_failed
 c02b9958 T __compat_down_failed_interruptible

__sched_text_start has moved up by 1 byte between pass 1 and 2.  Text
addresses are not allowed to move between kallsyms passes, kallsyms
only adds data, it never touches the text segment.  Paulo's change to
the working set hides this peculiarity, rather than fixing the real
cause.  This looks like a toolchain bug, it is moving symbols for no
good reason.

