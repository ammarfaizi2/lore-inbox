Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbULGLkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbULGLkT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 06:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbULGLkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 06:40:19 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:17372 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261788AbULGLkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 06:40:06 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041207094439.GC1469@elf.ucw.cz>
References: <1102279686.9384.22.camel@tyrosine>
	 <20041205211823.GD1012@elf.ucw.cz> <1102374924.13483.9.camel@tyrosine>
	 <20041207094439.GC1469@elf.ucw.cz>
Date: Tue, 07 Dec 2004 11:39:57 +0000
Message-Id: <1102419597.13483.33.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [PATCH/RFC] Add support to resume swsusp from initrd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 10:44 +0100, Pavel Machek wrote:

> > Ok, how does this one look? (applies on top of the __init patch from
> > last time)
> 
> It looks way better than last time :-).

Excellent.

> > -
> > +extern dev_t swsusp_resume_device;
> >  
> >  static int noresume = 0;
> >  char resume_file[256] = CONFIG_PM_STD_PARTITION;
> 
> Move it to include/linux/suspend.h

swsusp_resume_device? Ok.

> > @@ -223,6 +224,18 @@
> >  
> >  	pr_debug("PM: Reading pmdisk image.\n");
> >  
> > +	if (swsusp_resume_device) {
> > +		/* We want to be really sure that userspace isn't touching
> > +		   anything at this point... */
> > +		if (freeze_processes()) {
> > +			goto Done;
> > +		}
> > +		
> > +		/* And then make sure that we have enough memory to do the
> > +		   resume */
> > +		free_some_memory();
> > +	}
> > +
> >  	if ((error = swsusp_read()))
> >  		goto Done;
> >  
> 
> This should not be conditional. 

Yeah, I wondered about that, but didn't want to change behaviour.

> > +        dev_t (res);
> 
> Why the ()s?

I have absolutely no idea. Copy and paste error, I think.

> > +        p = memchr(buf, '\n', n);
> > +        len = p ? p - buf : n;
> > +
> > +        if (sscanf(buf, "%u:%u", &maj, &min) == 2) {
> > +                res = MKDEV(maj, min);
> > +                if (maj == MAJOR(res) && min == MINOR(res)) {
> 
> You mkdev, than test that MKDEV worked? Could you add a comment why
> its needed?

That's just cut and pasted from name_to_dev_t - I assumed there was some
subtlety going on there.

> So... if userspace echos "0:0" into resume file, you attempt to do the
> resume, and oops the kernel? 

Whoops, good catch.

> Why not doing name_to_dev_t,
> unconditionally, while doing resume_setup? And probably kill
> CONFIG_PM_STD_PARTITION; I do not like idea of kernel automagically
> trying to resume without anything on command line anyway.

Ok, sounds fine.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

