Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVF0GVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVF0GVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVF0GSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:18:39 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:198 "EHLO natnoddy.rzone.de")
	by vger.kernel.org with ESMTP id S261844AbVF0GQb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:16:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: [git patch] DRM 32/64 ioctl patch..
Date: Mon, 27 Jun 2005 08:11:31 +0200
User-Agent: KMail/1.7.2
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, paulus@samba.org,
       "David S. Miller" <davem@davemloft.net>
References: <Pine.LNX.4.58.0506261313390.3269@skynet>
In-Reply-To: <Pine.LNX.4.58.0506261313390.3269@skynet>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506270811.32758.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 26 Juni 2005 14:22, Dave Airlie wrote:

> In the compatibility routines I have assumed that the kernel can
> safely access user addresses after set_fs(KERNEL_DS).  That is, where
> an ioctl argument structure contains pointers to other structures, and
> those other structures are already compatible between the 32-bit and
> 64-bit ABIs (i.e. they only contain things like chars, shorts or
> ints), I just check the address with access_ok() and then pass it
> through to the 64-bit ioctl code.  I believe this approach may not
> work on sparc64, but it does work on ppc64 and x86_64 at least.

Are you sure that comment still applies? I can't find any reference
to set_fs in the drm code and compat_alloc_user_space() based handlers
do not have the problem.

Otherwise that approach opens up a security hole by giving user access to
kernel memory on all architectures that have separate address spaces for
user and kernel instead of different ranges in the same address space.

Guessing from the implementation of get_fs/set_fs, these would include
m68k, s390{,x}, sparc{,64} and i386 with the 4G/4G mapping, so these
must never build code that relies on working user pointer dereferences
under set_fs(KERNEL_DS).

> +typedef struct drm_version_32 {
> +	int	version_major;	  /**< Major version */
> +	int	version_minor;	  /**< Minor version */
> +	int	version_patchlevel;/**< Patch level */
> +	u32	name_len;	  /**< Length of name buffer */
> +	u32	name;		  /**< Name of driver */

compat_uptr_t ?

> +	u32	date_len;	  /**< Length of date buffer */
> +	u32	date;		  /**< User-space buffer to hold date */

same here

> +	u32	desc_len;	  /**< Length of desc buffer */
> +	u32	desc;		  /**< User-space buffer to hold desc */

and here

> +} drm_version32_t;
> +
> +static int compat_drm_version(struct file *file, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	drm_version32_t v32;
> +	drm_version_t __user *version;
> +	int err;
> +
> +	if (copy_from_user(&v32, (void __user *) arg, sizeof(v32)))

(void __user *) arg should really be compat_ptr(arg). In theory,
this is only necessary on s390, which does not implement drm,
but we just do it the right way so other people don't copy
the incorrect code.

> +		return -EFAULT;
> +
> +	version = compat_alloc_user_space(sizeof(*version));
> +	if (!access_ok(VERIFY_WRITE, version, sizeof(*version)))
> +		return -EFAULT;
> +	if (__put_user(v32.name_len, &version->name_len)
> +	    || __put_user((void __user *)(unsigned long)v32.name,
> +			  &version->name)
> +	    || __put_user(v32.date_len, &version->date_len)
> +	    || __put_user((void __user *)(unsigned long)v32.date,
> +			  &version->date)
> +	    || __put_user(v32.desc_len, &version->desc_len)
> +	    || __put_user((void __user *)(unsigned long)v32.desc,
> +			  &version->desc))
> +		return -EFAULT;

Same here. Note how compat_ptr also makes that more readable.
More of these are in other parts of the patch.

	Arnd <><
