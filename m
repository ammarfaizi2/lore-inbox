Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268270AbUJMD1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268270AbUJMD1w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 23:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUJMD1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 23:27:51 -0400
Received: from palrel12.hp.com ([156.153.255.237]:16576 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S268270AbUJMD1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 23:27:48 -0400
Message-ID: <416CA0B1.20900@hp.com>
Date: Tue, 12 Oct 2004 20:27:45 -0700
From: John Byrne <john.l.byrne@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Still a mm bug in the fork error path
References: <416C6915.9080201@hp.com> <Pine.LNX.4.58.0410121902100.3897@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410121902100.3897@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 12 Oct 2004, John Byrne wrote:
> 
>>@@ -1104,9 +1146,7 @@
>>  bad_fork_cleanup_namespace:
>>  	exit_namespace(p);
>>  bad_fork_cleanup_mm:
>>-	exit_mm(p);
>>-	if (p->active_mm)
>>-		mmdrop(p->active_mm);
>>+	mmput(p->mm);
>>  bad_fork_cleanup_signal:
>>  	exit_signal(p);
>>  bad_fork_cleanup_sighand:
>>
>>However, the new code will panic if the thread being forked is a process 
>>with a NULL mm. It looks very unlikely to be hit in the real world, but 
>>it is possible.
> 
> 
> Hmm.. How does it happen? As far as I can tell, we only get here if
>  - copy_thread or copy_namespaces had an error
> and "mm" can be NULL only for kernel threads.
> 
> Now, I don't think any kernel threads will ask for new namespaces, so 
> copy_namespaces can't return an error. Similarly, I don't see how 
> copy_thread() could either (at least on x86 it can only return an error if 
> an IO bitmap allocation fails, I think - again something that shouldn't 
> happen for kernel threads. And most other architectures will never fail 
> at all, I do believe).
> 
> 
>>(My modified kernel makes it much more likely which is how I found it.)
>>The attached patch is against 2.6.9-rc4. This time for sure!
> 
> 
> I don't mind the patch per se, but I'd rather put it in after 2.6.9 unless
> you can tell me how this can actually happen with an unmodified kernel.
> 
> 			Linus
> 

In my kernel, it was a SIGKILL to a forking kernel thread that caused 
the problem. While I see SIGKILLs being sent to some kernel threads, I 
don't know if any of the kernel threads ever fork. If they don't, 
barring a demented root user sending SIGKILLs to kernel threads, I don't 
know if anyone else will ever see this. So, I don't have any problems 
with it being fixed post 2.6.9.

Thanks,

John Byrne





