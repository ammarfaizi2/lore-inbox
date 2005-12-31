Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVLaBJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVLaBJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVLaBJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:09:05 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:27688 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751295AbVLaBJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:09:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HaBN+nHPZWrMCYxUHIWPu2gWdeoL84vBzn7H+pKy0g6e8Kvj0aXP3JlYq7DQoBPG9I0HGYfITzd1K5Hti0+XzDL9ohnwg8JXYrIKBdaAJLOs4jbgX6kQzhxiKae3U0jVkdzFxwSyHvpsFB3sIYwFMZfWv7c/v0ieItdgvsyRdwU=
Message-ID: <43B5DA26.8060708@gmail.com>
Date: Sat, 31 Dec 2005 09:08:54 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gregkh@suse.de,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix user data corrupted by old value return of sysctl
References: <43B4F287.6080307@gmail.com> <Pine.LNX.4.64.0512300916220.3249@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512300916220.3249@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Fri, 30 Dec 2005, Yi Yang wrote:
>  
>
>>If the user reads a sysctl entry which is of string type
>>by sysctl syscall, this call probably corrupts the user data
>>right after the old value buffer, the issue lies in sysctl_string
>>seting 0 to oldval[len], len is the available buffer size
>>specified by the user, obviously, this will write to the first
>>byte of the user memory place immediate after the old value buffer,
>>the correct way is that sysctl_string doesn't set 0, the user
>>should do it by self in the program.
>>    
>>
>
>Hmm.. I think this patch is incomplete.
>
>We _should_ zero-pad the data, at least if the result fits in the buffer.
>
>So I think the correct fix is to just _copy_ the last zero if it fits in 
>the buffer, rather than do the unconditional "add NUL at the end" thing. 
>The simplest way to do that is to just make "l" be "strlen(str)+1", so 
>that we count the ending NUL in the length (and then, if the buffer isn't 
>big enough, we will truncate it).
>
>In other words, I would instead suggest a patch like the appended.
>
>But even that is questionable: one alternative is to always zero-pad (like 
>we used to), but make sure that the buffer size is sufficient for it (ie 
>instead of adding one to the length of the string, we'd subtract one from 
>the buffer length and make sure that the '\0' fits..
>
>Comments?
>  
>
Yes, you are more complete, I agree with it very much.

>		Linus
>---
>diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>index 9990e10..ad0425a 100644
>--- a/kernel/sysctl.c
>+++ b/kernel/sysctl.c
>@@ -2201,14 +2201,12 @@ int sysctl_string(ctl_table *table, int 
> 		if (get_user(len, oldlenp))
> 			return -EFAULT;
> 		if (len) {
>-			l = strlen(table->data);
>+			l = strlen(table->data)+1;
> 			if (len > l) len = l;
> 			if (len >= table->maxlen)
> 				len = table->maxlen;
> 			if(copy_to_user(oldval, table->data, len))
> 				return -EFAULT;
>-			if(put_user(0, ((char __user *) oldval) + len))
>-				return -EFAULT;
> 			if(put_user(len, oldlenp))
> 				return -EFAULT;
> 		}
>
>  
>

