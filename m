Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbSLRMuV>; Wed, 18 Dec 2002 07:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbSLRMuV>; Wed, 18 Dec 2002 07:50:21 -0500
Received: from users.linvision.com ([62.58.92.114]:28815 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S267235AbSLRMuT>; Wed, 18 Dec 2002 07:50:19 -0500
Date: Wed, 18 Dec 2002 13:57:22 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021218135722.A15645@bitwizard.nl>
References: <3DFF7399.40708@redhat.com> <Pine.LNX.4.44.0212171106210.1095-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212171106210.1095-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 11:10:20AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 17 Dec 2002, Ulrich Drepper wrote:
> >
> > But this is exactly what I expect to happen.  If you want to implement
> > gettimeofday() at user-level you need to modify the page.
> 
> Note that I really don't think we ever want to do the user-level
> gettimeofday(). The complexity just argues against it, it's better to try
> to make system calls be cheap enough that you really don't care.

I'd say that this should not be "fixed" from userspace, but from the
kernel. Thus if the kernel knows that the "gettimeofday" can be made
faster by doing it completely in userspace, then that system call
should be "patched" by the kernel to do it faster for everybody.

Next, someone might find a faster (full-userspace) way to do some
"reads"(*). Then it might pay to check for that specific
filedescriptor in userspace, and only call into the kernel for the
other filedescriptors. The idea is that the kernel knows best when
optimizations are possible.

Thus that ONE magic address is IMHO not the right way to do it. By
demultiplexing the stuff in userspace, you can do "sane" things with
specific syscalls. 

So for example, the code at 0xffff80000 would be: 
	mov 0x00,%eax
	int $80
	ret

(in the case where sysenter & friends is not available)

moving the "load syscall number into the register" into the
kernel-modifiable area does not cost a thing, but because we have
demultiplexed the code, we can easily replace the gettimeofday call by
something that (when it's easy) doesn't require the 600-cycle call 
into kernel mode. 

The "syscall _NR" would then become: 

	call	0xffff8000 + _NR * 0x80

allowing for up to 0x80 bytes of "patchup code" or "do it quickly"
code, but also for a jump to some other "magic page", that has more
extensive code.

(Oh, I'm showing a base of 0xffff8000: A bit lower than previous
suggestions: allowing for a per-syscall entrypoint, and up to 0x80
bytes of fixup or "do it really quickly" code.)

P.S. People might argue that using this large "stride" would have a
larger cache-footprint. I think that all "where it matters" programs
will have a very small working-set of system calls. It might pay to
use a stride of say 0xa0 to spread the different
system-call-code-points over different cache-lines whenever possible.

		Roger. 


(*) I was trying to pick a particularly unlikely case, but I can even
see a case where this is useful. For example, a kernel might be
compiled with "high performance pipes", which would move most of the
pipe reads and writes into userspace, through a shared-memory window. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
