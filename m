Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265365AbUEUJdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbUEUJdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 05:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbUEUJdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 05:33:21 -0400
Received: from gprs214-158.eurotel.cz ([160.218.214.158]:42369 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265365AbUEUJdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 05:33:18 -0400
Date: Fri, 21 May 2004 11:33:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
Message-ID: <20040521093307.GB15874@elf.ucw.cz>
References: <40A8606D.1000700@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A8606D.1000700@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In merging suspend2, one of the biggest changes is in the area of 
> freezing activity. I'm writing this email in an effort to improve 
> understanding of why I've implemented the freezer differently, and 
> perhaps get some ideas as to how I could better achieve the desired
> results.

Thanks for this. (Btw you might want to Cc me on such mails, I read
both list and personal mails, but you'll get way better response time.)

> First of all, let me explain that although swsusp and suspend2 work at a 
> very fundamental level in the same way, there are also some important 
> differences. Of particular relevance to this conversation is the fact 
> that swsusp makes what is as close to an atomic copy of the entire image 
> to be saved as we can get and then saves it. In contrast, suspend2 saves 
> one portion of the memory (lru pages), makes an atomic copy of the rest 
> and then saves the atomic copy of the second part.

Hmm, I did not realize this difference. Doing these hacks with LRU
seems pretty crazy to me...

Would it be possible to stop processes when they try to manipulate
LRU, instead?

> Secondly, we have a more basic problem with the existing freezer 
> implementation. A fundamental assumption made by it is that the order in 
> which processes are signalled does not matter; that there will be no 
> deadlocks caused by freezing one process before another. This simply 
> isn't true.

It better should be. If it is not true, then kill -STOP -1 does not
work, and that would be a kernel bug, right?

When user thread is stopped, it should better not hold any lock,
because otherwise we have problem anyway.

Kernel threads are different, and each must be handled separately,
maybe even with some ordering. But there's relatively small number of
kernel threads... 

> Thirdly, the existing implementation does not allow us to quickly stop 
> activity. Under heavy load, particularly heavy I/O (assuming the freezer 
> does work), it make take quite a while for processes to respond to the 
> pseudo-signal and enter the refrigerator. New processes may also be 
> spawned, further complicating matters. The busier the system is, the 
> more hit-and-miss freezing becomes.

I agree it can take longer, but modulo bugs, it should be always possible.

> The implementation of the freezer that I have developed addresses these 
> concerns by adding an atomic count of the number of procesess in 
> critical paths. The first part of the freezer simply waits for the 
> number of processes in critical paths to reach zero.

Exactly, you slowed down critical paths of kernel... This makes patch
big, ugly, and is bad idea.

> These four macros play a further role. When we begin to wait for the 
> activity counter to reach zero, a flag is set to record this fact. Macro 
> calls check this flag, and a process reaching a START or RESTARTING 
> activity macro while the flag is set will be refrigerated at that point 
> until after the suspend cycle is completed. This helps us quiesce the 
> system more quickly.

Adding hooks to "fast" stuff like read()/write()/open is no-no. Adding
small number of hooks to slower stuff like exec()/exit() might be
acceptable. Could you get away with that?

								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
