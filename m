Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUAGXbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUAGXbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:31:48 -0500
Received: from [193.138.115.2] ([193.138.115.2]:31251 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262838AbUAGXbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:31:41 -0500
Date: Thu, 8 Jan 2004 00:28:51 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
cc: Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH][RFC] variable size and signedness issues in ldt.c -
 potential problem?
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BC074AFBC9@difpst1a.dif.dk>
Message-ID: <Pine.LNX.4.56.0401080025450.9700@jju_lnx.backbone.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC074AFBC9@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replying to myself here since I just noticed one other bit in the same
file.

In read_ldt() wouldn't it make sense to move the declaration of 'bytes'
outside the for() loop?  It's initialized with "size - i" every time
through the loop just before it's used, so there really is no reason to
create the variable from scratch each time..
That's just a minor thing, the main issues are below.

/Jesper Juhl


On Thu, 8 Jan 2004, Jesper Juhl wrote:

>
> Hi,
>
> I'm hunting the kernel source for any potential problem I can find (and
> hopefully fix), and I've come across something that looks like a possible
> problem in arch/i386/kernel/ldt.c
>
> First thing that looks suspicious is this bit in read_ldt() :
>
>         for (i = 0; i < size; i += PAGE_SIZE) {
> 		...
> 	}
>
> 'i' is a plain int while 'size' is an 'unsigned long' leaving the
> possibility that if size contains a value greater than what a signed int
> can hold then this code won't do the right thing, either 'i' will wrap
> around to zero and the loop will never exit or something "unknown" will
> happen (as far as I know, what happens when an int overflows is
> implementation defined).
> The easy fix for this is to simply make 'i' an 'unsigned long' which
> prevents the posibility that 'i' will be too small and also prevents a
> signed vs unsigned comparison.
>
> The second thing is that in the body of the 'for' loop there is this
> comparison :
>
> if (bytes > PAGE_SIZE)
>
> 'bytes' is 'int', and from looking at include/asm-i386/page.h I see that
>
> #define PAGE_SHIFT      12
> #define PAGE_SIZE       (1UL << PAGE_SHIFT)
>
> so PAGE_SIZE is an 'unsigned long' utilizing 13 bits.
>
> This looks like another instance of the signed int in the comparison
> potentially being at risk of overflowing.  Yes, I'm aware that the default
> sizeof(int) on most i386 platforms is 32bits and that C requires it to
> be at least 16bits and thus that there should never be a real issue, but
> Changing it to be an 'unsigned long' type just like what it's compared
> against guarantees that there definately is no issue, and also again
> avoids a comparison between signed and unsigned values.
> This also harmonizes well with the fact that bytes is initialized by
> bytes = size - i;   and both 'size' and 'i' being 'unsigned long' values
> (assuming the change suggested above is made).
>
>
> Assuming the above analysis and conclusion makes sense, here's a patch to
> implement the conclusion (against 2.6.1-rc1-mm2) - at the very least it
> kills some warnings from gcc about signed vs unsigned comparisons when
> compiling with "-W -Wall" but I'd like to know if it also fixes a real
> potential problem :
>
>
> --- linux-2.6.1-rc1-mm2-orig/arch/i386/kernel/ldt.c	2004-01-06 01:33:04.000000000 +0100
> +++ linux-2.6.1-rc1-mm2/arch/i386/kernel/ldt.c	2004-01-07 23:28:38.000000000 +0100
> @@ -120,7 +120,8 @@ void destroy_context(struct mm_struct *m
>
>  static int read_ldt(void __user * ptr, unsigned long bytecount)
>  {
> -	int err, i;
> +	int err;
> +	unsigned long i;
>  	unsigned long size;
>  	struct mm_struct * mm = current->mm;
>
> @@ -144,7 +145,8 @@ static int read_ldt(void __user * ptr, u
>  	__flush_tlb_global();
>
>  	for (i = 0; i < size; i += PAGE_SIZE) {
> -		int nr = i / PAGE_SIZE, bytes;
> +		int nr = i / PAGE_SIZE;
> +		unsigned long bytes;
>  		char *kaddr = kmap(mm->context.ldt_pages[nr]);
>
>  		bytes = size - i;
>
>
>
> In order to "take my own medicine" and give the above patch a minimum
> amount of testing, I applied it to my own 2.6.1-rc1-mm2 tree, build the
> kernel (nothing blew up), installed the kernel and I'm currently running
> that kernel (and nothing has blown up yet).
> I realize that to test it properly I should ofcourse create a small
> program that calls modify_ldt() and exercises it a bit, but I haven't done
> so yet since I'd like some feedback first to find out if I'm off on a
> wild goose chase here...?
>
>
> there are a few other things in arch/i386/kernel/ldt.c that puzzle me.
>
> I know that the only user of read_ldt() and write_ldt() is
> sys_modify_ldt() , and the arguments for read_ldt and write_ldt thus have
> to match sys_modify_ldt, but why is the 'bytecount' argument for
> sys_modify_ldt an 'unsigned long' and the return type an 'int' ?
> The signedness of the return type makes sense given that it't supposed to
> return -1 on error. But on success, in the case where it calls read_ldt,
> it's supposed to return the actual number of bytes read. But if the
> number of bytes to read is given as an unsigned long, and the number
> actually read exceeds the size of a signed int then the return value will
> get truncated upon return - how can that be right?  And if the return
> value can never exceed what a signed int can hold, then why is it possible
> to request an unsigned long amount of bytes to read in the first place?
>
> and finally a purely style related thing (sure, call me pedantic); in both
> read_ldt() and write_ldt() 'mm' is declared as
>
> struct mm_struct * mm = current->mm;
>
> looking at the rest of ldt.c (and the kernel source in general) it seems
> to me that
>
> struct mm_struct *mm = current->mm;
>
> would be more in line with the general style... If this seems resonable
> I'll create a patch to change it - let me know.
>
>
> As you can probably deduce from the above I don't completely understand
> what's going on here, so I'd really appreciate being enlightened a bit.
>
>
> Kind regards,
>
> Jesper Juhl
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
