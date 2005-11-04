Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVKDXJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVKDXJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVKDXJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:09:23 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:36569 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750700AbVKDXJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:09:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] ->compat_ioctl for 390 tape_char
Date: Sat, 5 Nov 2005 00:10:46 +0100
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
References: <20051104221816.GD9384@lst.de>
In-Reply-To: <20051104221816.GD9384@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511050010.47138.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 04 November 2005 23:18, Christoph Hellwig wrote:
> The only own ioctl, TAPE390_DISPLAY, is compat_clean, everything else
> is routed through common translation code.
> 
> 

> +tapechar_compat_ioctl(struct file *filp, unsigned int no, unsigned long data)
> +{
> +       struct tape_device *device = filp->private_data;
> +       int rval = -ENOIOCTLCMD;
> +
> +       if (device->discipline->ioctl_fn) {
> +               lock_kernel();
> +               rval = device->discipline->ioctl_fn(device, no, data);
> +               unlock_kernel();
> +       }
> +
> +       return rval;
> +}

Hmm, isn't ->compat_ioctl called before the translation lookup? If so,
this code would return -EINVAL from tape_34xx_ioctl and result in never
entering the conversion for MTIO* at all.

The same problem seems to be in the other patches of this series, but
I could also be mistaken.

BTW, I now have a set of 25 patches that moves all handlers from
fs/compat_ioctl.c over to the respective drivers and subsystems,
but I'm not sure how to best test that.
I intend to at least give it a test run on my Opteron for the whatever
ioctls I normally use, but the rest is just guesswork. Christoph,
can you review those patches?

	Arnd <><
