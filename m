Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbTALVwO>; Sun, 12 Jan 2003 16:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbTALVwO>; Sun, 12 Jan 2003 16:52:14 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:1519 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S267543AbTALVwM>;
	Sun, 12 Jan 2003 16:52:12 -0500
Date: Sun, 12 Jan 2003 16:59:49 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Rob Wilkens <robw@optonline.net>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112215949.GA2392@www.kroptech.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org> <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 04:27:30PM -0500, Rob Wilkens wrote:
> On Sun, 2003-01-12 at 16:15, Matti Aarnio wrote:
> > On Sun, Jan 12, 2003 at 02:34:54PM -0500, Rob Wilkens wrote:
> > > Linus,
> > > 
> > > I'm REALLY opposed to the use of the word "goto" in any code where it's
> > > not needed.  OF course, I'm a linux kernel newbie, so I'm in no position
> > > to comment
> > 
> >     fs/open.c  file    do_sys_truncate()  function.
> > 
> > Explain how you can do that cleanly, understandably, and without
> > code duplication, or ugly kludges  without using those goto ?
> > (And sticking to coding-style.)
> 
> I've only compiled (and haven't tested this code), but it should be much
> faster than the original code.  Why?  Because we're eliminating an extra
> "jump" in several places in the code every time open would be called. 

Congratulations. You've possibly increased the speed of an error path by 
an infintessimal amount at the expense of increasing the size of kernel
image and making the code harder to read and maintain. (I say "possibly"
since with caching effects you may have actually slowed the code down.)

Harder to read: The primary code path is polluted with repetative code
that has no bearing on its primary mission.

Harder to maintain: Add an extra resource allocation near the top and
now you have to hunt out every failure case and manually update them all
(with yet more duplicate code) instead of just amending the cleanup code
at the end of the function.

>  	error = -EINVAL;
>  	if (length < 0)	/* sorry, but loff_t says... */
> -		goto out;
> +		return error;

Possibly an improvement, though there are maintenance and consistency
arguments against it.

>  	/* For directories it's -EISDIR, for other non-regulars - -EINVAL */
>  	error = -EISDIR;
> -	if (S_ISDIR(inode->i_mode))
> -		goto dput_and_out;
> +	if (S_ISDIR(inode->i_mode)){
> +		path_release(&nd);
> +		return error;
> +	}

Nope. This code is precisely what the on-error-goto method is used
to avoid.

The use of goto in the kernel surprised me the first time I saw it, too.
However, rather than hurry to point out how much more I knew about C
style than the kernel hackers, I stayed quiet and made a learning
experience of it. I suggest you do the same.

--Adam

