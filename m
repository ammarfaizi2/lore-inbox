Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264365AbUEDNff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUEDNff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 09:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbUEDNff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 09:35:35 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:24517 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S264365AbUEDNfc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 09:35:32 -0400
Message-ID: <40979C71.8060608@cs.auc.dk>
Date: Tue, 04 May 2004 15:36:49 +0200
From: Mikkel Christiansen <mixxel@cs.auc.dk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: workqueue and pending
References: <40962F75.8000200@cs.auc.dk>	<20040503162719.54fb7020.akpm@osdl.org>	<1083639081.20092.294.camel@gaston> <20040503201616.6f3b8700.akpm@osdl.org>
In-Reply-To: <20040503201616.6f3b8700.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the patch and it works fine

-Mikkel

Andrew Morton wrote:

>Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>  
>
>>    
>>
>>> 
>>>@@ -75,8 +76,11 @@ extern void init_workqueues(void);
>>>  */
>>> static inline int cancel_delayed_work(struct work_struct *work)
>>> {
>>>-	return del_timer_sync(&work->timer);
>>>+	int ret;
>>>+
>>>+	ret = del_timer_sync(&work->timer);
>>>+	clear_bit(0, &work->pending);
>>>+	return ret;
>>> }
>>> 
>>>      
>>>
>>Looks wrong to me. The time may have fired already and queued the
>>work. Clearing pending is an error in this case since the work is
>>indeed pending for execution.... 
>>    
>>
>
>OK...
>
>--- 25/include/linux/workqueue.h~cancel_delayed_work-fix	2004-05-03 20:14:26.796321416 -0700
>+++ 25-akpm/include/linux/workqueue.h	2004-05-03 20:15:41.010039216 -0700
>@@ -7,6 +7,7 @@
> 
> #include <linux/timer.h>
> #include <linux/linkage.h>
>+#include <linux/bitops.h>
> 
> struct workqueue_struct;
> 
>@@ -75,8 +76,12 @@ extern void init_workqueues(void);
>  */
> static inline int cancel_delayed_work(struct work_struct *work)
> {
>-	return del_timer_sync(&work->timer);
>+	int ret;
>+
>+	ret = del_timer_sync(&work->timer);
>+	if (ret)
>+		clear_bit(0, &work->pending);
>+	return ret;
> }
> 
> #endif
>-
>
>_
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

