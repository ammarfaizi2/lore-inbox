Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWGKIlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWGKIlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWGKIlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:41:00 -0400
Received: from 25.mail-out.ovh.net ([213.186.37.103]:18314 "EHLO
	25.mail-out.ovh.net") by vger.kernel.org with ESMTP
	id S1750753AbWGKIk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:40:58 -0400
Message-ID: <1152607247.44b3640f95bc0@ssl0.ovh.net>
Date: Tue, 11 Jul 2006 10:40:47 +0200
From: Samuel Ortiz <samuel@sortiz.org>
To: Luke Yang <luke.adi@gmail.com>, David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]resend: unaligned access in irda protocol stack
References: <489ecd0c0607102018k27890417mfdde8e112b22c48a@mail.gmail.com>
In-Reply-To: <489ecd0c0607102018k27890417mfdde8e112b22c48a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 192.100.124.218
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Luke Yang <luke.adi@gmail.com>:

>   The "hints" member aligns at the third byte of a word, an odd
> address. So if we visit "hints" as a short in irlmp.c and discorery.c:
>
>    u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
>
>  will cause alignment problem on some machines. Architectures with
> strict alignment rules do not allow 16-bit read on an odd address.
>
> Signed-off-by: Luke Yang <luke.adi@gmail.com>
> Acked-by: David Miller <davem@davemloft.net>
Acked-by: Samuel Ortiz <samuel@sortiz.org>

Dave, I can add this patch to my IrDA queue, unless you want to apply it
immediatly.

Cheers,
Samuel.


>  discovery.c |    5 +++--
>  irlmp.c     |    7 ++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/net/irda/discovery.c b/net/irda/discovery.c
> index 3fefc82..5ddf3e5 100644
> --- a/net/irda/discovery.c
> +++ b/net/irda/discovery.c
> @@ -38,6 +38,7 @@ #include <net/irda/irda.h>
>  #include <net/irda/irlmp.h>
>
>  #include <net/irda/discovery.h>
> +#include <asm/unaligned.h>
>
>  /*
>   * Function irlmp_add_discovery (cachelog, discovery)
> @@ -86,7 +87,7 @@ void irlmp_add_discovery(hashbin_t *cach
>                          */
>                         hashbin_remove_this(cachelog, (irda_queue_t *) node);
>                         /* Check if hints bits are unchanged */
> -                       if(u16ho(node->data.hints) == u16ho(new->data.hints))
> +                       if(get_unaligned(node->data.hints) ==
> get_unaligned(new->data.hints))
>                                 /* Set time of first discovery for this node
> */
>                                 new->firststamp = node->firststamp;
>                         kfree(node);
> @@ -280,7 +281,7 @@ struct irda_device_info *irlmp_copy_disc
>                 /* Mask out the ones we don't want :
>                  * We want to match the discovery mask, and to get only
>                  * the most recent one (unless we want old ones) */
> -               if ((u16ho(discovery->data.hints) & mask) &&
> +               if ((get_unaligned(discovery->data.hints) & mask) &&
>                     ((old_entries) ||
>                      ((jiffies - discovery->firststamp) < j_timeout)) ) {
>                         /* Create buffer as needed.
> diff --git a/net/irda/irlmp.c b/net/irda/irlmp.c
> index 129ad64..ee74f73 100644
> --- a/net/irda/irlmp.c
> +++ b/net/irda/irlmp.c
> @@ -42,7 +42,6 @@ #include <net/irda/irlap.h>
>  #include <net/irda/iriap.h>
>  #include <net/irda/irlmp.h>
>  #include <net/irda/irlmp_frame.h>
> -
>  #include <asm/unaligned.h>
>
>  static __u8 irlmp_find_free_slsap(void);
> @@ -1063,7 +1062,7 @@ void irlmp_discovery_expiry(discinfo_t *
>                 for(i = 0; i < number; i++) {
>                         /* Check if we should notify client */
>                         if ((client->expir_callback) &&
> -                           (client->hint_mask.word &
> u16ho(expiries[i].hints)
> +                           (client->hint_mask.word &
> get_unaligned(expiries[i].hints)
>                              & 0x7f7f) )
>                                 client->expir_callback(&(expiries[i]),
>                                                        EXPIRY_TIMEOUT,
> @@ -1083,11 +1082,13 @@ void irlmp_discovery_expiry(discinfo_t *
>   */
>  discovery_t *irlmp_get_discovery_response(void)
>  {
> +       __u16 *data_hintsp;
>         IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
>
>         IRDA_ASSERT(irlmp != NULL, return NULL;);
>
> -       u16ho(irlmp->discovery_rsp.data.hints) = irlmp->hints.word;
> +       data_hintsp = (__u16 *) irlmp->discovery_rsp.data.hints;
> +       put_unaligned(irlmp->hints.word, data_hintsp);
>
>         /*
>          *  Set character set for device name (we use ASCII), and
>
>
> --
> Best regards,
> Luke Yang
> luke.adi@gmail.com
>


-- 
Samuel Ortiz
samuel@sortiz.org
http://www.sortiz.org
Phone: (+358)-504-868-344
