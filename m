Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUDJTAN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 15:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUDJTAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 15:00:13 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:17617 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261225AbUDJTAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 15:00:06 -0400
Message-ID: <4078440A.9050909@stanford.edu>
Date: Sat, 10 Apr 2004 11:59:22 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
CC: Andy Lutomirski <luto@myrealbox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH, local root on 2.4, 2.6?] compute_creds race
References: <4076F02E.1000809@myrealbox.com> <87fzbc19d5.fsf@goat.bogus.local>	<40781588.7080503@stanford.edu> <87isg7zndy.fsf@goat.bogus.local>
In-Reply-To: <87isg7zndy.fsf@goat.bogus.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Olaf Dietsche wrote:
> Andy Lutomirski <luto@stanford.edu> writes:
>>Olaf Dietsche wrote:
>>>Andy Lutomirski <luto@myrealbox.com> writes:
>>>
>>>
>>>>The setuid program is now running with uid=euid=500 but full permitted
>>>>capabilities.  There are two (or three) ways to effectively get local
>>>>root now:
>>>
>>>What about this slightly shorter fix?
>>>diff -urN a/fs/exec.c b/fs/exec.c
>>>--- a/fs/exec.c	Fri Mar 12 01:19:06 2004
>>>+++ b/fs/exec.c	Sat Apr 10 10:54:20 2004
>>>@@ -942,6 +942,9 @@
>>> 			if(!capable(CAP_SETUID)) {
>>> 				bprm->e_uid = current->uid;
>>> 				bprm->e_gid = current->gid;
>>>+				cap_clear (bprm->cap_inheritable);
>>>+				cap_clear (bprm->cap_permitted);
>>>+				cap_clear (bprm->cap_effective);
>>> 			}
>>> 		}
>>> 	}
>>
>>This makes the bprm_compute_creds hook even less sane than now
>>(i.e. it assumes that all LSMs will work like the current capability
>>modules).  The hook should allow LSM to change this functionality
>>without reintroducing the race.  For example, it breaks my work on
>>fixing capabilities.
> 
> 
> This patch fixes the problem without moving and renaming huge amounts
> of code. And the hook is still in place, so I don't see your problems.
> 
> If you look at the code - as seen in 2.4 and early 2.5 - that's (more
> or less) the place where the fix should be.

With your patch, compute_creds tries assumes that, if a program is not setuid, 
it should clear all capabilities.  This would be very wrong if capabilities 
worked right.

It may also be wrong with the current caps code.  If root execs a setuid-nonroot 
program from a thread, your patch looks like the program will start up as root 
but without capabilities.  I don't see a trivial fix for it, short of moving 
some code.

--Andy

> 
> Anyway, I don't really object against moving code around.
> 
> Regards, Olaf.
