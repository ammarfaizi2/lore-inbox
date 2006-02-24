Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWBXVSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWBXVSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWBXVSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:18:33 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:3994 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932502AbWBXVSc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:18:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DJKIGqJpDrGARfC741xTWjfBswArDanhY3tiQktjEawkFM1BfKxamg3ENbZwUek6cITJj4J5VPlIjGE+lX6/+SMa7UNDjFUxz7kPlrnFypSXxV9KaJ6ki4dL73RE/Z9rkduS+89InbFkCBJmE/dP5Ju8uaVq7kxQ3ixtvTGrDs8=
Message-ID: <9a8748490602241318y69966ce6yc0907e89af559978@mail.gmail.com>
Date: Fri, 24 Feb 2006 22:18:31 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Zach Brown" <zab@zabbo.net>
Subject: Re: [PATCH 07/13] maestro3 vfree NULL check fixup
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200602242217.21180.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602242148.27855.jesper.juhl@gmail.com>
	 <43FF7615.8020504@zabbo.net>
	 <200602242217.21180.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On Friday 24 February 2006 22:09, Zach Brown wrote:
> > Jesper Juhl wrote:
> > > vfree() checks for NULL, no need to do it explicitly.
> >
> > >  static void free_dsp_suspendmem(struct m3_card *card)
> > >  {
> > > -   if(card->suspend_mem)
> > > -       vfree(card->suspend_mem);
> > > +    vfree(card->suspend_mem);
> > >  }
> >
> > eh, I'd just get rid of the helper and call vfree() from both sites.
> >
> makes perfect sense, I just looked for vfree use - should have checked more
> in-depth.
>
> Here's an updated patch :
>
>
>
> Don't check pointers for NULL before calling vfree and get rid
> of pointless helper function in sound/oss/maestro3.c
>
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
>
>  sound/oss/maestro3.c |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)
>
> --- linux-2.6.16-rc4-mm2-orig/sound/oss/maestro3.c      2006-02-24 19:25:49.000000000 +0100
> +++ linux-2.6.16-rc4-mm2/sound/oss/maestro3.c   2006-02-24 22:12:27.000000000 +0100
> @@ -2582,15 +2582,9 @@ static int alloc_dsp_suspendmem(struct m
>
>      return 0;
>  }
> -static void free_dsp_suspendmem(struct m3_card *card)
> -{
> -   if(card->suspend_mem)
> -       vfree(card->suspend_mem);
> -}
>
>  #else
>  #define alloc_dsp_suspendmem(args...) 0
> -#define free_dsp_suspendmem(args...)
>  #endif
>
>  /*
> @@ -2717,7 +2711,7 @@ out:
>      if(ret) {
>          if(card->iobase)
>              release_region(pci_resource_start(pci_dev, 0), pci_resource_len(pci_dev, 0));
> -        free_dsp_suspendmem(card);
> +        vfree(card);
>          if(card->ac97) {
>              unregister_sound_mixer(card->ac97->dev_mixer);
>              kfree(card->ac97);
> @@ -2760,7 +2754,7 @@ static void m3_remove(struct pci_dev *pc
>          }
>
>          release_region(card->iobase, 256);
> -        free_dsp_suspendmem(card);
> +        vfree(card);
>          kfree(card);
>      }
>      devs = NULL;
>

Arrgh, I'm an idiot. That patch is wrong.

Sorry, updated patch in 2 min.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
