Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWI2SYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWI2SYs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWI2SYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:24:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:43040 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422647AbWI2SYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:24:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=VkVDo4wr/XO8aIS/32BVkq/1K2AXKtNl+2UGPrGScCn6QYTWDOxZ5dTXed36bnhV40lX7uqa6N5L57zDVCQ+ELTKV8ncLSI5l1LZqB1f/cIB2cjojaHetez9ewiLH72KDJd3MJSSsQ83meu4ngSC/9dAqy0iQcEThCyEz5OtESM=
In-Reply-To: <Pine.LNX.4.61.0609292011190.634@yvahk01.tjqt.qr>
References: <0635847A-C149-412C-92B1-A974230381F8@dts.local> <F2F2C98F-6AFB-4E19-BEE9-D32652E2F478@atheme.org> <EE7C757E-E2CE-4617-A1D4-3B8F5E3E8240@gmail.com> <Pine.LNX.4.61.0609291905550.27518@yvahk01.tjqt.qr> <CF74CE5D-42A1-4FF9-8C9B-682C5D6DEAE1@gmail.com> <Pine.LNX.4.61.0609292011190.634@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BEC70F7E-6143-4D8D-9800-A8538A152A18@gmail.com>
Cc: linux-kernel@vger.kernel.org, William Pitcock <nenolod@atheme.org>
Content-Transfer-Encoding: 7bit
From: girish <girishvg@gmail.com>
Subject: Re: [PATCH] include children count, in Threads: field present in /proc/<pid>/status (take-3)
Date: Sat, 30 Sep 2006 03:24:41 +0900
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.749)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 30, 2006, at 3:12 AM, Jan Engelhardt wrote:

>>
>> How about this?
>>
>> buffer += sprintf(buffer, "Threads:\t%d", num_threads);
>> if (num_children)
>>                buffer += sprintf(buffer, " Children: %d Total: %d",
>> num_children, num_threads + num_children);
>> buffer += sprintf(buffer, "\n");
>>
>
> No, this:
>
>> if (num_children)
>>                buffer += sprintf(buffer, "\nChildren: %d\nTotal: %d",
>
> the newlines are essential because then you get _one_ field of
> information for _each_ call of fgets().
>
>
>
> Jan Engelhardt
> --  

This is perfect. Here is the patch.
Thanks.

Signed-off-by: Girish V. Gulawani <girishvg@gmail.com>

--- linux-vanilla/fs/proc/array.c	2006-09-20 12:42:06.000000000 +0900
+++ linux/fs/proc/array.c	2006-09-30 03:18:28.000000000 +0900
@@ -248,6 +248,8 @@ static inline char * task_sig(struct tas
  	int num_threads = 0;
  	unsigned long qsize = 0;
  	unsigned long qlim = 0;
+	int num_children = 0;
+	struct list_head *_p;

  	sigemptyset(&pending);
  	sigemptyset(&shpending);
@@ -268,9 +270,13 @@ static inline char * task_sig(struct tas
  		qlim = p->signal->rlim[RLIMIT_SIGPENDING].rlim_cur;
  		spin_unlock_irq(&p->sighand->siglock);
  	}
+	list_for_each(_p, &p->children)
+		++num_children;
  	read_unlock(&tasklist_lock);

  	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads);
+	if (num_children)
+		buffer += sprintf(buffer, "Children:\t%d\nTotal:\t%d\n",  
num_children, num_threads + num_children);
  	buffer += sprintf(buffer, "SigQ:\t%lu/%lu\n", qsize, qlim);

  	/* render them all */

