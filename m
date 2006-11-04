Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965692AbWKDVGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965692AbWKDVGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 16:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965694AbWKDVGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 16:06:16 -0500
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:3530
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S965693AbWKDVGP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 16:06:15 -0500
From: Michael Buesch <mb@bu3sch.de>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: orinoco driver question
Date: Sat, 4 Nov 2006 22:04:57 +0100
User-Agent: KMail/1.9.5
References: <200611031613.25483.m.kozlowski@tuxland.pl>
In-Reply-To: <200611031613.25483.m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611042204.57560.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 November 2006 16:13, Mariusz Kozlowski wrote:
> Hi there,
> 
> 	Hope that's not a problem to ask some 'newbie' kernel coding stuff here. Here 
> it goes:
> 
> There are those two orinoco ioctl's
> 
> - orinoco_ioctl_setport3
> - orinoco_ioctl_getport3
> 
> Both take 'char *extra' as an argument to set/get 'priv->prefer_port3'. The 
> argument value to orinoco_ioctl_setport3 can be either 0 (IEEE ad-hoc mode) 
> or 1 (Lucent proprietary ad-hoc mode) the rest is -EINVAL. I don't get why 
> there is a need for an extra 'int' variable and casts in the code. 
> Using 'char *extra' seems to be fine there. To visualize what I mean here is 
> the patch:
> 
> --- linux-2.6.19-rc4-orig/drivers/net/wireless/orinoco.c        2006-11-02 
> 23:52:39.000000000 +0100
> +++ linux-2.6.19-rc4/drivers/net/wireless/orinoco.c     2006-11-03 
> 16:02:45.000000000 +0100
> @@ -3658,14 +3658,13 @@ static int orinoco_ioctl_setport3(struct
>                                   char *extra)
>  {
>         struct orinoco_private *priv = netdev_priv(dev);
> -       int val = *( (int *) extra );
>         int err = 0;
>         unsigned long flags;
>  
>         if (orinoco_lock(priv, &flags) != 0)
>                 return -EBUSY;
>  
> -       switch (val) {
> +       switch (*extra) {
>         case 0: /* Try to do IEEE ad-hoc mode */
>                 if (! priv->has_ibss) {
>                         err = -EINVAL;
> @@ -3704,9 +3703,8 @@ static int orinoco_ioctl_getport3(struct
>                                   char *extra)
>  {
>         struct orinoco_private *priv = netdev_priv(dev);
> -       int *val = (int *) extra;
>  
> -       *val = priv->prefer_port3;
> +       *extra = (char)priv->prefer_port3;
>         return 0;
>  }
> 
> I don't think this patch decreases code readability. This is just an example 
> but if there are more functions like this doesn't removing 'redundant' (?) 
> variables make the code better?

This breaks on bigendian systems.

-- 
Greetings Michael.
