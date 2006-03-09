Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWCIFpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWCIFpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 00:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWCIFpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 00:45:38 -0500
Received: from xenotime.net ([66.160.160.81]:18054 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750705AbWCIFph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 00:45:37 -0500
Date: Wed, 8 Mar 2006 21:47:24 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-usb-devel@lists.sourceforge.net, hjlipp@web.de,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] reduce syslog clutter (take 2)
Message-Id: <20060308214724.cf987bbf.rdunlap@xenotime.net>
In-Reply-To: <440F609F.8090604@imap.cc>
References: <440F609F.8090604@imap.cc>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2006 23:54:23 +0100 Tilman Schmidt wrote:

> The current versions of the err() / info() / warn() syslog macros
> insert __FILE__ at the beginning of the message, which expands to
> the complete path name of the source file within the kernel tree.
> 
> With the following patch, when used in a module, they'll insert the
> module name instead, which is significantly shorter and also tends to
> be more useful to users trying to make sense of a particular message.
> 
> This patch replaces the one posted on 24 Feb 2006 10:50:52 +0100
> which caused compile errors in non-modular drivers. It applies to
> kernel 2.6.16-rc5 after the patch labeled
> "add macros notice(), dev_notice() (take 2)".
> 
> Signed-off-by: Tilman Schmidt <tilman@imap.cc>
> ---
> 
>  usb.h |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.16-rc5-patch-splitpoint/include/linux/usb.h	2006-03-08 12:36:03.000000000 +0100
> +++ linux-2.6.16-rc5-patch-splitpoint2/include/linux/usb.h	2006-03-08 12:43:07.000000000 +0100
> @@ -1199,14 +1199,20 @@
>  #define dbg(format, arg...) do {} while (0)
>  #endif
> 
> +#if defined(CONFIG_MODULES) && defined(THIS_MODULE)
> +#define KMSG_LOCATION_PREFIX THIS_MODULE ? THIS_MODULE->name : __FILE__

Can we get parens around the expression, please?

and does it make sense to test
#if defined(THIS_MODULE)
#define KMSG_LOCATION_PREFIX (THIS_MODULE ? ...

If that does make sense (the double testing of THIS_MODULE),
please explain why it does.

> +#else
> +#define KMSG_LOCATION_PREFIX __FILE__
> +#endif
> +
>  #define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , \
> -	__FILE__ , ## arg)
> +	KMSG_LOCATION_PREFIX , ## arg)
>  #define info(format, arg...) printk(KERN_INFO "%s: " format "\n" , \
> -	__FILE__ , ## arg)
> +	KMSG_LOCATION_PREFIX , ## arg)
>  #define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , \
> -	__FILE__ , ## arg)
> +	KMSG_LOCATION_PREFIX , ## arg)
>  #define notice(format, arg...) printk(KERN_NOTICE "%s: " format "\n" , \
> -	__FILE__ , ## arg)
> +	KMSG_LOCATION_PREFIX , ## arg)
> 
> 
>  #endif  /* __KERNEL__ */


---
~Randy
