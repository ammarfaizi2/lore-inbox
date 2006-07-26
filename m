Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751669AbWGZPmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbWGZPmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWGZPmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:42:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:59096 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751672AbWGZPmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:42:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rm6SHi4SpPX26g+T6ZGKuiR+tWyaM4A5fSgNPYl15mdAT7oKUmu2FurwBOHw5N/3g5qHVytpgmJOfgTHElkrFb/QyO2onaGScBi/+LB7DtU9bdpLvQ/2c9acbH3PMMdvAwhOr3Nl44T7POnkDArwp2VG+fZqEHR5PZi+mjf4CEw=
Message-ID: <f96157c40607260842j478bce3ek4db1066a5f179c26@mail.gmail.com>
Date: Wed, 26 Jul 2006 15:42:18 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Michael Buesch" <mb@bu3sch.de>
Subject: Re: hwrng on 82801EB/ER (ICH5/ICH5R) fails rngtest checks
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Philipp Rumpf" <prumpf@mandrakesoft.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200607261730.31717.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060725222209.0048ed15.akpm@osdl.org>
	 <200607261649.10947.mb@bu3sch.de>
	 <f96157c40607260752h1cc2a004s8cab09ad7579677e@mail.gmail.com>
	 <200607261730.31717.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/06, Michael Buesch <mb@bu3sch.de> wrote:
> On Wednesday 26 July 2006 16:52, gmu 2k6 wrote:
> > On 7/26/06, Michael Buesch <mb@bu3sch.de> wrote:
> > > On Wednesday 26 July 2006 16:21, gmu 2k6 wrote:
> > > > it just outputs this and stops with 2.6.18-rc2-HEAD (see dmesg for hashcode or
> > > > whatever that is which is appended as localversion)
> > > >
> > > > svn:~# hexdump /dev/hwrng
> > > > 0000000 ffff ffff ffff ffff ffff ffff ffff ffff
> > > > *
> > > >
> > > > with 2.6.17.6:
> > > > svn:~# hexdump /dev/hwrng
> > > > 0000000 ffff ffff ffff ffff ffff ffff ffff ffff
> > > > *
> > > >
> > > > this was without any rng-tools installed and no rngd running of course.
> > >
> > > Hm, so I would say the hardware either broken, or intel
> > > changed the way to read the random data from it. But I doubt they
> > > would change something like this on the ICH5.
> > >
> > > Who wrote the ICH driver? Jeff? Philipp?
> > > What do you think?
> >
> > IIRC it was Jeff.
>
> "What do you think?" was more a question to Jeff or Philipp ;)
>
>
>
> But could you try the following patch on top of latest git?
> It's just a random test, but I think it's worth trying.
> Let's see if it works around the issue.
>
> Index: linux-2.6/drivers/char/hw_random/intel-rng.c
> ===================================================================
> --- linux-2.6.orig/drivers/char/hw_random/intel-rng.c   2006-06-27 17:48:13.000000000 +0200
> +++ linux-2.6/drivers/char/hw_random/intel-rng.c        2006-07-26 17:27:03.000000000 +0200
> @@ -104,9 +104,14 @@
>         int err = -EIO;
>
>         hw_status = hwstatus_get(mem);
> +       hw_status = hwstatus_set(mem, hw_status & ~INTEL_RNG_ENABLED);
> +       hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> +#if 0
> +       hw_status = hwstatus_get(mem);
>         /* turn RNG h/w on, if it's off */
>         if ((hw_status & INTEL_RNG_ENABLED) == 0)
>                 hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> +#endif
>         if ((hw_status & INTEL_RNG_ENABLED) == 0) {
>                 printk(KERN_ERR PFX "cannot enable RNG, aborting\n");
>                 goto out;

with that diff applied I still seem to get the same result:
svn:~# hexdump /dev/hwrng
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*

maybe the revision of ICH5 in this HP ProLiant box is borked (IIRC without
going down to the datacenter it should be a ProLiant 380 something bought
last year).
