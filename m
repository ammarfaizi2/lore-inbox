Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbUKKXI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbUKKXI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbUKKXF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:05:56 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:29829 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262288AbUKKXEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:04:44 -0500
Subject: [PATCH 0/3] Fix sysdev time support
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1100213485.6031.18.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 12 Nov 2004 09:58:51 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew et al.

Since Suspend2 (and swsusp) have begun to use the sysdev_suspend and
_resume methods, I've discovered some issues with the time support.

time_suspend and _resume call get_cmos_time twice, resulting
(!CONFIG_EFI) in an extra second delay for each call (see below). For
suspend2, and probably for swsusp (I haven't seen Pavel's handling yet),
a call to the _suspend method is almost immediately followed by a call
to the _resume method (with the atomic save/restore of memory in
between), so that the user sees at least a 3 second delay (ave 1.5 for
suspend + 1.5 for resume) simply because of these calls.

get_cmos_time may call efi_get_time, which is marked __init and
(according to comments in its header) designed to run in physical mode;
I assume, not understanding PAE yet, that this will need further
consideration.

get_cmos_time may instead call mach_get_cmos_time (or equiv for other
archs), which waits (!x86_64) until the end of a cmos time update before
returning the value. For suspending, we don't need to wait for the
'edge' of a second when suspending; we just need a consistent value.

Finally, the calculation of the clock skew due to suspending uses a
mixture of signed and unsigned longs. This can result (based on
empirical results) in the clock being out by 1 hr, 11 minutes and 31s
post resume.

I proposed three patches:
1) Optimise time_suspend and time_resume so that get_cmos_time is called
exactly once in each case. This drops 1 second from each call.
2) Add a new parameter & appropriate logic to get_cmos_time and to
mach_get_cmos_time and equivalents, allowing the caller to specify
whether we should wait for the beginning of a new second. When
suspending, don't wait; when resuming, do.
3) Switch sleep_start in arch/i386/kernel/time from a long to an
unsigned long, thereby addressing the math issue.

I also wonder if the jiffies+= logic in the x86 code should be applied
to x86_64 too?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

