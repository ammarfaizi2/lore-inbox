Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSE1VMl>; Tue, 28 May 2002 17:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSE1VMk>; Tue, 28 May 2002 17:12:40 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:59548 "EHLO
	postfix2-2.free.fr") by vger.kernel.org with ESMTP
	id <S316896AbSE1VMh>; Tue, 28 May 2002 17:12:37 -0400
Message-Id: <200205282109.g4SL9on02339@colombe.home.perso>
Date: Tue, 28 May 2002 23:09:47 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: [PATCH] swsusp in 2.4.19-pre8-ac5
To: pavel@ucw.cz
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20020528195546.GC189@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28 Mai, Pavel Machek a écrit :
> Hi!
> 
>> Attached is a patch against 2.4.19-pre8-ac5 fixing some bugs and typos
>> in software suspend stuff. It should also make the whole process a lot
>> prettier on console.
>> 
>> Sorry if some of the corrections were already sent by Pavel.
> 
> No, I do not think I sent any corrections. Please original Florent's
> patch.
> 
> 								Pavel
> 
 
> Index: linux-src/include/linux/mm.h
> diff -u linux-src/include/linux/mm.h:1.1.1.1.6.1.2.3 linux-src/include/linux/mm.h:1.1.1.1.6.1.2.1.2.3
> -X-- linux-src/include/linux/mm.h:1.1.1.1.6.1.2.3	Thu May 23 11:31:49 2002
> +X++ linux-src/include/linux/mm.h	Sat May 25 16:39:22 2002
> @@ -652,6 +652,9 @@
>  #define __GFP_IO	0x40	/* Can start low memory physical IO? */
>  #define __GFP_HIGHIO	0x80	/* Can start high mem physical IO? */
>  #define __GFP_FS	0x100	/* Can call down to low-level FS? */
> +#if CONFIG_SOFTWARE_SUSPEND
> +#define __GFP_FAST	0x200	/* fast return in reschedule if out of page */
> +#endif
>  
>  #define GFP_NOHIGHIO	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
>  #define GFP_NOIO	(__GFP_HIGH | __GFP_WAIT)
> 
> It should be #if*def*, and you better drop the ifdef too as it is
> completely unneccessary.

True.

> 
>  			INTERESTING(p);
>  			if (p->flags & PF_FROZEN)
>  				continue;
> -
> +			if (p->state == TASK_STOPPED) {	/* this task is a stopped but not frozen one */
> +				p->flags |= PF_IOTHREAD;
> +				_printk("+");
> +				continue;
> +			}
>  			/* FIXME: smp problem here: we may not access other process' flags
>  			   without locking */
>  			p->flags |= PF_FREEZE;
> 
> Are you sure this is correct? What if someone wakes it just after you
> given it PF_IOTHREAD?

Good point. I need to be more precise.

> 
> What's the point of all those PRINTS -> __prints changes? I do not
> like additional abstractions on the top of printk(). Are they really
> neccessary?

Actually I tried to make the process prettier using a dedicated console.
The PRINT are for debugging, _print for the dedicated console (can be
deactivated using SUSPEND_CONSOLE) and __print are always written
(errors messages). The PRINTS PRINTR macros were used to separate
suspend and resume machine. It's not necessary but isn't that nicer when
you suspend ?

> 
> @@ -1186,9 +1202,49 @@
>  		memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
>  	else {
>  		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
> -			name_resume, cur->swh.magic.magic);
> +			name_resume, cur->swh.magic.magic); /* even with a noresume option, it is better
> +							       to panic here, because that means that the
> +							       resume device is not a proper swap one. It
> +							       is perhaps a linux or dos partition and we
> +							       don't want to risk damaging it. */
> +	}
> +	if(noresume) {
> +	  	struct buffer_head *bh;
> +				/* We don't do a sanity check here: we want to restore the swap
> +				   whatever version of kernel made the suspend image */
> +		__printr( "%s: Fixing swap signatures...\n", resume_file);
> +				/* We need to write swap, but swap is *not* enabled so
> +				   we must write the device directly */
> +		bh = bread(resume_device, 0, PAGE_SIZE);
> +		if (!bh || (!bh->b_data)) {
> +			error = -EIO;
> +			free_page((unsigned long)cur);
> +			goto resume_read_error;
> +		}
> +		if (is_read_only(bh->b_dev)) {
> +			__printr(KERN_WARNING "Can't write to read-only device %s\n",
> +				 kdevname(bh->b_dev));
> +		} else {
> +			memcpy(bh->b_data, cur, PAGE_SIZE);
> +			generic_make_request(WRITE, bh);
> +			wait_on_buffer(bh);
> +			if (buffer_uptodate(bh)) {
> +				error = 0;
> +				brelse(bh);
> +			} else {
> +				__printr(KERN_WARNING "Warning %s: Fixing swap signatures unsuccessful...\n", resume_file);		
> +				error = -EIO;
> +				bforget(bh);
> +			}
> +		}
> +		free_page((unsigned long)cur);
> +		goto resume_read_error;
>  	}
> -	printk( "%sSignature found, resuming\n", name_resume );
> +
> +	
> +	if (prepare_suspend_console())
> +		__printr( "Can't allocate a console... proceeding\n");
> +	_printr( "Signature found, resuming\n");
>  	MDELAY(1000);
>  
>  	READTO(next.val, cur);
> 
> Aiee, I guess  I want this one in 2.5. version but it is not quite
> trivial to port :-(.

The idea is to read the device exactly as in resume_try_to_read, just
restore the signature and write it back.

> 
> @@ -1207,11 +1263,12 @@
>  	pagedir_order = get_bitmask_order(nr_pgdir_pages);
>  
>  	error = -ENOMEM;
> +	free_page((unsigned long)cur);
>  	pagedir_nosave = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
>  	if(!pagedir_nosave)
>  		goto resume_read_error;
>  
> -	PRINTR( "%sReading pagedir, ", name_resume );
> +	PRINTR( "Reading pagedir\n" );
>  
>  	/* We get pages in reverse order of saving! */
>  	error=-EIO;
> 
> Why freeing it? This system is going to be overwritten, anyway.

I don't like the idea not to free the page as soon as we don't need it
any more. Maybe we'll have an error later and try to recover a normal
boot in a future version.

> 
> @@ -1277,7 +1334,7 @@
>  void software_resume(void)
>  {
>  #ifdef CONFIG_SMP
> -	printk(KERN_WARNING "Software Suspend has a malfunctioning SMP support. Disabled :(\n");
> +	__printg(KERN_WARNING "malfunctioning SMP support. Disabled :(\n");
>  #else
>  	/* We enable the possibility of machine suspend */
>  	software_suspend_enabled = 1;
> @@ -1285,10 +1342,11 @@
>  	if(!resume_status)
>  		return;
>  
> -	printk( "%s", name_resume );
>  	if(resume_status == NORESUME) {
> -		/* FIXME: Signature should be restored here */
> -		printk( "disabled\n" );
> +		PRINTG( "resuming disabled\n" );
> +		software_suspend_enabled = 0;
> +		if(resume_file[0])
> +			resume_try_to_read(resume_file,1);
>  		return;
>  	}
>  	MDELAY(1000);
> 
> I will want this one, too...
> 

What about the CONFIG_SMP restriction ? Is it still pertinent ?

--
Florent Chabaud         ___________________________________
SGDN/DCSSI/SDS/LTI     | florent.chabaud@polytechnique.org
http://www.ssi.gouv.fr | http://fchabaud.free.fr

