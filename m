Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313114AbSDDJUO>; Thu, 4 Apr 2002 04:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313120AbSDDJUE>; Thu, 4 Apr 2002 04:20:04 -0500
Received: from daimi.au.dk ([130.225.16.1]:56927 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S313114AbSDDJTt>;
	Thu, 4 Apr 2002 04:19:49 -0500
Message-ID: <3CAC1A57.A5F2B2C1@daimi.au.dk>
Date: Thu, 04 Apr 2002 11:18:15 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Stas Sergeev <stas.orel@mailcity.com>
Subject: Re: Linux 2.4.19pre4-ac4
In-Reply-To: <E16sqjr-0004OW-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> This is to get some key fixes tested before I merge to pre5
> (and yes I know I left the ide15x3 directory in by mistake)
> 
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that prove=
> d
>    bad and was dropped out]
> 
> Linux 2.4.19pre4-ac4
> o       Fix an additional vm86 case                     (Stas Sergeev)
>         | Check DOSemu again and this code wants some good review
[...]
> 
> Linux 2.4.19pre4-ac2
> o       Hopefully correctly fix the vm86 problems       (Stas Sergeev)
>         | Please test wine 16bit/dosemu/XFree stuff
[...]
> 
> Linux 2.4.19pre3-ac6
[...]
> o       VM86 exception fixups                   (Kasper Dupont, Manfred Spraul)

I see that Stas Sergeev has been credited for some vm86 changes.
I must have missed the patches, if they were ever sent on the
mailinglist.

It seems to me, that either one hunk must have failed while
these patches got applied, or there is some confusion about the
CHECK_IF_IN_TRAP macro used in handle_vm86_fault().


Originally the CHECK_IF_IN_TRAP looked like this:
#define CHECK_IF_IN_TRAP \
        if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \
                pushw(ssp,sp,popw(ssp,sp) | TF_MASK);

With Manfreds and mine modifications of the push and pop macros
the macro had to be changed into this:
#define CHECK_IF_IN_TRAP \
        if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \
                pushw(ssp,sp,popw(ssp,sp, regs, VM86_SIGSEGV) | TF_MASK, regs, VM86_SIGSEGV);

I have always considered the macro to be unecesarry complex.
It works by poping a flagregister from the stack, changing it,
and pushing it back. In all places the macro is used, the flags
will afterwards be poped from the stack.

A simplification would be to make the change after poping the
flags. This will however make a minor change to the final result,
which is why I didn't do it right away. The value left in the
stacksegment will not have been changed with the simplified
version, but it would have with the original version. However
since the discarded value could get overwritten at any time by
an interrupt, and since any code relying on the value would be
buggy, I do consider the simplification to be safe.

In that case the macro would get to look like this:
#define CHECK_IF_IN_TRAP \
        if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \
                newflags |= TF_MASK;

This is assuming Stas' way to use the macro. However since it
looks like Stas' use the old macro, I think his code is buggy.
I think the current version will change the wrong value on the
stack, and lead to unpredictable results.

Perhaps somebody with a little more understanding of the code
could clear some of this out. And BTW does anybody happen to
know some software actually using the feature implemented by
CHECK_IF_IN_TRAP?

I would appreachiate some comments on this subject.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
