Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265844AbUEUMdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbUEUMdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 08:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265854AbUEUMdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 08:33:46 -0400
Received: from mail.tpgi.com.au ([203.12.160.53]:40922 "EHLO mail5.tpgi.com.au")
	by vger.kernel.org with ESMTP id S265844AbUEUMdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 08:33:39 -0400
Message-ID: <40ADF605.2040809@linuxmail.org>
Date: Fri, 21 May 2004 22:28:53 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
References: <40A8606D.1000700@linuxmail.org> <20040521093307.GB15874@elf.ucw.cz>
In-Reply-To: <20040521093307.GB15874@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Pavel Machek wrote:
> Thanks for this. (Btw you might want to Cc me on such mails, I read
> both list and personal mails, but you'll get way better response time.)

Humble apologies! :>

>>First of all, let me explain that although swsusp and suspend2 work at a 
>>very fundamental level in the same way, there are also some important 
>>differences. Of particular relevance to this conversation is the fact 
>>that swsusp makes what is as close to an atomic copy of the entire image 
>>to be saved as we can get and then saves it. In contrast, suspend2 saves 
>>one portion of the memory (lru pages), makes an atomic copy of the rest 
>>and then saves the atomic copy of the second part.
> 
> 
> Hmm, I did not realize this difference. Doing these hacks with LRU
> seems pretty crazy to me...

No... this is what you already know, just described differently. You 
mentioned in your documentation that suspend2 overcomes the half of 
memory limitation by saving the image in two parts: the second part is 
LRU (unless I have my terminology confused: I'm talking about pages on 
the inactive and active lists). By the time this is done, all other 
processes are stopped, so there's no danger of corruption anyway. 
Suspend2 itself doesn't affect LRU because I switched from using the 
'normal' swap read/write calls ages ago, as part of adding swapfile 
support. For 2.6 we're directly using BIOs.

> Would it be possible to stop processes when they try to manipulate
> LRU, instead?

They're already stopped.

>>Secondly, we have a more basic problem with the existing freezer 
>>implementation. A fundamental assumption made by it is that the order in 
>>which processes are signalled does not matter; that there will be no 
>>deadlocks caused by freezing one process before another. This simply 
>>isn't true.
> 
> 
> It better should be. If it is not true, then kill -STOP -1 does not
> work, and that would be a kernel bug, right?

We already discussed the example of trying to do an ls on an NFS share 
and the NFS threads being frozen first. I can come up with more examples 
if you'd like. I guess the simplest one (off the top of my head) would 
be freezing kjournald while processes are submitting and waiting on I/O.

> When user thread is stopped, it should better not hold any lock,
> because otherwise we have problem anyway.

Yes, but we're not just talking about user threads. We could 
differentiate kernel threads and user threads (presumably using another 
PF_ flag?) and attempt to freeze the user threads first.

> Kernel threads are different, and each must be handled separately,
> maybe even with some ordering. But there's relatively small number of
> kernel threads... 

Yes, but what order? I played with that problem for ages. Perhaps I just 
  didn't find the right combination.

>>Thirdly, the existing implementation does not allow us to quickly stop 
>>activity. Under heavy load, particularly heavy I/O (assuming the freezer 
>>does work), it make take quite a while for processes to respond to the 
>>pseudo-signal and enter the refrigerator. New processes may also be 
>>spawned, further complicating matters. The busier the system is, the 
>>more hit-and-miss freezing becomes.
> 
> I agree it can take longer, but modulo bugs, it should be always possible.

Should... I'll find some time to roll a freezer implementation that does 
what you're suggesting (try user space threads first, seek an order for 
kernel space threads). If we can do it that way, it will be less 
invasive. I'll see...

>>The implementation of the freezer that I have developed addresses these 
>>concerns by adding an atomic count of the number of procesess in 
>>critical paths. The first part of the freezer simply waits for the 
>>number of processes in critical paths to reach zero.
> 
> Exactly, you slowed down critical paths of kernel... This makes patch
> big, ugly, and is bad idea.

Maybe I wasn't clear enough. When we're not suspending, all that is 
added to the paths that are modified is:

- 9 tests, possibly resulting in refrigerator entry or immediately 
dropping through, setting the PF_FRIDGE_WAIT flag and incrementing the 
atomic_t at the start of a busy path.
- 2 tests, possibly resetting the flag & decrementing the counter at the 
end.
- 3 tests, setting a local variable, restting the FRIDGE_WAIT flag and 
decrementing the atomic_t when dropping locks and sleeping in kernel.
- 10 tests, possibly resulting in refrigerator entry or immediately 
dropping through, restoring the PF_FRIDGE_WAIT flag and reincrementing 
the atomic_t after such sleeps.

I've been using this approach for months, and my Celeron 933 doesn't 
feel slow at all. I've had no complains from users either.

We really need to ask how critical these paths really are: some of them 
are certainly more commonly used, such as sys_read & sys_write. The vast 
majority, however, are less commonly used. I wonder if it's worth 
getting a benchmarking program. I'll try your suggestion above first.

>>These four macros play a further role. When we begin to wait for the 
>>activity counter to reach zero, a flag is set to record this fact. Macro 
>>calls check this flag, and a process reaching a START or RESTARTING 
>>activity macro while the flag is set will be refrigerated at that point 
>>until after the suspend cycle is completed. This helps us quiesce the 
>>system more quickly.
> 
> 
> Adding hooks to "fast" stuff like read()/write()/open is no-no. Adding
> small number of hooks to slower stuff like exec()/exit() might be
> acceptable. Could you get away with that?

No. Reading and writing is exactly what we want to be able to pause. 
Otherwise we get processes stuck waiting on pages.

Summary:
- I'll try your user space first, kernel space afterwards suggestion.
- I'll also look into benchmarking the system with and without suspend2 
compiled in (ie with and without the hooks, since they compile away to 
nothing without CONFIG_SOFTWARE_SUSPEND2

Regards,

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable 
events occur
with alarming frequency, order arises from chaos, and no one is given 
credit.
