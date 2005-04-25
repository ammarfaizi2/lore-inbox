Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVDYCLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVDYCLk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 22:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVDYCLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 22:11:39 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:63667 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S262444AbVDYCLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 22:11:33 -0400
Message-ID: <426C51C4.9040902@lab.ntt.co.jp>
Date: Mon, 25 Apr 2005 11:11:16 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp> <m1y8b9xyaw.fsf@muc.de>
In-Reply-To: <m1y8b9xyaw.fsf@muc.de>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Andi Kleen wrote:

>Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp> writes:
>
>  
>
>>The patch was over 50k, so I separate it to each architecture and in line..
>>
>>This patch add function called "Live patching" which is defined on
>>OSDL's carrier grade linux requiremnt definition to linux 2.6.11.7 kernel.
>>The live patching allows process to patch on-line (without restarting
>>process) on i386 and x86_64 architectures, by overwriting jump assembly
>>code on entry point of functions which you want to fix, to patched
>>functions.
>>    
>>
>
>How exactly is this different from ptrace?
>Seems just like a ptrace memcpy extension 
>Is the patching really that time critical that you cant do it 
>with normal ptrace?
>  
>
Only few patch modules are not so critical, however sometimes large
number of patches are applied at one time. In that case, time is very
critical with normal ptrace. As you know, normal ptrace need to target
process STOP whenever change the memory/registers.
Our approach is "do not stop the target process's execution as possible
as", because the target process can provide service during patch on SMP
machine (do not want to stop service due to patch).
If we load hundreds of patch modules at one time, I think it will goes
quite time critical..

>>+	if(((current->uid != tsk->euid) ||
>>+	    (current->uid != tsk->suid) ||
>>+	    (current->uid != tsk->uid) ||
>>+	    (current->gid != tsk->egid) ||
>>+	    (current->gid != tsk->sgid) ||
>>+	    (current->gid != tsk->gid)) && !capable(CAP_SYS_PANNUS)) {
>>+                // invalid user in sys_accesspvm
>>+                return -EPERM;
>>+        }
>>+> +	p = vmalloc(len);
>>    
>>
>
>This needs a limit. 
>  
>
Thank you, we'll fix this soon.

>annus-x86_64/arch/x86_64/kernel/entry.S
>  
>
>>--- linux-2.6.11.7-vanilla/arch/x86_64/kernel/entry.S	2005-04-08 03:57:30.000000000 +0900
>>+++ linux-2.6.11.7-pannus-x86_64/arch/x86_64/kernel/entry.S	2005-04-18 10:45:47.000000000 +0900
>>@@ -214,6 +214,8 @@ sysret_check:		
>> 	/* Handle reschedules */
>> 	/* edx:	work, edi: workmask */	
>> sysret_careful:
>>+	cmpl $0,threadinfo_inipending(%rcx)
>>+	jne sysret_init
>>    
>>
>
>Put the check into the normal notify_resume work mask, not adding
>a separate check into this critical fast path.
>  
>
OK, we'll fix this soon.

>> 	CFI_ENDPROC
>> 
>> /* 
>>+ * In the case restorer calls rt_handlereturn, collect and store registers,
>>+ * and call rt_handlereturn with stored register struct.
>>+ */
>>+ENTRY(stub_rt_handlereturn)
>>    
>>
>
>This seems quite pointless since ptrace and can change all registers
>in a child.
>  
>
Well, this can change as you said, but I think, this makes target
process stopping time increase.
Because, to control target process's (patch module's) initialization,
the command process should know the target process's status and then
stop with ptrace.
Currently rt_handlereturn works on target process's context like signal
handler return, so, I think there is minimum time loss on target process.
If command process controls the target process's initialization, this
seems target process's stopping time increasing.
Well, may be our idea is wrong, please tell us.

Thank you your advice!

>Didnt review more.
>
>-Andi
>  
>


-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp


