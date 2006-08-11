Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWHKNev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWHKNev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWHKNev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:34:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:49320 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750841AbWHKNeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:34:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IIBdYZF6CgW9UWTPMqdQzPfqNm4j36nrLmRr9pZ6PUedSavwfUhXuERtD2uBYLcCLpvVroBE4g3cMFBl4yViWIYfMrQUzeOIkyksuwuiAYxJamlgKjf95tvzhafxR5DnEcvTBSDGWyJ+4ImlevfUp56BVB3NshvK4W+eLrEvsPQ=
Message-ID: <d120d5000608110634n501d33b0yb7702a24cbf064e3@mail.gmail.com>
Date: Fri, 11 Aug 2006 09:34:44 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [patch 5/6] Convert to use mutexes instead of semaphores
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Michael Hanselmann" <linux-kernel@hansmi.ch>,
       "Antonino A. Daplas" <adaplas@pol.net>
In-Reply-To: <1155302169.19959.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060811050310.958962036.dtor@insightbb.com>
	 <20060811050611.530817371.dtor@insightbb.com>
	 <d120d5000608110558l3d3a5720i1781f4e90f40579b@mail.gmail.com>
	 <1155302169.19959.16.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> On Fri, 2006-08-11 at 08:58 -0400, Dmitry Torokhov wrote:
> > On 8/11/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > > Backlight: convert to use mutexes instead of semaphores
> > >
> >
> > Apparently I missed that several drivers also use bd->sem so they need
> > to be converted too... But what is it with the drivers:
> >
> > static void aty128_bl_set_power(struct fb_info *info, int power)
> > {
> >         mutex_lock(&info->bl_mutex);
> >         up(&info->bl_dev->sem);
> >         info->bl_dev->props->power = power;
> >         __aty128_bl_update_status(info->bl_dev);
> >         down(&info->bl_dev->sem);
> >         mutex_unlock(&info->bl_mutex);
> > }
> >
> > Why we are doing up() before down()??? And it is in almost every
> > driver that uses backlight... Do I need more coffee? [CC-ing bunch of
> > people trying to get an answer...]
>
> It looks totally wrong.
>

Ok, so that is not only me seeing things ;)

> In the archives, there are a number of comments from me questioning
> whether that driver needs to touch bl_dev->sem anyway (esp. given the
> mutex as well). I never did find out what it was trying to protect
> against...

I think it is prudent to protect assess to these data structures. For
example, it could possibly race with setting power through sysfs
attribute. Now for this particular driver the race window is
non-existent for all practical purposes, but it looks like atyfb_base
might be needig it (of course currentimplementation not only have
up/down mixed but also has AB-BA deadlock).

How about we add backlight_set_power(&bd, power) to the backlight core
to take care of proper locking for drivers?

-- 
Dmitry
