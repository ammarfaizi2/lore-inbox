Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316837AbSGBRF3>; Tue, 2 Jul 2002 13:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSGBRF2>; Tue, 2 Jul 2002 13:05:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53008 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316837AbSGBRF1>; Tue, 2 Jul 2002 13:05:27 -0400
Date: Tue, 2 Jul 2002 19:07:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: fchabaud@free.fr
Cc: alan@lxorguk.ukuu.org.uk, swsusp@lister.fornax.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][swsusp] 2.4.19-pre10-ac2
Message-ID: <20020702170757.GD21260@atrey.karlin.mff.cuni.cz>
References: <20020630224307.GA147@elf.ucw.cz> <200207020643.g626hZO09162@colombe.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207020643.g626hZO09162@colombe.home.perso>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +                       name_resume, cur->swh.magic.magic); /* even with a noresume option, it is better
> > +                                                              to panic here, because that means that the
> > +                                                              resume device is not a proper swap one. It
> > +                                                              is perhaps a linux or dos partition and we
> > +                                                              don't want to risk damaging it. */
> > 
> > Swapon seems to do its own checks, so this is red herring.
> 
> I think we need it anyway, because if we're not on a swap partition and
> we have a noresume option, we may force a swap signature just after. The
> point is thta this is a misconfiguration of kernel. So I think panic is
> a good warning :-)

Okay.

> >> 3/6	Fix possible endless loop in ide-suspend stuff when using
> >>  	removable devices
> >> 4/6	Fix swap signature in case of noresume option
> >> 5/6	Use memeat to make suspension of *big* sessions possible
> >> 6/6	Clean SysRq stuff.
> >>     	Clean obsolete PF_KERNTHREAD flag.
> >>     	Manage kernel threads: bdflush, khubd, nfs shares (lockd,
> >> rpciod), kjournald, kreiserfsd.
> > 
> >         sprintf(current->comm, "lockd");
> > -
> > +       current->flags |= PF_IOTHREAD;
> > 
> > Lockd does not seem any io needed for suspend-to-disk. I guess it
> > would be better to freeze it.
> > 
> >         strcpy(current->comm, "rpciod");
> > -
> > +       current->flags |= PF_IOTHREAD;
> > +
> > 
> > No, this is incorrect. I believe rpciod could submit packet for io in
> > time we are freezing devices. If it does that... bye bye to your data.
> 
> 
> I think so. At first I did freeze those two tasks but someone post a much simpler patch and... I think you're right. I'll fix that.
> 

Thanks.

> > PS: This is what I did in response to your patch (it compiles,
> > otherwise untested). I'll try to fix noresume fixing signatures
> > somehow.
> 
> For 2.5 tree ?

Yep.

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

>From top of the function.

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

I do not think I can write that into one expression...

> 
> > +	if(noresume) {
> > +#if 0
> 
> I believe this is for 2.5 reasons ;-)

It will not compile; small reshuffling is needed to address this.
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
