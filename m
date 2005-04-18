Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVDRIhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVDRIhf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 04:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVDRIhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 04:37:35 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:32163 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261949AbVDRIhQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 04:37:16 -0400
Message-ID: <426371B5.2060200@lab.ntt.co.jp>
Date: Mon, 18 Apr 2005 17:37:09 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org>
In-Reply-To: <20050418075635.GB644@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry, I can not catch the point well,
but what I want to say is, we do not want stop the service due to bug fix.

As you said, if we can migrate the data to new process without stopping
service, it is OK, but the real applications need to takeover data very
much(sometimes it's over gigabyte....depends on service, and causes
service disruption...). So, live patching seems reasonable to us.
And unfortunately the APIs which people suggested are all based on
ptrace system calls. as you know, ptrace based data read/write needs to
stop the target process during read/write. We would like to minimize
target process stopping time.

>I'm guessing any suggestion of fixing the applications behavior would
>be lost with some argument along the lines of: "this application was
>written in 1824 by Ada Lovelace using pre-Roswell Alien Technology and
>was certified NEBS compliant by the Deli Lama and god herself, so
>clearly we can't touch a single line of it" or similar right?
well, it's possibly, but the same problems occur on gdb.
I think this depends on user's manner...

I briefly describe the way of live patching below;
1. Load the patch modules with pannus -l command.
- load the patch module with first memory mapping system call(ptrace
PEEKDATA can be same work, but it needs to stop target process..)
- search patch module's initialize area and execute them with
execinit.c(similler to signal handler)
- target process exec initialization.
2. Activate the patch modules with pannus -a command.
- stop the target process and check current instruction not to conflict.
- if it is not conflict, overwrite the jump assembly to function's
entrypoiny where you want to fix, to patch module's one.
- restart the process.

Will this be answer??

Chris Wedgwood wrote:

>On Mon, Apr 18, 2005 at 04:32:21PM +0900, Takashi Ikebe wrote:
>
>  
>
>>The software does not allow to stops over 100 milliseconds at worst
>>case.
>>    
>>
>
>Out of interest, how do you ensure the process doesn't stop for that
>long right now?  Linux doesn't guarantee you'll get scheduled
>(strictly speaking) in n milliseconds usually.
>
>  
>
>>Not to descent the service availability, software fix due to bug,
>>should not stop the service, and live patching is very historical
>>function in telecoms world.
>>    
>>
>
>Lots of really complicated and unnecessary things are common in the
>telecoms world.
>
>For the example you gave I can think of several ways to migrate data
>to a new process (if need be) in a timely manner without interruption.
>None of these *require* live patching.
>
>  
>
>>Every carrier, NEPs(Network Equipment Provider) provide/use this
>>function to keep network service (such as telephone) available.
>>    
>>
>
>How does this *require* live patching?
>
>  
>
>>This function is very essential whenever the carrier use the linux
>>as center of it's system.
>>    
>>
>
>Those are just marketing words.
>
>  
>
>>Therefore the live patching function should not stop the target
>>process (service process) as possible as. the more times we stop the
>>target process, the service goes unavailable...
>>    
>>
>
>Love patching seems like a very complicated thing to get right and it
>could potentially blow up.
>
>I'm guessing any suggestion of fixing the applications behavior would
>be lost with some argument along the lines of: "this application was
>written in 1824 by Ada Lovelace using pre-Roswell Alien Technology and
>was certified NEBS compliant by the Deli Lama and god herself, so
>clearly we can't touch a single line of it" or similar right?
>  
>


-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp


