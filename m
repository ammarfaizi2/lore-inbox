Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290845AbSBFWUq>; Wed, 6 Feb 2002 17:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290849AbSBFWUj>; Wed, 6 Feb 2002 17:20:39 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:1360 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290845AbSBFWU1>; Wed, 6 Feb 2002 17:20:27 -0500
Date: Wed, 6 Feb 2002 17:20:25 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
Message-ID: <20020206172025.H21624@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua> <20020206101231.X21624@devserv.devel.redhat.com> <20020206132144.A29162@hq.fsmlabs.com> <a3s5gs$94v$1@cesium.transmeta.com> <20020206163118.E21624@devserv.devel.redhat.com> <3C61A8C0.7000406@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C61A8C0.7000406@zytor.com>; from hpa@zytor.com on Wed, Feb 06, 2002 at 02:05:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 02:05:52PM -0800, H. Peter Anvin wrote:
> >>b) Have the kernel provide another GDT value which can be used by the
> >>   single-threaded apps.
> >>
> > 
> > Like above, a fixed address for mmap would have to be chosen, but the
> > advantage would be that the TLS ABI would need no changing.
> > Simply kernel would add 0x33 to GDT as 4KB -> 0xc0000000 user data segment
> > and apps could put that value into %gs if not using threads.
> > 
> > But I think there is c) and d).
> > c) is just minor modification of current ldt handling in kernel, which would
> >    mean a single entry LDT (residing in task_struct) could be used instead
> >    of vmalloced one - this has the disadvantage of lldt on almost every
> >    context switch
> > d) default to a single-entry per-cpu LDT, which only non-linux personality
> >    apps and apps needing more than 1 LDT entry (threaded apps, wine/dosemu/...)
> >    would not use. Non-linux apps would use current default_ldt and those
> >    needing more than one LDT would use the current vmalloced mm private area.
> >    If a task would be using this per-cpu LDT (common case), context switch
> >    would do lldt only if previous task was not using the per-cpu LDT
> >    (unlikely) and just store task_struct->thread.ldt_word_0 and ldt_word_1
> >    into the per-cpu LDT (dunno how expensive is that, but IMHO it should be
> >    cheaper than full load_LDT).
> > 
> 
> 
> Actually d) is probably better done by allowing CPUs to put *one* entry in
> the GDT instead of requesting an LDT.  Since the LDT takes up a GDT entry
> anyway, this should be simple enough.

On UP sure, on SMP you'd need to allocate as many GDT entries as there are
CPUs and special case this in __switch_to too (something like
        loadsegment(fs, next->fs);
	if ((next->gs & 7) == 3 && next->gs >= 0x30 && next->gs < 0x30 + NR_CPUS * 8)
	  next->gs = smp_processor_id() * 8 + 0x33;
        loadsegment(gs, next->gs);
) which is kind of ugly (and userland must not save/restore %gs itself then).
Unlike d) with LDT, where unmodified glibc could work with older kernels
too, thus would mean strict kernel minimum version requirement (with LDT d)
it would be just an optimization).

	Jakub
