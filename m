Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWFHHaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWFHHaY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWFHHaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:30:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932535AbWFHHaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:30:23 -0400
Date: Thu, 8 Jun 2006 00:30:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: samuel@sortiz.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix an inproper alignment accessing in irda protocol
 stack
Message-Id: <20060608003015.52fe1b8e.akpm@osdl.org>
In-Reply-To: <489ecd0c0606080015v4815d0f3wa3d28c564eaf6885@mail.gmail.com>
References: <489ecd0c0606080015v4815d0f3wa3d28c564eaf6885@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006 15:15:11 +0800
"Luke Yang" <luke.adi@gmail.com> wrote:

> Hi all,
> 
>  For "struct irda_device_info" in irda.h:
> struct irda_device_info {
> 	__u32       saddr;    /* Address of local interface */
> 	__u32       daddr;    /* Address of remote device */
> 	char        info[22]; /* Description */
> 	__u8        charset;  /* Charset used for description */
> 	__u8        hints[2]; /* Hint bits */
> };
>    The "hints" member aligns at the third byte of a word, an odd
> address. So if we visit "hints" as a short in irlmp.c:
> 
>     u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
> 
>   will cause alignment problem on some machines. Architectures with
> strict alignment rules do not allow 16-bit read on an odd address.
> 
> Signed-off-by: Luke Yang <luke.adi@gmail.com>
> 
>  irlmp.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> --- net/irda/irlmp.c.old        2006-06-08 14:49:20.000000000 +0800
> +++ net/irda/irlmp.c    2006-06-08 14:54:29.000000000 +0800
> @@ -849,7 +849,8 @@
>         }
> 
>         /* Construct new discovery info to be used by IrLAP, */
> -       u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
> +       irlmp->discovery_cmd.data.hints[0] = irlmp->hints.word & 0xff;
> +       irlmp->discovery_cmd.data.hints[1] = (irlmp->hints.word & 0xff00) >> 8;

This change will have the effect of swapping those two bytes on big-endian
machines.

