Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVBIUJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVBIUJD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVBIUH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:07:27 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:16372 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261911AbVBIUFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:05:13 -0500
Message-ID: <420A6CF5.9040304@nortel.com>
Date: Wed, 09 Feb 2005 14:05:09 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: [BUG] in copy_siginfo_to_user32 on ppc64 (and others?) in 2.6.9/2.6.10
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a bug which has since been fixed, but I'm hoping to save others 
the problems that I had tracking it down.

It was fairly confusing--the information in the siginfo_t struct was 
different based on whether I used a signal handler in the regular way, 
or blocked the signal and retrieved the information using sigtimedwait().

After much instrumentation of the kernel, I tracked it down.

Until recently (Jan 5), ppc64 had its own version of 
compat_sys_rt_sigtimedwait, which simply called sys_rt_sigtimedwait() 
then copied the results to the userspace struct using 
copy_siginfo_to_user32().

Unfortunately, sys_rt_sigtimedwait() only copies the lower 16 bits of 
si_code, and the ppc64 version of copy_siginfo_to_user32() keyed on the 
upper 16 bits to decide what information to copy.  Thus, it always ended 
up in the default case of the switch statement, and only ever copied 
si_pid and si_uid.

Oops.

Chris

