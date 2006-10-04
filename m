Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWJDGDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWJDGDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 02:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWJDGDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 02:03:38 -0400
Received: from smtpout.mac.com ([17.250.248.178]:42226 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030313AbWJDGDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 02:03:38 -0400
In-Reply-To: <efvcs7$526$1@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <4522B7CD.4040206@redhat.com> <efv8pc$31o$1@taverner.cs.berkeley.edu> <a36005b50610032051h64609d51kf1e5211d1bf07370@mail.gmail.com> <efvcs7$526$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E4468D90-DABA-4622-983F-594B40EBE152@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Wed, 4 Oct 2006 02:03:18 -0400
To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 04, 2006, at 00:21:27, David Wagner wrote:
> Ulrich Drepper wrote:
>> On 10/3/06, David Wagner <daw@cs.berkeley.edu> wrote:
>>> Are you familiar with the mmap(PROT_EXEC, MAP_ANONYMOUS) loophole?
>>
>> Another person who doesn't know about SELinux.  Read
>>
>> http://people.redhat.com/drepper/selinux-mem.html
>
> You're right, I didn't know about that one.  Thanks for the  
> education and for taking the time to respond.
>
> I wonder whether it is feasible to run with allow_exec 
> {heap,mem,mod,stack} all set to false, on a real system.

Yes it is; I have done so with a custom SELinux policy before  
although it was a company-proprietary policy and I can't share it on  
the LKML.  It does fairly severely restrict certain binaries,  
especially ones like the Java VM or anything else with a Just-in-Time  
compiler.  You can make it completely impossible for any non-admin- 
originated executable or library to ever make it out to any kind of  
storage from which it could be run.  It's still possible to  
compromise a currently-running instance of a binary; but it's  
impossible to maintain that compromise across a restart of the  
appropriate server process.  With appropriate restrictions and  
compliant hardware it's even easy to make it impossible to write to  
any PROT_EXEC memory or remap any writable memory as PROT_EXEC.

Such protections require a fair amount of tinkering with userspace  
and SELinux security policy, but in combination with address-space  
randomization makes it extremely difficult or impossible to exploit a  
stack-smash or buffer-overflow bug beyond a DoS.

It also conveniently lets you lock down a box to the point where even  
root is a meaningless concept.  I've helped architect one box where  
you have to log in as a rootstaff user with your PKI keycard on the  
local console and then enter a second password to transition to the  
rootadmin role and from _there_ you have what's considered "ordinary"  
root privs, but you don't even have to have that access.

> Is there any example of a fully worked out SELinux policy that has  
> these set to false?  FC5 has allow_execheap set to false and all  
> others set to true in its default SELinux policy, so it looks like  
> the mmap(PROT_EXEC, MAP_ANONYMOUS) loophole remains open in FC5 by  
> default.  My concern would be that setting
> all of the exec-related booleans to false might break so much code  
> that
> setting them all to false wouldn't be feasible in practice.

No, it's doable but it breaks Java and WINE and a number of other  
programs where you _want_ to allow modifiable code.

> If so, the theoretical possibility to close the mmap(PROT_EXEC,  
> MAP_ANONYMOUS)  loophole may be one of these things that is  
> possible in theory but not in practice.

Oh, it's very possible in practice; but for an average distro it's  
not useful to prohibit writable code.  There's too many insecure  
things that users want to do that require it.  Just please don't  
break the extra security for those of us who don't need Java or WINE  
and are willing to fix the odd broken program.

Cheers,
Kyle Moffett

