Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWGZTon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWGZTon (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWGZTon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:44:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:50753 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932394AbWGZTom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:44:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ogIj/ebNMMYE+PD/y0ZMTJtRMiGXhu/btBfh2MDm3c6vk/2K9LnE35yfVYfZJujBLi34dgJ8dLnyuREiBnA+OYyB5JmB8/k3V3ns4s+QWwPGaDrsyeldO/n7msnkE68cGdSQN8CWBWHb1ROT4ZqHUics2qznueQExGR8LeUEE4U=
Message-ID: <f96157c40607261244m205ff68dh5563c66436a2e67@mail.gmail.com>
Date: Wed, 26 Jul 2006 21:44:40 +0200
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

well as it didn't work, are you sure it was not intended to be more like this:
@@ -104,9 +104,14 @@
       int err = -EIO;

       hw_status = hwstatus_get(mem);
+       hw_status = hwstatus_set(mem, hw_status & ~INTEL_RNG_ENABLED);
+       hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
+#if 0
       /* turn RNG h/w on, if it's off */
       if ((hw_status & INTEL_RNG_ENABLED) == 0)
               hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
+#endif
       if ((hw_status & INTEL_RNG_ENABLED) == 0) {
               printk(KERN_ERR PFX "cannot enable RNG, aborting\n");
               goto out;

?
