Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266701AbUGLDUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266701AbUGLDUn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 23:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUGLDUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 23:20:43 -0400
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:5808 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S266701AbUGLDUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 23:20:40 -0400
Message-ID: <40F20372.9000205@quark.didntduck.org>
Date: Sun, 11 Jul 2004 23:20:18 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Grzegorz Kulewski <kangur@polcom.net>, Con Kolivas <kernel@kolivas.org>,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: post 2.6.7 BK change breaks Java?
References: <40EEB1B2.7000800@kolivas.org> <Pine.LNX.4.56.0407091954160.22376@jjulnx.backbone.dif.dk> <Pine.LNX.4.56.0407111713420.23979@jjulnx.backbone.dif.dk> <Pine.LNX.4.58.0407111728580.6988@alpha.polcom.net> <Pine.LNX.4.56.0407111735490.23998@jjulnx.backbone.dif.dk> <8A43C34093B3D5119F7D0004AC56F4BC082C7F9D@difpst1a.dif.dk>
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BC082C7F9D@difpst1a.dif.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On Sun, 11 Jul 2004, Jesper Juhl wrote:
> 
> 
>>On Sun, 11 Jul 2004, Grzegorz Kulewski wrote:
>>
>>
>>>On Sun, 11 Jul 2004, Jesper Juhl wrote:
>>>
>>>
>>>>On Fri, 9 Jul 2004, Jesper Juhl wrote:
>>>>
>>>>
>>>>>On Fri, 9 Jul 2004, Con Kolivas wrote:
>>>>>
>>>>>
>>>>>>but I suspect it's one of those possibly interfering. Looking at the
>>>>>>patches in question I have no idea how they could do it. I guess if you
>>>>>>can try backing them out it would be helpful. Here are links to the
>>>>>>patches in question.
>>>>>>http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1100_ip_tabl
>>>>>>es.patch
>>>>>>http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1105_CAN-200
>>>>>>4-0497.patch
>>>>>>http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1110_proc.pa
>>>>>>tch
>>>>>
>>>>>Thanks Con, I'll try playing with those tomorrow (got no time tonight),
>>>>>and report back.
>>>>>
>>>>
>>>>Ok, got them all 3 backed out of 2.6.7-mm7 , but that doesn't change a
>>>>thing. The JVM still dies when I try to run eclipse.
>>>
>>>I can run Eclipse without any problems on 2.6.7-bk20-ck5 + few other not
>>>related patches. Maybe try using non -mm? Try 2.6.7-bk20 and then try
>>>reverting some patches. Maybe there is some other problem in -mm that
>>>gives similar results?
>>>
>>
>>with plain 2.6.7-bk20 I see the issue, same with 2.6.7-mm7. Reverting
>>http://linux.bkbits.net:8080/linux-2.6/cset@1.1743 from -mm7 fixes the
>>issue. I'm currently building 2.6.7-bk20 minus that cset and I'll report
>>back on the results of that in a few minutes.
>>
> 
> 2.6.7-bk20 minus the cset works.
> 
> Testing with 2.6.8-rc1 and backing out one or both of the changes in the
> cset I get these results :
> 2.6.8-rc1       - vanilla                                       - breaks Java
> 2.6.8-rc1-jju1  - both changes backed out                       - works
> 2.6.8-rc1-jju2  - only first change (sys_rt_sigsuspend) applied - works
> 2.6.8-rc1-jju3  - only second change (sys_sigaltstack) applied  - breaks Java
> 
> --
> Jesper Juhl <juhl-lkml@dif.dk>

Looks like a GCC (gcc version 3.4.1 20040702 (Red Hat Linux 3.4.1-2)) 
screwup:

sys_sigaltstack:
         movl    4(%esp), %eax
         movl    8(%esp), %edx
         movl    56(%esp), %ecx
         jmp     do_sigaltstack

The offsets should be 4 more, to account for the return address on the 
stack.

--
				Brian Gerst
