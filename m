Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWDKUb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWDKUb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWDKUb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:31:56 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:44388 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751003AbWDKUbz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:31:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tRiT1Bo0iL/OEldA6Jzto/VVGf6EOryi9zGyA9VFRyhX91RbiZySAGktDSFUFKVkhW2BcWWQusdnrzMe8rEwCHQlwsPaQUyQy53R77U6+AYhY/EAcS+11aqqbUONDoJyckbzj2Wgh3BuwhqfC9yqvFgtOWSqbMvujHs0fSoEuk4=
Message-ID: <29495f1d0604111331t7741e6b2g994c234585a59af0@mail.gmail.com>
Date: Tue, 11 Apr 2006 13:31:54 -0700
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Kylene Jo Hall" <kjhall@us.ibm.com>
Subject: Re: [PATCH] tpm: update to use wait_event calls
Cc: "Andrew Morton" <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "TPM Device Driver List" <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <1144786559.12054.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1144679848.4917.15.camel@localhost.localdomain>
	 <20060410150324.4dd55994.akpm@osdl.org>
	 <1144786559.12054.15.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/06, Kylene Jo Hall <kjhall@us.ibm.com> wrote:
> On Mon, 2006-04-10 at 15:03 -0700, Andrew Morton wrote:
> >
> > > +           interruptible_sleep_on_timeout(&chip->vendor.int_queue,
> > > +                                          HZ *
> > > +                                          chip->vendor.timeout_a /
> > > +                                          1000);
> > >
> > > ...
> > >
> > > +           interruptible_sleep_on_timeout(queue, HZ * timeout / 1000);
> >
> > Please don't use the sleep_on functions.  They are racy unless (iirc) both
> > the waker and wakee are holding lock_kernel().  If the race hits, we miss a
> > wakeup.
> >
> > These should be converted to the not-racy wait_event_interruptible().
>
> Changed in this patch.
>
> Use wait_event_interruptible_timeout in place of
> interruptible_sleep_on_timeout due to its racy nature.
>
> Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
> ---
>  drivers/char/tpm/tpm_tis.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
>
> --- linux-2.6.17-rc1/drivers/char/tpm/tpm_tis.c 2006-04-11 12:18:35.573996500 -0500
> +++ linux-2.6.16-44/drivers/char/tpm/tpm_tis.c  2006-04-11 14:00:04.341229250 -0500
> @@ -95,10 +95,10 @@ static int request_locality(struct tpm_c
>                  chip->vendor.iobase + TPM_ACCESS(l));
>
>         if (chip->vendor.irq) {
> -               interruptible_sleep_on_timeout(&chip->vendor.int_queue,
> -                                              HZ *
> -                                              chip->vendor.timeout_a /
> -                                              1000);
> +               wait_event_interruptible_timeout(chip->vendor.int_queue,
> +                                                (check_locality(chip, l) >= 0),
> +                                                HZ * chip->vendor.timeout_a /
> +                                                1000);
>                 if (check_locality(chip, l) >= 0)
>                         return l;

Rather than check the condition you slept on right away, couldn't you
just store the return value of wait_event_interruptible_timeout()? If
it's positive, the condition should be true, if it's negative, then
you got a signal, if it's 0, then you timed out. Same would go for the
other change.

Thanks,
Nish
