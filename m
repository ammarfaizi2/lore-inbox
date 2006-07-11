Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWGKCMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWGKCMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 22:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWGKCMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 22:12:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20105 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965075AbWGKCMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 22:12:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=osXmEwe45o7MJLxz7uIJVMy3fEF73EhzV15oHxkGAvFxz9mmVQw0rFoA7j/LEJLWRucPMPzWZV7wyRaCwpazObxrkheAjagKFM8vnJgCXsvxnrQ2gzGvifxRafFfdE96mwk/FT+9/jyexPGhGXK53Hdh2Am0ALTjvbTWLg3tx00=
Message-ID: <489ecd0c0607101912t4225e551sa608faa769f09064@mail.gmail.com>
Date: Tue, 11 Jul 2006 10:12:41 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Fix an inproper alignment accessing in irda protocol stack
Cc: samuel@sortiz.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060617.221435.48805608.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0606080015v4815d0f3wa3d28c564eaf6885@mail.gmail.com>
	 <489ecd0c0606131929l5311bdb9g1e903904f0d8fb2b@mail.gmail.com>
	 <20060617.221435.48805608.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  There is another same unaligend issue in irda stack to be fixed:

Signed-off-by: Luke Yang <luke.adi@gmail.com>

--- linux-2.6.x/net/irda/discovery.c    2006-03-22 18:32:37.000000000 +0800
+++ ../../uClinux-dist/linux-2.6.x/net/irda/discovery.c 2006-06-30
18:07:46.000000000 +0800
@@ -38,6 +38,7 @@
 #include <net/irda/irlmp.h>

 #include <net/irda/discovery.h>
+#include <asm/unaligned.h>

 /*
  * Function irlmp_add_discovery (cachelog, discovery)
@@ -86,7 +87,7 @@
                         */
                        hashbin_remove_this(cachelog, (irda_queue_t *) node);
                        /* Check if hints bits are unchanged */
-                       if(u16ho(node->data.hints) == u16ho(new->data.hints))
+                       if(get_unaligned(node->data.hints) ==
get_unaligned(new->data.hints))
                                /* Set time of first discovery for this node */
                                new->firststamp = node->firststamp;
                        kfree(node);
@@ -280,7 +281,7 @@
                /* Mask out the ones we don't want :
                 * We want to match the discovery mask, and to get only
                 * the most recent one (unless we want old ones) */
-               if ((u16ho(discovery->data.hints) & mask) &&
+               if ((get_unaligned(discovery->data.hints) & mask) &&
                    ((old_entries) ||
                     ((jiffies - discovery->firststamp) < j_timeout)) ) {
                        /* Create buffer as needed.


Regards,
Luke Yang

On 6/18/06, David Miller <davem@davemloft.net> wrote:
> From: "Luke Yang" <luke.adi@gmail.com>
> Date: Wed, 14 Jun 2006 10:29:19 +0800
>
> > --- net/irda/irlmp.c.old        2006-06-08 14:49:20.000000000 +0800
> > +++ net/irda/irlmp.c    2006-06-14 10:00:22.000000000 +0800
> > @@ -849,7 +849,10 @@
> >         }
> >
> >         /* Construct new discovery info to be used by IrLAP, */
> > -       u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
> > +       irlmp->discovery_cmd.data.hints[0] = \
> > +               le16_to_cpu(irlmp->hints.word) & 0xff;
> > +       irlmp->discovery_cmd.data.hints[1] = \
> > +               (le16_to_cpu(irlmp->hints.word) & 0xff00) >> 8;
> >
> >         /*
> >          *  Set character set for device name (we use ASCII), and
>
> I decided in the end to fix this differently.
>
> We have a portable unaligned access interface, via get_unaligned() and
> put_unaligned() in asm/unaligned.h, which makes sure there is no
> penalty for platforms whose cpu does unaligned memory accesses
> transparently.
>
> diff --git a/net/irda/irlmp.c b/net/irda/irlmp.c
> index c19e9ce..57ea160 100644
> --- a/net/irda/irlmp.c
> +++ b/net/irda/irlmp.c
> @@ -44,6 +44,8 @@
>  #include <net/irda/irlmp.h>
>  #include <net/irda/irlmp_frame.h>
>
> +#include <asm/unaligned.h>
> +
>  static __u8 irlmp_find_free_slsap(void);
>  static int irlmp_slsap_inuse(__u8 slsap_sel);
>
> @@ -840,6 +842,7 @@ void irlmp_do_expiry(void)
>  void irlmp_do_discovery(int nslots)
>  {
>         struct lap_cb *lap;
> +       __u16 *data_hintsp;
>
>         /* Make sure the value is sane */
>         if ((nslots != 1) && (nslots != 6) && (nslots != 8) && (nslots != 16)){
> @@ -849,7 +852,8 @@ void irlmp_do_discovery(int nslots)
>         }
>
>         /* Construct new discovery info to be used by IrLAP, */
> -       u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
> +       data_hintsp = (__u16 *) irlmp->discovery_cmd.data.hints;
> +       put_unaligned(irlmp->hints.word, data_hintsp);
>
>         /*
>          *  Set character set for device name (we use ASCII), and
>


-- 
Best regards,
Luke Yang
luke.adi@gmail.com
