Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWJKKsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWJKKsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 06:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWJKKsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 06:48:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:18423 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751177AbWJKKsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 06:48:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G3B2y/AWwsdEH8SdE51bOYsn4R7m56CZwvjzLcY+P4wCh71t957m/LhCOQhcXXm4IpNvBEvU+ke2lrBMP/dgiY609TSvl7pxBJyuzNH8feDMW82AaSplIab+6mSaUXS9anwLAJHoF2CQZvPm7nx/nzSR0Jr63MTkjCXEFtSRHDo=
Message-ID: <6bffcb0e0610110348i1d3fc15qa0c57a6586aca3e@mail.gmail.com>
Date: Wed, 11 Oct 2006 12:48:20 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: 2.6.19-rc1-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, "Pavel Machek" <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <17708.33450.608010.113968@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
	 <6bffcb0e0610100704m32ccc6bakb446671f04b04c2b@mail.gmail.com>
	 <17708.33450.608010.113968@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/06, Neil Brown <neilb@suse.de> wrote:
> On Tuesday October 10, michal.k.k.piotrowski@gmail.com wrote:
> > On 10/10/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > Hi,
> > >
> > > On 10/10/06, Andrew Morton <akpm@osdl.org> wrote:
> > > >
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> > > >
> > >
> > > Kernel 2.6.19-rc1-mm1 + Neil's avoid_lockdep_warning_in_md.patch
> > > (http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0642.html)
> > >
> > > (I'll try to reproduce this without Neil's patch).
> >
> > I can't reproduce this without Neil's patch.
> >
>
> Despite this circumstantial evidence, I don't see how my patch could
> possible have an effect here....
>
> Looking at the code, starting at _cpu_down in the CONFIG_HOTPLUG_CPU
> case, the call notifier chain 'cpu_chain' contains
> workqueue_cpu_callback which does 'mutex_lock(&workqueue_mutex)' in
> the "DOWN_PREPARE" case and mutex_unlock(&workqueue_mutex) in the
> DOWN_FAILED and DEAD cases.
>
> blocking_notifier_call_chain is
>         down_read(&nh->rwsem);
>         ret = notifier_call_chain(&nh->head, val, v);
>         up_read(&nh->rwsem);
>
> and so holds ->rwsem while calling the callback.
> So the locking sequence ends up as:
>
>  down_read(&cpu_chain.rwsem);
>  mutex_lock(&workqueue_mutex);
>  up_read(&cpu_chain.rwsem);
>
>  down_read(&cpu_chain.rwsem);
>  mutex_unlock(&workqueue_mutex);
>  up_read(&workqueue_mutex);
>
> and lockdep doesn't seem to like this.  It sees workqueue_mutex
> claimed while cpu_chain.rwsem is held. and then it sees
> cpu_chain.rwsem claimed while workqueue_mutex is held, which looks a
> bit like a class ABBA deadlock.
> Of course because it is a 'down_read' rather than a 'down', it isn't
> really a dead lock.
>
> I don't know how to tell lockdep to do the right thing, but I'll leave
> that up to Ingo et al.
>
> Why it didn't trigger without my patch I cannot imagine.  Are you sure
> the config was identical (you didn't remove CONFIG_HOTPLUG_CPU or
> anything did you?).

No, I didn't remove CONFIG_HOTPLUG_CPU or anything else.

I didn't do enough testing - only a few hibernatins.

>
> NeilBrown
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
