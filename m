Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290822AbSBFVbs>; Wed, 6 Feb 2002 16:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSBFVbf>; Wed, 6 Feb 2002 16:31:35 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:52263 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290822AbSBFVbU>; Wed, 6 Feb 2002 16:31:20 -0500
Date: Wed, 6 Feb 2002 16:31:18 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
Message-ID: <20020206163118.E21624@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua> <20020206101231.X21624@devserv.devel.redhat.com> <20020206132144.A29162@hq.fsmlabs.com> <a3s5gs$94v$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a3s5gs$94v$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Feb 06, 2002 at 01:00:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 01:00:12PM -0800, H. Peter Anvin wrote:
> Uhm... none of that "expensive optimization" will help you here,
> because you need *architectural storage*.  Archtectural storage is
> always a fundamentally limited resource, regardless of how many shadow
> registers you add.
> 
> However, an x86 has a whole additional register file which is rarely
> used these days -- the segment register file.  The segment register
> file is mainly useful when the main usage is address offsetting, since
> it provides an extra input into the address adder.  For this
> particular purpose, using it is very much the sane thing to do.
> 
> As far as %gs switching is concerned, using %gs doesn't automatically
> mean using the LDT.  There are two ways you can avoid setting up LDTs
> in single-threaded apps, and still allow an ABI compatible with the
> threaded apps:
> 
> a) For single-threaded apps, define %gs == %ds.  Less than ideal for
>    several reasons, but no kernel mods needed.

This is not possible, since then %gs:0 (which is TLS base) cannot be read.
We would have to change the TLS ABI (thus become incompatible e.g. with Sun)
- note that these sequences are emitted by compiler or linker (the latter in
code transformations) and pick some hardcoded constant, say %gs:0x1000.
This would mean though that every single non-threaded app would need to
mmap a page at 4KB. If this offset was not constant, it would slow down all
TLS accesses.

> b) Have the kernel provide another GDT value which can be used by the
>    single-threaded apps.

Like above, a fixed address for mmap would have to be chosen, but the
advantage would be that the TLS ABI would need no changing.
Simply kernel would add 0x33 to GDT as 4KB -> 0xc0000000 user data segment
and apps could put that value into %gs if not using threads.

But I think there is c) and d).
c) is just minor modification of current ldt handling in kernel, which would
   mean a single entry LDT (residing in task_struct) could be used instead
   of vmalloced one - this has the disadvantage of lldt on almost every
   context switch
d) default to a single-entry per-cpu LDT, which only non-linux personality
   apps and apps needing more than 1 LDT entry (threaded apps, wine/dosemu/...)
   would not use. Non-linux apps would use current default_ldt and those
   needing more than one LDT would use the current vmalloced mm private area.
   If a task would be using this per-cpu LDT (common case), context switch
   would do lldt only if previous task was not using the per-cpu LDT
   (unlikely) and just store task_struct->thread.ldt_word_0 and ldt_word_1
   into the per-cpu LDT (dunno how expensive is that, but IMHO it should be
   cheaper than full load_LDT).

	Jakub
