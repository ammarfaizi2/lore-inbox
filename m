Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268235AbUJMCKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268235AbUJMCKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 22:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUJMCKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 22:10:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:48769 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268235AbUJMCJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 22:09:56 -0400
Date: Tue, 12 Oct 2004 19:09:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: John Byrne <john.l.byrne@hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Still a mm bug in the fork error path
In-Reply-To: <416C6915.9080201@hp.com>
Message-ID: <Pine.LNX.4.58.0410121902100.3897@ppc970.osdl.org>
References: <416C6915.9080201@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Oct 2004, John Byrne wrote:
> 
> @@ -1104,9 +1146,7 @@
>   bad_fork_cleanup_namespace:
>   	exit_namespace(p);
>   bad_fork_cleanup_mm:
> -	exit_mm(p);
> -	if (p->active_mm)
> -		mmdrop(p->active_mm);
> +	mmput(p->mm);
>   bad_fork_cleanup_signal:
>   	exit_signal(p);
>   bad_fork_cleanup_sighand:
> 
> However, the new code will panic if the thread being forked is a process 
> with a NULL mm. It looks very unlikely to be hit in the real world, but 
> it is possible.

Hmm.. How does it happen? As far as I can tell, we only get here if
 - copy_thread or copy_namespaces had an error
and "mm" can be NULL only for kernel threads.

Now, I don't think any kernel threads will ask for new namespaces, so 
copy_namespaces can't return an error. Similarly, I don't see how 
copy_thread() could either (at least on x86 it can only return an error if 
an IO bitmap allocation fails, I think - again something that shouldn't 
happen for kernel threads. And most other architectures will never fail 
at all, I do believe).

> (My modified kernel makes it much more likely which is how I found it.)
> The attached patch is against 2.6.9-rc4. This time for sure!

I don't mind the patch per se, but I'd rather put it in after 2.6.9 unless
you can tell me how this can actually happen with an unmodified kernel.

			Linus
