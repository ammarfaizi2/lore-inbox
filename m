Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317989AbSGWH5q>; Tue, 23 Jul 2002 03:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317988AbSGWH5q>; Tue, 23 Jul 2002 03:57:46 -0400
Received: from [195.39.17.254] ([195.39.17.254]:8064 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317989AbSGWH5n>;
	Tue, 23 Jul 2002 03:57:43 -0400
Date: Tue, 23 Jul 2002 09:59:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: fchabaud@free.fr
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][swsusp] 2.4.19-pre10-ac2
Message-ID: <20020723075940.GD116@elf.ucw.cz>
References: <20020630224307.GA147@elf.ucw.cz> <200207020643.g626hZO09162@colombe.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207020643.g626hZO09162@colombe.home.perso>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, this is incorrect. I believe rpciod could submit packet for io in
> > time we are freezing devices. If it does that... bye bye to your data.
> 
> 
> I think so. At first I did freeze those two tasks but someone post a much simpler patch and... I think you're right. I'll fix that.
> 

Mail me a patch when you have that.

> > Fixing swap signatures should really be done in separate function.
> > 
> > 									Pavel
> > PS: This is what I did in response to your patch (it compiles,
> > otherwise untested). I'll try to fix noresume fixing signatures
> > somehow.
> 
> For 2.5 tree ?

Yep. [Actually noresume fixing signatures is harder than I expected.]

> > @@ -604,13 +595,12 @@
> >  
> >  static int prepare_suspend_processes(void)
> >  {
> > -	PRINTS( "Stopping processes\n" );
> > -	MDELAY(1000);
> >  	if (freeze_processes()) {
> > -		PRINTS( "Not all processes stopped!\n" );
> > +		printk( KERN_ERR "Suspend failed: Not all processes
> stopped!\n"
> > );
> >  		thaw_processes();
> >  		return 1;
> >  	}
> > 
> > +	MDELAY(1000);
> >  	do_suspend_sync();
> >  	return 0;
> >  }
> 
> 
> Where does this MDELAY come from ? 

>From right above.

> > @@ -1029,11 +1019,13 @@
> >  static int resume_try_to_read(const char * specialfile, int noresume)
> >  {
> >  	union diskpage *cur;
> > +	unsigned long scratch_page = 0;
> >  	swp_entry_t next;
> >  	int i, nr_pgdir_pages, error;
> >  
> >  	resume_device = name_to_kdev_t(specialfile);
> > -	cur = (void *) get_free_page(GFP_ATOMIC);
> > +	scratch_page = get_free_page(GFP_ATOMIC);
> > +	cur = (void *) scratch_page;
> 
> Why doing that in two steps ?

So we can free scratch_page without ugly casts.

> > +	if(noresume) {
> > +#if 0
> 
> I believe this is for 2.5 reasons ;-)

Yes.
								Pavel
PS: Killed Alan from Cc, he reads lists anyway and I guess he's not
so much interested.
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
