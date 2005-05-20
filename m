Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVETFUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVETFUZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 01:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVETFUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 01:20:24 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:3022 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261326AbVETFTt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 01:19:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DqQN3YnsABsechDpcwCU2WdL1aAwdCNrnPcmmVND0fa6liONKAtSZOkaMpe+X+oYw1yjP39RrQqtVuRYQcQSE6DDm81qY/aDRK/69SXnqDJnQ1Xnxgekz4W7gxvmSHNMuBfVQhV6iytXFlWhtFEdG756gWaP24MBNbtovnsRxVo=
Message-ID: <9cde8bff05051922193d4fd495@mail.gmail.com>
Date: Fri, 20 May 2005 14:19:46 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [updated patch 1/7] BSD Secure Levels: printk overhaul
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>, Serge Hallyn <serue@us.ibm.com>
In-Reply-To: <20050519214036.GC11385@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050517152303.GA2814@halcrow.us>
	 <20050519205525.GB16215@halcrow.us>
	 <20050519214036.GC11385@halcrow.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/05, Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> On Thu, May 19, 2005 at 01:58:06PM -0700, Andrew Morton wrote:
> > Did anyone mention printk_ratelimit()?
> 
> Third time's a charm.  :-)
> 
> I think this makes the most sense.  Module size is 18284; messages are
> globally limited, but the space savings is significant.
> 
> Signed-off by: Michael Halcrow <mhalcrow@us.ibm.com>
> 
> Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
> ===================================================================
> --- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c  2005-05-19 15:49:51.000000000 -0500
> +++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c       2005-05-19 16:33:20.000000000 -0500
> @@ -102,21 +102,25 @@
>  #define MY_NAME "seclvl"
> 
>  /**
> - * This time-limits log writes to one per second.
> + * This time-limits log writes to one per second for every message
> + * type.
>  */
> -#define seclvl_printk(verb, type, fmt, arg...)                 \
> -       do {                                                    \
> -               if (verbosity >= verb) {                        \
> -                       static unsigned long _prior;            \
> -                       unsigned long _now = jiffies;           \
> -                       if ((_now - _prior) > HZ) {             \
> -                               printk(type "%s: %s: " fmt,     \
> -                                       MY_NAME, __FUNCTION__ , \
> -                                       ## arg);                \
> -                               _prior = _now;                  \
> -                       }                                       \
> -               }                                               \
> -       } while (0)
> +static void __seclvl_printk(int verb, const char *fmt, ...)
> +{
> +       va_list args;
> +       va_start(args, fmt);
> +       if (verbosity >= verb && printk_ratelimit()) {
> +               vprintk(fmt, args);
> +       }
> +       va_end(args);
> +}
> +
> +/**
> + * Breaking the printk up into a macro and a function saves some text
> + * space.
> + */
> +#define seclvl_printk(verb, type, fmt, arg...) \
> +        __seclvl_printk((verb), type "%s: " fmt, __FUNCTION__, ## arg);
> 
>  /**
>  * kobject stuff
> @@ -711,7 +715,7 @@
>                goto exit;
>        }
>        seclvl_printk(0, KERN_INFO, "seclvl: Successfully initialized.\n");
> - exit:
> +      exit:
>        if (rc) {
>                printk(KERN_ERR "seclvl: Error during initialization: rc = "
>                       "[%d]\n", rc);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

i disklike the fact that the rate limit is based on 1 sec. how about
finer-grain limit?

it is best to let user to config the litmit. 1 sec is too raw to some purpose.

regards,
aq
