Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284358AbRLCIvp>; Mon, 3 Dec 2001 03:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284372AbRLCIto>; Mon, 3 Dec 2001 03:49:44 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:39103 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284592AbRLCBn7>; Sun, 2 Dec 2001 20:43:59 -0500
Date: Sun, 2 Dec 2001 18:44:00 -0700
Message-Id: <200112030144.fB31i0Q16183@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] wait_for_devfsd_finished deadlock
In-Reply-To: <20011202173408.A866@holomorphy.com>
In-Reply-To: <20011201191113.A1034@holomorphy.com>
	<200112021901.fB2J1wM11465@vindaloo.ras.ucalgary.ca>
	<20011202173408.A866@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin, III writes:
> On Sun, Dec 02, 2001 at 12:01:58PM -0700, Richard Gooch wrote:
> > Your sh process appears to be hung in wait_for_devfsd_finished(). It
> > would be helpful to know what devfsd was doing at this time. If it
> > were hung internally (in user-space), it would account for this
> > behaviour. However, if devfsd crashes, then devfsd_close() will be
> > called, which will wake any waiters.
> 
> A oops trace from quite a bit further back in my logs makes this
> appear to be an instance of an already reported problem. I apologize
> for overlooking this detail in my prior post:

You're referring to the problem reported by Pierre Rousselet?

> Dec  1 16:49:11 holomorphy kernel:  printing eip:
> Dec  1 16:49:11 holomorphy kernel: c016536d
> Dec  1 16:49:11 holomorphy kernel: Oops: 0002
> Dec  1 16:49:11 holomorphy kernel: CPU:    0
> Dec  1 16:49:11 holomorphy kernel: EIP:    0010:[devfs_put+13/192]    Not tainte
> d
> Dec  1 16:49:11 holomorphy kernel: EFLAGS: 00010206
> Dec  1 16:49:11 holomorphy kernel: eax: 5a5a5a5a   ebx: 5a5a5a5a   ecx: 00000002
>    edx: 5a5a5a5a
> Dec  1 16:49:11 holomorphy kernel: esi: 00000000   edi: 00000026   ebp: 00000000
>    esp: ef785f40
> Dec  1 16:49:11 holomorphy kernel: ds: 0018   es: 0018   ss: 0018
> Dec  1 16:49:11 holomorphy kernel: Process devfsd (pid: 20, stackpage=ef785000)
> Dec  1 16:49:12 holomorphy kernel: Stack: 00000026 c01680dc 5a5a5a5a c1ca8d74 ffffffea 00000000 00000420 c1cc4800 
> Dec  1 16:49:12 holomorphy kernel:        c02a2a00 ef653308 5a5a5a5a 000003fa 00
> 000000 00000000 00000001 00000000 
> Dec  1 16:49:12 holomorphy kernel:        ef784000 00000000 00000000 00000000 ef
> 784000 c02a2a2c c02a2a2c c0130bd6 
> Dec  1 16:49:12 holomorphy kernel: Call Trace: [devfsd_read+860/992] [sys_read+1
> 50/208] [system_call+51/56] 
> Dec  1 16:49:12 holomorphy kernel: 
> Dec  1 16:49:12 holomorphy kernel: Code: ff 4b 04 0f 94 c0 84 c0 0f 84 9d 00 00 
> 00 3b 1d d8 1b 30 c0 
> 
> 
> On Sun, Dec 02, 2001 at 12:01:58PM -0700, Richard Gooch wrote:
> > Are these related?
> > cron		->	pipe_wait()
> > procmail	->	interruptible_sleep_on_locked()
> > exim		->	sys_wait4()
> 
> > Maybe these are just waiting on mutt(1)?
> 
> I don't believe so. In my configuration, exim delivers to a file
> through a procmail pipe, and to the best of my knowledge, mutt does
> little more than monitor the files with poll or select, which should
> not interfere with the completion of their operations. cron should
> be entirely unrelated, as no mail-related activities are scheduled
> with it.

Odd, especially cron. My version of crond doesn't seem to look in /dev
at all.

> I suspect in the case I reported, the destruction of the devfsd thread
> is responsible for the deadlocks.

That would make sense. If devfsd gets an Oops, the release() method
won't be called, thus no waiters will be woken up. So it looks like
this is the same problem that Pierre reported. So now I'm going to ask
you for debugging help as well. The information I have from Pierre so
far hasn't led me to inspiration.

So, I want to see your complete kernel logs, booted with "devfs=dall"
and make sure you've compiled with:
CONFIG_DEVFS_DEBUG=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_BUGVERBOSE=y

I don't remeber what kernel this was, but I'd prefer if you can
test/reproduce this with 2.4.17-pre2.

I'll also want lsmod output, your devfsd configuration and your
complete .config. Just send it to me only: no need to spam the list
with all this detail.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
