Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVLQClL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVLQClL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 21:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVLQClL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 21:41:11 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:5236 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751359AbVLQClJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 21:41:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FJXhm4zM8HKi4vw2bXIbHxu5/LXFxAM7zzDN2RRkC1LNmhFd7PLtoRdQWYLOQTBG3AvxJZVL5m4MlZ6oGjNC2+zKAJeKLjF79gYikjUxL4Jem8vwS3KXazpSoPFFWPuOrnZRxdxg8sIV2FmZ7y8CukATizfpO+Yx3gWCu7KUrNY=
Message-ID: <9929d2390512161841m516b3728i8c08af3e83a4472f@mail.gmail.com>
Date: Fri, 16 Dec 2005 18:41:09 -0800
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [BUG][PATCH] e1000: Fix invalid memory reference
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <439EA1F4.3000204@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <439EA1F4.3000204@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
> Hi,
>
> I encountered a kernel panic which was caused by the invalid memory
> access by e1000 driver. The following patch fixes this issue.
>
> Thanks,
> Kenji Kaneshige
>
>
> This patch fixes invalid memory reference in the e1000 driver which
> would cause kernel panic.
>
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
>
>  drivers/net/e1000/e1000_param.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
>
> Index: linux-2.6.15-rc5/drivers/net/e1000/e1000_param.c
> ===================================================================
> --- linux-2.6.15-rc5.orig/drivers/net/e1000/e1000_param.c
> +++ linux-2.6.15-rc5/drivers/net/e1000/e1000_param.c
> @@ -545,7 +545,7 @@ e1000_check_fiber_options(struct e1000_a
>  static void __devinit
>  e1000_check_copper_options(struct e1000_adapter *adapter)
>  {
> -       int speed, dplx;
> +       int speed, dplx, an;
>         int bd = adapter->bd_number;
>
>         { /* Speed */
> @@ -641,8 +641,12 @@ e1000_check_copper_options(struct e1000_
>                                          .p = an_list }}
>                 };
>
> -               int an = AutoNeg[bd];
> -               e1000_validate_option(&an, &opt, adapter);
> +               if (num_AutoNeg > bd) {
> +                       an = AutoNeg[bd];
> +                       e1000_validate_option(&an, &opt, adapter);
> +               } else {
> +                       an = opt.def;
> +               }
>                 adapter->hw.autoneg_advertised = an;
>         }
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Could you provide the test case you used to get the kernel panic? and
system related information.

num_Autoneg > bd will never be true  at this point in the code because
we do the following test before we execute this branch.

   if ((num_AutoNeg > bd) && (speed != 0 || dplx != 0)) {
        DPRINTK(PROBE, INFO,
               "AutoNeg specified along with Speed or Duplex, "
               "parameter ignored\n");
        adapter->hw.autoneg_advertised = AUTONEG_ADV_DEFAULT;
    } else { /* Autoneg */
                          .
                          .
                          .

        int an = AutoNeg[bd];
        e1000_validate_option(&an, &opt, adapter);
        adapter->hw.autoneg_advertised = an;
    }


--
Cheers,
Jeff
