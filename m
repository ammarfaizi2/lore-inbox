Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161259AbWI2Qvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161259AbWI2Qvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbWI2Qvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:51:37 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:1707 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161259AbWI2Qvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:51:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=iF1y9isP25KeZpkh+MCwvzNvi6KUFLrtqg9R5XkaCvg1aYyYTFwJXXxIHdmu1PCYYNy+HoDDGHhKxosM6gaXFGZd6/f1OpcCdejbGUvElbsG/VjxvGhEiNJ7Gp6A6qj3s4lzk4DQ00agvAbLx4SC5mi9LxjSCui6AHExLnfzKEk=
In-Reply-To: <F2F2C98F-6AFB-4E19-BEE9-D32652E2F478@atheme.org>
References: <0635847A-C149-412C-92B1-A974230381F8@dts.local> <F2F2C98F-6AFB-4E19-BEE9-D32652E2F478@atheme.org>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE7C757E-E2CE-4617-A1D4-3B8F5E3E8240@gmail.com>
Cc: William Pitcock <nenolod@atheme.org>, girishvg@gmail.com
Content-Transfer-Encoding: 7bit
From: girish <girishvg@gmail.com>
Subject: Re: [PATCH] include children count, in Threads: field present in /proc/<pid>/status (take-1)
Date: Sat, 30 Sep 2006 01:51:31 +0900
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.749)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 30, 2006, at 1:31 AM, William Pitcock wrote:

>
> On Sep 29, 2006, at 10:18 AM, girish wrote:
>
>>
>> -	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads);
>> +	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads +  
>> num_children);
>
> Personally, I'd prefer the children count to be separate, something  
> like:
>
> buffer += sprintf(buffer, "Threads:\t%d (%d children, %d total)",  
> num_threads, num_children, num_threads + num_children);
>
> That would be rather nice, indeed.
>
> Also, next time, make sure that linux-kernel is CC'd, not BCC'd.
>
> ---
> William Pitcock
> nenolod@atheme.org
> http://people.atheme.org/~nenolod/
> http://nenolod.net
>
>

Agree.  It indeed look better. I too had an awk script in mind, to  
parse the line.  I ended up removing such formatting, because not all  
process spawn child thread(s), showing num_children count as zero.  
That looked bit odd. So here it is again - new wine.

Thanks.

Signed-off-by: Girish V. Gulawani <girishvg@gmail.com>
--- linux-vanilla/fs/proc/array.c	2006-09-20 12:42:06.000000000 +0900
+++ linux/fs/proc/array.c	2006-09-30 01:47:25.000000000 +0900
@@ -248,6 +248,8 @@ static inline char * task_sig(struct tas
  	int num_threads = 0;
  	unsigned long qsize = 0;
  	unsigned long qlim = 0;
+	int num_children = 0;
+	struct list_head *_p;

  	sigemptyset(&pending);
  	sigemptyset(&shpending);
@@ -268,9 +270,14 @@ static inline char * task_sig(struct tas
  		qlim = p->signal->rlim[RLIMIT_SIGPENDING].rlim_cur;
  		spin_unlock_irq(&p->sighand->siglock);
  	}
+	list_for_each(_p, &p->children)
+		++num_children;
  	read_unlock(&tasklist_lock);

-	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads);
+	buffer += sprintf(buffer, "Threads:\t%d", num_threads);
+	if (num_children)
+		buffer += sprintf(buffer, " (%d children, %d total)",  
num_children, num_threads + num_children);
+	buffer += sprintf(buffer, "\n");
  	buffer += sprintf(buffer, "SigQ:\t%lu/%lu\n", qsize, qlim);

  	/* render them all */
