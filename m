Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVCYBMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVCYBMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVCYBJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:09:52 -0500
Received: from everest.2mbit.com ([24.123.221.2]:4044 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261355AbVCYBFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:05:34 -0500
Message-ID: <424363BB.80207@lovecn.org>
Date: Fri, 25 Mar 2005 09:04:59 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: coywolf@gmail.com, coywolf@sosdg.org, linux-kernel@vger.kernel.org,
       james4765@cwazy.co.uk
References: <20050325003316.GA31352@everest.sosdg.org> <20050324164435.4286ac5f.akpm@osdl.org>
In-Reply-To: <20050324164435.4286ac5f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Broken-Reverse-DNS: no host name for for IP address 218.24.186.37
X-Scan-Signature: 606d05678d99939d828f76c30af4f056
X-SA-Exim-Connect-IP: 218.24.186.37
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: Re: [patch] oom-killer sysrq-f fix
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  4.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.186.37 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.2 (built Sun, 13 Feb 2005 18:23:43 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Coywolf Qi Hunt <coywolf@sosdg.org> wrote:
> 
>>Recent make-sysrq-f-call-oom_kill.patch calls oom-killer in interrupt context,
>>thus results into panic. This patch fixes out_of_memory() to avoid schedule
>>when in interrupt context.
>>
>>	Coywolf
>>
>>
>>Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
>>
>>diff -pruN 2.6.12-rc1-mm2/mm/oom_kill.c 2.6.12-rc1-mm2-cy/mm/oom_kill.c
>>--- 2.6.12-rc1-mm2/mm/oom_kill.c	2005-03-03 17:12:18.000000000 +0800
>>+++ 2.6.12-rc1-mm2-cy/mm/oom_kill.c	2005-03-25 08:07:19.000000000 +0800
>>@@ -20,6 +20,7 @@
>> #include <linux/swap.h>
>> #include <linux/timex.h>
>> #include <linux/jiffies.h>
>>+#include <linux/hardirq.h>
>> 
>> /* #define DEBUG */
>> 
>>@@ -283,6 +284,9 @@ retry:
>> 	if (mm)
>> 		mmput(mm);
>> 
>>+	if (in_interrupt())
>>+		return;
> 
> 
> That'll make the whole feature a no-op, won't it?

It won't be a no-op. I have tested it. It works well.
I pressed sysrq-f, loging bash got killed and I had to re-login.

> 
> The thing needs to be moved into process context via schedule_work().  I
> haven't got around to it yet.
> 

I don't think schedule_work() is a good option here.  Since sysrq-f is emergent,
we just let oom-killer send SIGKILL in interrupt context and return.

We needn't send SIGKILL in a process context. That'll be slow and [events] may got delayed.

