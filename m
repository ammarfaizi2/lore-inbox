Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbVLNWE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVLNWE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVLNWE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:04:27 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:26230 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932403AbVLNWE1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:04:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QTxj/3HD8M2pD/yyh8Xrr34KTTWWQX5jmBHg/y2L19TJ9K3waNd+8pic2rS5koNafv7vQ5rzJNKI24frcLrVbsxvJTYHxWEn7MH0Ca2wXO/mLstr2YoaoSh/SrCRuX25j762zaQ70YB5Q406KBHDv8xU1y5GVbP0v7foY2/xsy8=
Message-ID: <d120d5000512141404wc86331fo124ebd29b713b07e@mail.gmail.com>
Date: Wed, 14 Dec 2005 17:04:26 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch driver
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       stelian@popies.net, kernel-stuff@comcast.net
In-Reply-To: <20051214213923.GB17548@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051213223659.GB20017@hansmi.ch>
	 <1134568620.3875.6.camel@localhost> <20051214213923.GB17548@hansmi.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/14/05, Michael Hanselmann <linux-kernel@hansmi.ch> wrote:
>  *
> + * Nov 2005 - Parag Warudkar
> + *  o Added ability to export data via relayfs
> + *
> + * Nov/Dec 2005 - Michael Hanselmann
> + *  o Compile relayfs support only if enabled in the kernel
> + *  o Enable relayfs only if requested by the user
> + *

We have an SCM, not need to have a changelog in the driver.

>
> +#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
> +struct rchan* rch = NULL;
> +struct rchan_callbacks* rcb = NULL;

Initializing with 0/NULL adds to the size of the image for no reason.

>
> +#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
> +static int relayfs = 0;

Same here.

> +module_param(relayfs, int, 0444);
> +MODULE_PARM_DESC(relayfs, "Activate relayfs support");
> +#endif
> +
>  static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
>                             int *z, int *fingers)
>  {
> @@ -194,6 +219,13 @@ static void atp_complete(struct urb* urb
>                goto exit;
>        }
>
> +#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
> +       /* "rch" is NULL if relayfs is not enabled */
> +       if (rch && dev->data) {
> +               relay_write(rch, dev->data, dev->urb->actual_length);
> +       }
> +#endif
> +

Haveing ifdefs in the middle of the code is not too nice. can we
please have something like this:

#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
static inline void appletouch_relayfs_dump(...)
{
...
}
static int appletouch_relayfs_init(void)
{
...
}
static void appletouch_relayfs_exit()
{
...
}
#else
static inline void appletouch_relayfs_dump(...) { }
static int appletouch_relayfs_init(void) { return 0; }
static void appletouch_relayfs_exit() { }
#endif

Also, would not it be better to initialize relayfs only when device is
opened because there won't be any data otehrwise?

--
Dmitry
