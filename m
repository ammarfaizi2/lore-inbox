Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSJ1QvS>; Mon, 28 Oct 2002 11:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSJ1QvS>; Mon, 28 Oct 2002 11:51:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3639 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261346AbSJ1QvR>; Mon, 28 Oct 2002 11:51:17 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] 2.5.44 bootloader fix
References: <m1pttxlebr.fsf@frodo.biederman.org>
	<apeuvi$t5k$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Oct 2002 09:55:07 -0700
In-Reply-To: <apeuvi$t5k$1@cesium.transmeta.com>
Message-ID: <m1d6pujyfo.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <m1pttxlebr.fsf@frodo.biederman.org>
> By author:    ebiederm@xmission.com (Eric W. Biederman)
> In newsgroup: linux.dev.kernel
> > 
> > What I am proposing is an interface change.  The only known bootloader
> > this does not fix is gujin and the fix of loading segments earlier is
> > trivial, and fully backwards compatible.  The advantage of this patch
> > is that no future changes to the kernel's gdt will affect bootloaders.
> > 
> 
> Please detail how the interface changes.  It is not at all clear from
> the code.

I believe I said this but quite possibly not clear enough.  
-  In the supported entry points the GDT that code32_start is using
   is visible.  With current 2.5.current KERNEL_CS && KERNEL_DS are no
   longer 0x10 and 0x18.

-  A segment value remains valid from the time you load it from the
   GDT until the segment is reloaded.   Even if a completely different
   GDT is loaded.

-  Using the persistence of segment registers, the code in setup.S
   should load all the segments %cs, %ds, %es, %fs, %gs, %ss with
   segments that have a limit of 4GB and a base of 0.  The rest of the
   kernel should not reload those segments.   This keeps the values
   used private to setup.S, and in doing so keeps requirements in
   other parts of the kernel from affecting the boot code.

-  code32_start is a special case.  It is part of the documented and
   deliberately exported kernel interface.  So code it calls is safe
   to assume segment selectors of 0x10 and 0x18 are safe to load.
   The new requirement is that when the code32_start hooks returns
   to the rest of the kernel no other segment selector values be
   loaded.  Currently this is only legal by loading another GDT,
   changing all of the segment registers, and reloading the current
   gdt.  And as far as I know no boot loader actually does this.

-  I hope to use the decoupling of assumptions to have a stable 32bit
   kernel entry point.  Allowing other Decompressors besides gzip.
   Allowing the kernel to have alternatives to setup.S.  In a
   supported manner.  But except for explaining my motivations,
   this has no real relevance on this patch.  The patch stands on it's
   own to fix the current problem with 2.5.x kernels.  And to clean up
   the boot path in head.S so it is readable.
   
> > @@ -101,7 +96,8 @@
> >  	popl %eax	# hcount
> >  	movl $0x100000,%edi
> >  	cli		# make sure we don't get interrupted
> > -	ljmp $(__KERNEL_CS), $0x1000 # and jump to the move routine
> > +	movl $0x1000, %ebp
> > +	jmpl *%ebp	# and jump to the move routine
> >  
> >  /*
> >   * Routine (template) for moving the decompressed kernel in place,
> 
> Why are you avoiding to set __SETUP_CS here?

- Because reloading the segment register is unnecessary and slow.
- Because that means only setup.S cares about what it segment
  registers are.

Eric
