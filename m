Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUIVSzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUIVSzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 14:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUIVSzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 14:55:45 -0400
Received: from mail.aknet.ru ([217.67.122.194]:48392 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S266663AbUIVSzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 14:55:41 -0400
Message-ID: <4151CD0F.1000201@aknet.ru>
Date: Wed, 22 Sep 2004 23:05:51 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <4149D243.5050501@aknet.ru> <200409181608.18440.vda@port.imtp.ilyichevsk.odessa.ua> <414C6ABC.4030702@aknet.ru> <200409190108.45641.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409190108.45641.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Denis Vlasenko wrote:
> Maybe. This would be a complicated thing.
I bet it was! :)

> Well. Not okay. Maybe this?
> 1. We build IRET frame on ring1 stack for step 4 (see below),
>    modify IRET frame on ring0 stack so that intrs are disabled
>    and CS:EIP and SS:ESP point to values of ring1 code/stack.
Much simpler: IRET frame to return to user is
already there. Just push another one to return
to ring1 first.

> 2. IRET returns to ring1 code with dedicated *16-bit* ring1 stack
>    Upper word of ESP is wrong now, but we can safely fiddle with it.
> 3. trampoline code fixes upper word of ESP (how?)
popl %esp (as per Petr Vandrovec's suggestion)
The value on stack is carefully prepared on ring0.

> 4. trampoline IRETs to user code.
> May work.
Works!

> ring1 stacks must be per-CPU.
I allocate it on a ring0 stack. Noone seem to
suggest that. Is this flawed for some reasons?
 
>> ESP<=0xffff check - I don't think this one is
>> necessary).
> Any program which runs with 16bit stack and yet with
> ESP > 0xffff is doing something *terminally* weird.
> I think it is acceptable to leave this case unfixed.
For what? We can have that fixed so why not?

> You cannot check 16bitness of SS descriptor in two
> insns.
I do actually:
larl OLDSS(%esp), %eax
testl $0x00400000, %eax
which is exactly two insns.

Since I've forgot to CC the patch to you, I uploaded
it here:
http://www.dosemu.org/stas/linux-2.6.8-stacks2.diff
so that you (or anyone interested) can make a review.

