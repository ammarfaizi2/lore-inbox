Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUEVCsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUEVCsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbUEVCsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:48:25 -0400
Received: from mail.tpgi.com.au ([203.12.160.57]:17836 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264633AbUEVCsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:48:16 -0400
Message-ID: <40AEBE54.4050702@linuxmail.org>
Date: Sat, 22 May 2004 12:43:32 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
References: <40A8606D.1000700@linuxmail.org> <20040521093307.GB15874@elf.ucw.cz> <40ADF605.2040809@linuxmail.org> <20040521133422.GG10052@elf.ucw.cz>
In-Reply-To: <20040521133422.GG10052@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Pavel Machek wrote:
>>No... this is what you already know, just described differently. You 
>>mentioned in your documentation that suspend2 overcomes the half of 
>>memory limitation by saving the image in two parts: the second part is 
>>LRU (unless I have my terminology confused: I'm talking about pages on 
> 
> 
> Yes, I just did not realize that it means changes for freezer.

It means that we need to be more careful to ensure that processes all 
processes are frozen than we do with your implementation: we can't have 
processes forking or exiting because a timer fires while we're writing 
the first part of the image. (I saw that happen with bad effects).

>>Yes, but we're not just talking about user threads. We could 
>>differentiate kernel threads and user threads (presumably using another 
>>PF_ flag?) and attempt to freeze the user threads first.
> 
> There should be some other way to see kernel threads... their mm is
> init_mm or something like that.

Yes.

> Did you add hooks into sys_read() to deal with with
> kernel-thread-vs-kernel-thread ordering?

With the hooks, I don't have to worry about ordering at all. Once the 
atomic_t comes down to zero, every process has either entered the 
refrigerator because it hit a start/restart hook or wasn't doing 
anything to start with. I don't have to care about ordering because 
anything that does start activity while I'm signalling hits a hook and 
gets refrigerated anyway, even if it's not in response to the pseudo-signal.

> Well, slowness is likely to be something like 1% at
> microbenchmark. (Try lm_bench, test "lat-read" or something like
> that). Of course you don't feel any slowness; but you'd probably not
> feel any slowness if kernel was compiled -O0 either. 

:>. I'll put benchmarking on my todo list...

>>Summary:
>>- I'll try your user space first, kernel space afterwards suggestion.
>>- I'll also look into benchmarking the system with and without suspend2 
>>compiled in (ie with and without the hooks, since they compile away to 
>>nothing without CONFIG_SOFTWARE_SUSPEND2
> 
> 
> Don't spend too much time benchmarking... But you might want to ask Al
> Viro what he thinks about another test in sys_read ;-).

... and won't spend too long on it :>. I think I can guess.

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
