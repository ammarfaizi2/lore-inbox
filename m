Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131486AbRCSOFk>; Mon, 19 Mar 2001 09:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131492AbRCSOFb>; Mon, 19 Mar 2001 09:05:31 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:59152 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131486AbRCSOFN>;
	Mon, 19 Mar 2001 09:05:13 -0500
Date: Mon, 19 Mar 2001 15:04:25 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Parity Error <bootup@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: switch_to()/doesnt %esp get replaced with %ebp on ret
Message-ID: <20010319150425.D19104@pcep-jamie.cern.ch>
In-Reply-To: <E14ezYx-000J2L-00@f6.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14ezYx-000J2L-00@f6.mail.ru>; from bootup@mail.ru on Mon, Mar 19, 2001 at 04:19:09PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's not nice code from the compiler (suboptimal), but it'll work.
leal -24(%ebp),%esp is perfectly ok in the epilogue of a function.
You're right that %esp is lost -- in this case, %ebp has effectively the
same information.

Think like this: a perfectly normal function (without switch_to) can
have this:

f: pushl %ebp
   movl %esp,%ebp
   pushl %ebx
   ... do stuff, decrement %esp a lot to call functions etc. etc. ...
   movl -4(%ebp),%esp
   popl %ebx
   popl %ebp
   ret

Parity Error wrote:
> in schedule(), switch_to() macro changes esp to
> the new process's stack. But, on exit frm schedule,
> how come it does not get overwritten with  ebp-24,
> as the dissasembled code shows. The code was compiled
> without the -fomit-frame-pointer.
> 
>         pushl 508(%ecx)
>         jmp __switch_to
> 1:      popl %ebp
>         popl %edi
>         popl %esi
> 
>         jmp .L1180
> 
> .L1180: 
> 	leal -24(%ebp),%esp
>         popl %ebx
>         popl %esi
>         popl %edi
>         movl %ebp,%esp
>         popl %ebp
>         ret
