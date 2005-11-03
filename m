Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVKCIrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVKCIrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 03:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVKCIrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 03:47:51 -0500
Received: from [85.8.13.51] ([85.8.13.51]:45461 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751154AbVKCIrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 03:47:51 -0500
Message-ID: <4369CEA9.4030008@drzeus.cx>
Date: Thu, 03 Nov 2005 09:47:37 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: swsusp not able to stop tasks
References: <4368BDA7.6060401@drzeus.cx> <20051102133825.GG30194@elf.ucw.cz> <4368DB5C.7070609@drzeus.cx> <20051102210326.GC23943@elf.ucw.cz>
In-Reply-To: <20051102210326.GC23943@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
>   
>>> What is this kauditd? Try turning auditing off in kernel config, and
>>> it should go away. If it does, add try_to_freeze() at place where
>>> sleep is possible into kauditd...
>>>       
>> That it did. And the machine suspends fine with audit removed. I'll have 
>> a look at inserting those try_to_freeze().
>>     
>
> Good.
>
>   

The following did the trick:

diff --git a/kernel/audit.c b/kernel/audit.c
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -291,8 +291,10 @@ int kauditd_thread(void *dummy)
                        set_current_state(TASK_INTERRUPTIBLE);
                        add_wait_queue(&kauditd_wait, &wait);

-                       if (!skb_queue_len(&audit_skb_queue))
+                       if (!skb_queue_len(&audit_skb_queue)) {
+                               try_to_freeze();
                                schedule();
+                       }

                        __set_current_state(TASK_RUNNING);
                        remove_wait_queue(&kauditd_wait, &wait);


Rgds
Pierre

