Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424711AbWKPVwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424711AbWKPVwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424713AbWKPVwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:52:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8383 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1424711AbWKPVwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:52:19 -0500
Date: Thu, 16 Nov 2006 22:51:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       rjw@sisk.pl, ebiederm@xmission.com, hpa@zytor.com,
       magnus.damm@gmail.com, Reloc Kernel List <fastboot@lists.osdl.org>,
       ak@suse.de
Subject: Re: [Fastboot] [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061116215154.GD6695@elf.ucw.cz>
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <20061115212411.GF9039@in.ibm.com> <20061116002836.GG9039@in.ibm.com> <20061116200933.GE13069@in.ibm.com> <20061116205313.GB5596@elf.ucw.cz> <20061116212950.GF13069@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116212950.GF13069@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Fixed the resume problem happening on my second box which supported NX
> > > protection bit. Please find attached the regenerated patch.
> > > 
> > > - Killed lots of dead code
> > 
> > Cleanup. (a)
> > 
> > > - Improve the cpu sanity checks to verify long mode
> > >   is enabled when we wake up.
> > 
> > Change. (b). I'm not sure if we really need this one. I do not think
> > replacing cpu while suspended is supported operation.
> > 
> 
> That's fine but it does not harm. Now all the entry path share the
> same sanity check (verify_cpu.S) and I believe it makes code more
> maintanable and more robust. It just makes our checks stronger in
> case somebody really replaces the cpus.

It is probably okay if shared.

> > > - Removed the need for modifying any existing kernel page table.
> > 
> > Unrelated change, probably good one. (c).
> > 
> > > - Moved wakeup_level4_pgt into the wakeup routine so we can
> > >   run the kernel above 4G.
> > 
> > The change you really wanted to do in the first place. (d).
> > 
> > > - Increased the size of the wakeup routine to 8K.
> > 
> > You want bigger stack or what? (e)
> > 
> 
> I think this is because of wakeup_level4_pgt page tables which are now
> part of trampoline. And these page tables got to be at 4K byte boundary.
> Hence now we need two pages for trampoline instead of one.

Aha, ok. Notice that in the changelog.

> > > - Renamed the variables to use the 64bit register names.
> > 
> > Cleanup. (a)
> > 
> > > - Lots of misc cleanups to match trampoline.S
> > 
> > More cleanups. (a).
> > 
> > Can we at least get (a) (b) (c) (d) and (e) separated?
> 
> Ok. I will separate the patches.

Thanks!

> > > I don't have a configuration I can test this but it compiles cleanly
> > > and it should work, the code is very similar to the SMP trampoline,
> > 
> > I assume you have configuration for test now?
> 
> Eric did not have but now I have tested it already on two configurations.
> I think that's good enough. Isn't it?

Should be... if it is in -mm for long enough. Unfortunately very
little people are testing x86-64 on notebooks :-(. I guess I should
force myself to install 64-bit distro on old arima here...

> > > -static pgd_t low_ptr;
> > > -
> > > -static void init_low_mapping(void)
> > > -{
> > > -	pgd_t *slot0 = pgd_offset(current->mm, 0UL);
> > > -	low_ptr = *slot0;
> > > -	set_pgd(slot0, *pgd_offset(current->mm, PAGE_OFFSET));
> > > -	WARN_ON(num_online_cpus() != 1);
> > > -	local_flush_tlb();
> > > -}
> > > -
> > 
> > So you no longer need identity mapping? Is not it specified that when
> > you transition between modes, you should do that while in identity
> > mapping?
> > 
> 
> I am not sure where these mappings are required at all in first place?
> While going to sleep state? While resuming we are using wake page tables
> and they already got identity mappings so it should not be an issue.

Ok, I guess that's okay.

> > > @@ -228,25 +206,10 @@ wakeup_long64:
> > >  	.align	64	
> > >  gdta:
> > >  	.word	0, 0, 0, 0			# dummy
> > > -
> > > -	.word	0, 0, 0, 0			# unused
> > > -
> > > -	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
> > > -	.word	0				# base address = 0
> > > -	.word	0x9B00				# code read/exec. ??? Why I need 0x9B00 (as opposed to 0x9A00 in order for this to work?)
> > > -	.word	0x00CF				# granularity = 4096, 386
> > > -						#  (+5th nibble of limit)
> > > -
> > > -	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
> > > -	.word	0				# base address = 0
> > > -	.word	0x9200				# data read/write
> > > -	.word	0x00CF				# granularity = 4096, 386
> > > -						#  (+5th nibble of limit)
> > > -# this is 64bit descriptor for code
> > > -	.word	0xFFFF
> > > -	.word	0
> > > -	.word	0x9A00				# code read/exec
> > > -	.word	0x00AF				# as above, but it is long mode and with D=0
> > > +	/* ??? Why I need the accessed bit set in order for this to work? */
> > > +	.quad	0x00cf9b000000ffff		# __KERNEL32_CS
> > > +	.quad	0x00af9b000000ffff		# __KERNEL_CS
> > > +	.quad	0x00cf93000000ffff		# __KERNEL_DS
> > 
> > Why this change, why did you change the values in here, and why you
> > did not tell me about it in the changelog?
> 
> I think mainly it has been modified to be consistent gdt table across
> the kernel (cpu_gdt_table, trampoline.S and wakeup.S). Now __KERNEL_32_CS
> entry has been moved up to keep the size of gdt small on trampoline. This
> change was done in patch number 7 (cleanup segments).
> 
> Seondly, I think it is just change of form from using .word to .quad. More
> compact form.
> 
> Thirdly I think it does not harm marking that gdt entry has been accessed.
> Eric can elaborate more on it. Patch 7 also has got details.

Ok. Maybe it would be nice to #include the GDT's, too, so they do not
drift apart? Or at least comment "this has to be kept in sync
with..."?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
