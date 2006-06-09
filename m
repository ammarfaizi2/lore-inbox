Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbWFIFCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWFIFCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 01:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWFIFCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 01:02:17 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17624
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965179AbWFIFCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 01:02:17 -0400
Date: Thu, 08 Jun 2006 22:01:25 -0700 (PDT)
Message-Id: <20060608.220125.112621003.davem@davemloft.net>
To: luke.adi@gmail.com
Cc: akpm@osdl.org, samuel@sortiz.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix an inproper alignment accessing in irda protocol
 stack
From: David Miller <davem@davemloft.net>
In-Reply-To: <489ecd0c0606082045w7456a90et586a3954f1a2fca0@mail.gmail.com>
References: <489ecd0c0606080015v4815d0f3wa3d28c564eaf6885@mail.gmail.com>
	<20060608003015.52fe1b8e.akpm@osdl.org>
	<489ecd0c0606082045w7456a90et586a3954f1a2fca0@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Luke Yang" <luke.adi@gmail.com>
Date: Fri, 9 Jun 2006 11:45:06 +0800

>         /* Construct new discovery info to be used by IrLAP, */
> -       u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
> +#ifdef __LITTLE_ENDIAN
> +       irlmp->discovery_cmd.data.hints[0] = irlmp->hints.word & 0xff;
> +       irlmp->discovery_cmd.data.hints[1] = (irlmp->hints.word & 0xff00) >> 8;
> +#else /* ifdef __BIG_ENDIAN */
> +       irlmp->discovery_cmd.data.hints[0] = (irlmp->hints.word & 0xff00) >> 8;
> +       irlmp->discovery_cmd.data.hints[1] = irlmp->hints.word & 0xff;
> +#endif

Please don't add ugly ifdefs, they are not necessary.

You can use the le16_to_cpu() macro on the hints.word datum,
then pick out the byte you need, as necessary.  That way you
don't need to use ifdefs.

