Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWBUXH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWBUXH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWBUXH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:07:27 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:5997 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751200AbWBUXH0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:07:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F8wpAwsZT9j5vVWhleOkzX7IV1cg8r6AoovY7vV/fONiVO8ZjTm/jG7euTjz2hS2k/YeSxrJPblphpdfpHkAmDwP45BqWbNGE/tRKM1kQbBmASB1cTIVKTEyTQJxD9B9khRDB6EyrkbWPOWz0tTLXHGkNq5gMGAldI3GQ56P66o=
Message-ID: <9a8748490602211507t26b42420s50f8e7a227f485b4@mail.gmail.com>
Date: Wed, 22 Feb 2006 00:07:25 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>, "Karsten Keil" <kkeil@suse.de>,
       "Kai Germaschewski" <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de
Subject: Re: [PATCH] ISDN: fix copy_to_user() unused result warning in isdn_ppp
In-Reply-To: <20060221230346.GA17973@pingi.kke.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602212314.15362.jesper.juhl@gmail.com>
	 <20060221230346.GA17973@pingi.kke.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/06, Karsten Keil <kkeil@suse.de> wrote:
> On Tue, Feb 21, 2006 at 11:14:15PM +0100, Jesper Juhl wrote:
> > From: Jesper Juhl <jesper.juhl@gmail.com>
> >
> >
> > Fix compile warning about copy_to_user() unused result in isdn_ppp.c
> >    drivers/isdn/i4l/isdn_ppp.c:785: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result
> >
> >
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> >
> > ---
> >
> >  drivers/isdn/i4l/isdn_ppp.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletion(-)
> >
> > --- linux-2.6.16-rc4-mm1-orig/drivers/isdn/i4l/isdn_ppp.c     2006-01-03 04:21:10.000000000 +0100
> > +++ linux-2.6.16-rc4-mm1/drivers/isdn/i4l/isdn_ppp.c  2006-02-21 23:07:57.000000000 +0100
> > @@ -782,7 +782,10 @@ isdn_ppp_read(int min, struct file *file
> >       is->first = b;
> >
> >       spin_unlock_irqrestore(&is->buflock, flags);
> > -     copy_to_user(buf, save_buf, count);
> > +     if (copy_to_user(buf, save_buf, count)) {
> > +             kfree(save_buf);
> > +             return -EFAULT;
> > +     }
> >       kfree(save_buf);
> >
> >       return count;
>
> What about:
>
> --- linux-2.6.16-rc4-mm1-orig/drivers/isdn/i4l/isdn_ppp.c     2006-01-03 04:21:10.000000000 +0100
> +++ linux-2.6.16-rc4-mm1/drivers/isdn/i4l/isdn_ppp.c  2006-02-21 23:07:57.000000000 +0100
> @@ -782,7 +782,8 @@ isdn_ppp_read(int min, struct file *file
>         is->first = b;
>
>         spin_unlock_irqrestore(&is->buflock, flags);
> -       copy_to_user(buf, save_buf, count);
> +       if (copy_to_user(buf, save_buf, count))
> +               count = -EFAULT;
>         kfree(save_buf);
>
>         return count;
>
> should result in a conditional move instead of jumps.
>

I actually considered that, but decided against it since I thought it
would be confusing use / misuse of 'count'.

Either version is fine by me. It's not likely to get hit in any case
due to the verify_area() call further up in the code.


> But I'm OK with the original patch as well, for both version you can add
>
> Signed-off-by: Karsten Keil <kkeil@suse.de>
>

Thanks.


Andrew: could you please apply either my or Karsten's version to -mm ?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
