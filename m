Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312930AbSDGC4p>; Sat, 6 Apr 2002 21:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312937AbSDGC4p>; Sat, 6 Apr 2002 21:56:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52281 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312930AbSDGC4o>; Sat, 6 Apr 2002 21:56:44 -0500
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
In-Reply-To: <1759496962.1018114339@[10.10.2.3]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Apr 2002 19:50:07 -0700
Message-ID: <m18z80nrxc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <Martin.Bligh@us.ibm.com> writes:

> >> 2. Things that are reset by reboot that we don't reset during
> >> normal kernel boot?
> > 
> > A sane BIOS will toggle the board level reset line on reboot.
> > The all don't but that makes it look like a fresh boot, with
> > a negligible speed penalty.
> 
> I know that, but what I mean is that I'm *not* going to get
> this reset if I just jump back to the init point ... I was
> trying to work out what kind of trouble that would cause.

I didn't mean to obfuscate the issue.  There is some trouble you can
get into, but most of it is when asking the BIOS to do things for
you.  Beyond that there a few rare devices that the kernel doesn't
reset right.  Turning off bus master is the primary issue.  There
is work in the linux power management infrastructure that will handle
most of this long term.


> > Seriously check out my code it should just work unless there are 
> 
> OK, I took a very brief scan of just the descriptions of your
> patches - looks like the main thing you're doing is creating
> a 32 bit kernel entry point, right? So above and beyond that
> I'd have to rework the LILO code to work in 32 bit, which 
> probably isn't that hard now I think about it ... all the hard
> stuff is actually done by the command line binary, so maybe ...

Sorry wrong set of patches.  I'm not pushing my kexec stuff quite as
hard.  It is a little lower on my priority list.  Basically the work
is to allow Linux to boot Linux directly.

ftp://download.lnxi.com/pub/src/linux-kernel-patches/linux-2.5.7.kexec.diff
ftp://download.lnxi.com/pub/src/linux-kernel-patches/kexec-2.5.7.kexec.log
ftp://download.lnxi.com/pub/src/mkelfImage/elfboottools-2.0.tar.gz
      type make and see objdir/build/sbin/kexec (work with bzImages)

The basic kernel interface that is added is:

struct segment {
        void *buffer;
        void *dest_addr;
        size_t len;
};
int kexec(void *start, int nr_segments, struct segment *segments);

This appears to be an interface I can support on every linux platform.
it works on x86, and I have a proof of concept alpha port.

The initial transfer of control happens on the bootstrap processor, in
32bit protected mode with paging disabled.  All of the segment
registers are set to a flat 32bit segment with a base address of zero.
And %esp points to an area that is good for a small stack.

The rest is left up the controlling program.  The major discussion
with this happened a while ago.  There was a basic agreement on what
the system call interface should look like, but it really hasn't
progressed much since then.  There are not a lot of booting experts I
can bang heads with :)

> > special apic shutdown rules for NUMAQ machines.
> 
> The APICs should be OK ... the interconnect firmware sets them
> up, and Linux never changes them, so everything *should* be OK
> in theory. Of course if it ever gets screwed up, reboot won't
> fix it, but then I can't reboot at all right now, so ... ;-)

I have code in there to fix things of for the SMP case, you might want
to double check that doesn't mess up the NUMAQ case.
 
> On the other hand, I don't reset the processors fully (I have
> to use NMI to boot rather than the INIT, INIT, STARTUP sequence),
> which seems to be asking for trouble ;-(

Well even the INIT assert, INIT deassert, STARTUP sequence doesn't
reset the processors fully.  Things like the MTRR's remain setup so
I wouldn't worry about it to much.  Assuming the NMI can reliably
get the processor to a kernel entry point.

Eric
