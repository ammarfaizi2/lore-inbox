Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSGBHKU>; Tue, 2 Jul 2002 03:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSGBHKT>; Tue, 2 Jul 2002 03:10:19 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:54187 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S316659AbSGBHKS>; Tue, 2 Jul 2002 03:10:18 -0400
Message-Id: <200207020643.g626hZO09162@colombe.home.perso>
Date: Tue, 2 Jul 2002 08:43:32 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: [PATCH][swsusp] 2.4.19-pre10-ac2
To: pavel@ucw.cz
Cc: alan@lxorguk.ukuu.org.uk, swsusp@lister.fornax.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020630224307.GA147@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Le  1 Jul, Pavel Machek a écrit :
> +                       name_resume, cur->swh.magic.magic); /* even with a noresume option, it is better
> +                                                              to panic here, because that means that the
> +                                                              resume device is not a proper swap one. It
> +                                                              is perhaps a linux or dos partition and we
> +                                                              don't want to risk damaging it. */
> 
> Swapon seems to do its own checks, so this is red herring.

I think we need it anyway, because if we're not on a swap partition and
we have a noresume option, we may force a swap signature just after. The
point is thta this is a misconfiguration of kernel. So I think panic is
a good warning :-)

> 
> 
> 
> 
>> 3/6	Fix possible endless loop in ide-suspend stuff when using
>>  	removable devices
>> 4/6	Fix swap signature in case of noresume option
>> 5/6	Use memeat to make suspension of *big* sessions possible
>> 6/6	Clean SysRq stuff.
>>     	Clean obsolete PF_KERNTHREAD flag.
>>     	Manage kernel threads: bdflush, khubd, nfs shares (lockd,
>> rpciod), kjournald, kreiserfsd.
> 
>         sprintf(current->comm, "lockd");
> -
> +       current->flags |= PF_IOTHREAD;
> 
> Lockd does not seem any io needed for suspend-to-disk. I guess it
> would be better to freeze it.
> 
>         strcpy(current->comm, "rpciod");
> -
> +       current->flags |= PF_IOTHREAD;
> +
> 
> No, this is incorrect. I believe rpciod could submit packet for io in
> time we are freezing devices. If it does that... bye bye to your data.


I think so. At first I did freeze those two tasks but someone post a much simpler patch and... I think you're right. I'll fix that.


> 
> Fixing swap signatures should really be done in separate function.
> 
> 									Pavel
> PS: This is what I did in response to your patch (it compiles,
> otherwise untested). I'll try to fix noresume fixing signatures
> somehow.

For 2.5 tree ?

> @@ -604,13 +595,12 @@
>  
>  static int prepare_suspend_processes(void)
>  {
> -	PRINTS( "Stopping processes\n" );
> -	MDELAY(1000);
>  	if (freeze_processes()) {
> -		PRINTS( "Not all processes stopped!\n" );
> +		printk( KERN_ERR "Suspend failed: Not all processes
stopped!\n"
> );
>  		thaw_processes();
>  		return 1;
>  	}
> 
> +	MDELAY(1000);
>  	do_suspend_sync();
>  	return 0;
>  }


Where does this MDELAY come from ?

> @@ -1029,11 +1019,13 @@
>  static int resume_try_to_read(const char * specialfile, int noresume)
>  {
>  	union diskpage *cur;
> +	unsigned long scratch_page = 0;
>  	swp_entry_t next;
>  	int i, nr_pgdir_pages, error;
>  
>  	resume_device = name_to_kdev_t(specialfile);
> -	cur = (void *) get_free_page(GFP_ATOMIC);
> +	scratch_page = get_free_page(GFP_ATOMIC);
> +	cur = (void *) scratch_page;

Why doing that in two steps ?



> +	if(noresume) {
> +#if 0

I believe this is for 2.5 reasons ;-)

> +		struct buffer_head *bh;
> +		/* We don't do a sanity check here: we want to restore the swap
> +		   whatever version of kernel made the suspend image */
> +		printk("%s: Fixing swap signatures %s...\n", name_resume, resume_file);
> +		/* We need to write swap, but swap is *not* enabled so
> +		   we must write the device directly */
> +		bh = bread(resume_device, 0, PAGE_SIZE);
> +		if (!bh || (!bh->b_data)) {



--
Florent Chabaud 

