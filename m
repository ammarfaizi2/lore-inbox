Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265885AbUEUPZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbUEUPZa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 11:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUEUPZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 11:25:30 -0400
Received: from gprs214-11.eurotel.cz ([160.218.214.11]:15489 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265885AbUEUPZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 11:25:23 -0400
Date: Fri, 21 May 2004 15:34:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
Message-ID: <20040521133422.GG10052@elf.ucw.cz>
References: <40A8606D.1000700@linuxmail.org> <20040521093307.GB15874@elf.ucw.cz> <40ADF605.2040809@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ADF605.2040809@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>First of all, let me explain that although swsusp and suspend2 work at a 
> >>very fundamental level in the same way, there are also some important 
> >>differences. Of particular relevance to this conversation is the fact 
> >>that swsusp makes what is as close to an atomic copy of the entire image 
> >>to be saved as we can get and then saves it. In contrast, suspend2 saves 
> >>one portion of the memory (lru pages), makes an atomic copy of the rest 
> >>and then saves the atomic copy of the second part.
> >
> >
> >Hmm, I did not realize this difference. Doing these hacks with LRU
> >seems pretty crazy to me...
> 
> No... this is what you already know, just described differently. You 
> mentioned in your documentation that suspend2 overcomes the half of 
> memory limitation by saving the image in two parts: the second part is 
> LRU (unless I have my terminology confused: I'm talking about pages on 

Yes, I just did not realize that it means changes for freezer.

> >>Secondly, we have a more basic problem with the existing freezer 
> >>implementation. A fundamental assumption made by it is that the order in 
> >>which processes are signalled does not matter; that there will be no 
> >>deadlocks caused by freezing one process before another. This simply 
> >>isn't true.
> >
> >
> >It better should be. If it is not true, then kill -STOP -1 does not
> >work, and that would be a kernel bug, right?
> 
> We already discussed the example of trying to do an ls on an NFS share 
> and the NFS threads being frozen first. I can come up with more examples 
> if you'd like. I guess the simplest one (off the top of my head) would 
> be freezing kjournald while processes are submitting and waiting on
> I/O.

Agreed, kernel processes need to go last.

> >When user thread is stopped, it should better not hold any lock,
> >because otherwise we have problem anyway.
> 
> Yes, but we're not just talking about user threads. We could 
> differentiate kernel threads and user threads (presumably using another 
> PF_ flag?) and attempt to freeze the user threads first.

There should be some other way to see kernel threads... their mm is
init_mm or something like that.

> >Kernel threads are different, and each must be handled separately,
> >maybe even with some ordering. But there's relatively small number of
> >kernel threads... 
> 
> Yes, but what order? I played with that problem for ages. Perhaps I just 
>  didn't find the right combination.

... ... hmm. Not sure.

Did you add hooks into sys_read() to deal with with
kernel-thread-vs-kernel-thread ordering?

> >>The implementation of the freezer that I have developed addresses these 
> >>concerns by adding an atomic count of the number of procesess in 
> >>critical paths. The first part of the freezer simply waits for the 
> >>number of processes in critical paths to reach zero.
> >
> >Exactly, you slowed down critical paths of kernel... This makes patch
> >big, ugly, and is bad idea.
> 
> Maybe I wasn't clear enough. When we're not suspending, all that is 
> added to the paths that are modified is:
> 
> - 9 tests, possibly resulting in refrigerator entry or immediately 
> dropping through, setting the PF_FRIDGE_WAIT flag and incrementing the 
> atomic_t at the start of a busy path.
> - 2 tests, possibly resetting the flag & decrementing the counter at the 
> end.
> - 3 tests, setting a local variable, restting the FRIDGE_WAIT flag and 
> decrementing the atomic_t when dropping locks and sleeping in kernel.
> - 10 tests, possibly resulting in refrigerator entry or immediately 
> dropping through, restoring the PF_FRIDGE_WAIT flag and reincrementing 
> the atomic_t after such sleeps.
> 
> I've been using this approach for months, and my Celeron 933 doesn't 
> feel slow at all. I've had no complains from users either.

Well, slowness is likely to be something like 1% at
microbenchmark. (Try lm_bench, test "lat-read" or something like
that). Of course you don't feel any slowness; but you'd probably not
feel any slowness if kernel was compiled -O0 either. 

> Summary:
> - I'll try your user space first, kernel space afterwards suggestion.
> - I'll also look into benchmarking the system with and without suspend2 
> compiled in (ie with and without the hooks, since they compile away to 
> nothing without CONFIG_SOFTWARE_SUSPEND2

Don't spend too much time benchmarking... But you might want to ask Al
Viro what he thinks about another test in sys_read ;-).
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
