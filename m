Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTLCRrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTLCRru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:47:50 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:6565 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264292AbTLCRrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:47:10 -0500
Message-ID: <3FCE217E.1080007@colorfullife.com>
Date: Wed, 03 Dec 2003 18:46:38 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Raj <raju@mailandnews.com>, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net
Subject: Re: kernel BUG at kernel/exit.c:792!
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com> <20031203182319.D14999@in.ibm.com>
In-Reply-To: <20031203182319.D14999@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:

> --- base.c 2003-10-26 00:13:57.000000000 +0530
>
>>+++ base.c.fix	2003-12-03 17:20:18.877679360 +0530
>>@@ -1669,7 +1669,7 @@
>> 	do {
>> 		int tid = task->pid;
>> 		if (!pid_alive(task))
>>-			continue;
>>+			break;
>>
No, a break would be wrong: The test detects already dead tasks that are 
still listed in the task list. If such a task is found, then it 
shouldn't be listed in /proc/, but the readdir call should continue to 
scan the task list.

But I don't understand the oops:
__exit_sighand clears current->sighand, and then in the next line 
__unhash_process removes the thread from the task list. But that's under 
write_lock_irq(&tasklist_lock), and get_tid_list runs under 
read_lock(&tasklist_lock). It should be impossible that ->sighand is 
NULL and the task is still listed in the task list.

--
    Manfred

