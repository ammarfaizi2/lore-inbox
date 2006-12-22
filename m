Return-Path: <linux-kernel-owner+w=401wt.eu-S1423183AbWLVGzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423183AbWLVGzj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 01:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423185AbWLVGzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 01:55:39 -0500
Received: from gw.goop.org ([64.81.55.164]:35700 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423183AbWLVGzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 01:55:38 -0500
Message-ID: <458B8168.9030406@goop.org>
Date: Thu, 21 Dec 2006 22:55:36 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] ptrace: make {put,get}reg work again for gs and fs
References: <20061214225913.3338f677.akpm@osdl.org> <20061221183518.GA18827@slug> <458ADEDD.8010903@goop.org> <20061221215942.GC18827@slug>
In-Reply-To: <20061221215942.GC18827@slug>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> On Thu, Dec 21, 2006 at 11:22:05AM -0800, Jeremy Fitzhardinge wrote:
>   
>> Frederik Deweerdt wrote:
>>     
>>> Following the i386 pda patches, it's not possible to set gs or fs value
>>> from gdb anymore. The following patch restores the old behaviour of
>>> getting and setting thread.gs of thread.fs respectively.
>>> Here's a gdb session *before* the patch:
>>> (gdb) info reg
>>> [...]
>>> fs             0x33     51
>>> gs             0x33     51
>>> (gdb) set $fs=0xffff
>>> (gdb) info reg
>>> [...]
>>> fs             0x33     51
>>> gs             0x33     51
>>> (gdb) set $gs=0xffffffff
>>> (gdb) info reg
>>> [...]
>>> fs             0xffff   65535
>>> gs             0x33     51
>>>
>>> Another one *after* the patch:
>>> (gdb) info reg
>>> [...]
>>> fs             0xd8     216
>>>   
>>>       
>> This doesn't look right.  This is the kernel's %fs, not usermode's
>> (which should be 0).
>>
>>     
>>> gs             0x33     51
>>> (gdb) set $fs=0xffff
>>> (gdb) info reg
>>> [...]
>>> fs             0xffff   65535
>>> gs             0x33     51
>>> (gdb) set $gs=0xffff
>>> (gdb) info reg
>>> [...]
>>> fs             0xffff   65535
>>> gs             0xffff   65535
>>>   
>>>       
>> Hm.  This shouldn't be possible since this is a bad selector, but I
>> guess ptrace/gdb doesn't really know that.  If you run the target (even
>> single step it), these should revert to 0.
>>
>>     
> Here's a third session that looks better:
>
> (gdb) info reg
> [...]
> fs             0x0      0
> gs             0x33     51
> (gdb) set $fs=0xffff
> (gdb) info reg
> [...]
> fs             0xffff   65535
> gs             0x33     51
> (gdb) set $gs=0xffff
> (gdb) info reg
> [...]
> fs             0xffff   65535
> gs             0xffff   65535
> (gdb) n
> Single stepping until exit from function main,
> which has no line number information.
> Cannot find user-level thread for LWP 10751: generic error
> (gdb) set $gs=0x33
> (gdb) set $fs=0
> (gdb) n
> Single stepping until exit from function main,
> which has no line number information.
> 0x08048c05 in __i686.get_pc_thunk.bx ()
> (gdb) info reg
> [...]
> fs             0x0      0
> gs             0x33     51
>
> This is a -mm1 kernel + your efl_offset fix + the attached patch.
> So the problem came from putreg still saving %gs to the stack where
> there's no slot for it, whereas getreg got things right.
>
> Regards,
> Frederik
>
> Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>
>
>
> diff --git a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
> index a803a49..d8f44db 100644
> --- a/arch/i386/kernel/ptrace.c
> +++ b/arch/i386/kernel/ptrace.c
> @@ -89,14 +89,14 @@ static int putreg(struct task_struct *child,
>  	unsigned long regno, unsigned long value)
>  {
>  	switch (regno >> 2) {
> -		case FS:
> +		case GS:
>  			if (value && (value & 3) != 3)
>  				return -EIO;
> -			child->thread.fs = value;
> +			child->thread.gs = value;
>  			return 0;
>  		case DS:
>  		case ES:
> -		case GS:
> +		case FS:
>  			if (value && (value & 3) != 3)
>  				return -EIO;
>  			value &= 0xffff;
>   

This patch is good.  convert-i386-pda-code-to-use-%fs-fixes.patch
touched this same code, but it didn't actually fix the problem.

    J
