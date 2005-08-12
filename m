Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVHLFva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVHLFva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 01:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVHLFva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 01:51:30 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:10806 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932244AbVHLFv3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 01:51:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D/Cgxi/WxA4bR+EjqZxQ0oNgfxhAQZKyAvIsn7bRY8tVhxWgUfBtYxjs9JJGeqI5mUT3f8O1e5ZhW+NQ6yP3R/LRKGhNX7VZVeAZPp6hr9z4oxcgXd0gpniX/XBEeGYc91jTn0STAW4HvQzlJno33XvSr5fmeIv041Kbs/vb0+o=
Message-ID: <86802c4405081122513625c081@mail.gmail.com>
Date: Thu, 11 Aug 2005 22:51:28 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64: Fix apicid versus cpu# confusion.
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <m1hddvwzke.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050811225445.404816000@localhost.localdomain>
	 <20050811225609.058881000@localhost.localdomain>
	 <20050811233302.GA8974@wotan.suse.de>
	 <m1hddvwzke.fsf_-_@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So boot_cpu_id is apic id of BSP.

Anyway sync_tsc(...) there is master and MASTER..., but value are all 0.

YH

On 8/11/05, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Ok being impatient not wanting this tiny bug to be forgotten for
> 2.6.13.  Linus please apply this micro patch.
> 
> > >  static void __cpuinit tsc_sync_wait(void)
> > >  {
> > >     if (notscsync || !cpu_has_tsc)
> > >             return;
> > > - printk(KERN_INFO "CPU %d: Syncing TSC to CPU %u.\n", smp_processor_id(),
> > > -                   boot_cpu_id);
> > > -   sync_tsc();
> > > +   sync_tsc(boot_cpu_id);
> >
> > I actually found a bug in this today. This should be sync_tsc(0), not
> > sync_tsc(boot_cpu_id)
> > Can you just fix it in your tree or should I submit a new patch?
> >
> > -Andi
> 
> Oops.  I knew I didn't have the physical versus logical cpu identifiers right
> when I generated that patch.  It's not nearly as bad as I feared at the time
> though.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> 
>  arch/x86_64/kernel/smpboot.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 5192895f71c7eff7e1335cd9d6a775dda2bb5d52
> diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
> --- a/arch/x86_64/kernel/smpboot.c
> +++ b/arch/x86_64/kernel/smpboot.c
> @@ -334,7 +334,7 @@ static void __cpuinit tsc_sync_wait(void
>  {
>         if (notscsync || !cpu_has_tsc)
>                 return;
> -       sync_tsc(boot_cpu_id);
> +       sync_tsc(0);
>  }
> 
>  static __init int notscsync_setup(char *s)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
