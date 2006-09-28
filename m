Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161350AbWI1WnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161350AbWI1WnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161348AbWI1WnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:43:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59364 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161347AbWI1Wm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:42:58 -0400
Date: Thu, 28 Sep 2006 15:42:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 1/3] swsusp: Add ioctl for swap files support
Message-Id: <20060928154237.d91abb1f.akpm@osdl.org>
In-Reply-To: <200609290013.39137.rjw@sisk.pl>
References: <200609290005.17616.rjw@sisk.pl>
	<200609290013.39137.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 00:13:38 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> To be able to use swap files as suspend storage from the userland suspend
> tools we need an additional ioctl() that will allow us to provide the kernel
> with both the swap header's offset and the identification of the resume
> partition.
> 
> The new ioctl() should be regarded as a replacement for the
> SNAPSHOT_SET_SWAP_FILE ioctl() that from now on will be considered as
> obsolete, but has to stay for backwards compatibility of the interface.
> 
> +
> +/*
> + * This structure is used to pass the values needed for the identification
> + * of the resume swap area from a user space to the kernel via the
> + * SNAPSHOT_SET_SWAP_AREA ioctl
> + */
> +struct resume_swap_area {
> +	u_int16_t dev;
> +	loff_t offset;
> +} __attribute__((packed));
>

hmm.  Asking the compiler to pack 16-bit and 64-bit quantities in this
manner is a bit risky.  I guess it'll do the right thing, consistently,
across all compiler versions and vendors and 32-bit-on-64-bit-kernel, etc.

But from a defensiveness/paranoia POV it'd be better to use a u32 here, I
suspect.  (Will access to that loff_t cause an alignment trap on ia64?  Any
other CPUs?  Dunno).

>  #define PMOPS_PREPARE	1
>  #define PMOPS_ENTER	2
> Index: linux-2.6.18-mm1/kernel/power/user.c
> ===================================================================
> --- linux-2.6.18-mm1.orig/kernel/power/user.c
> +++ linux-2.6.18-mm1/kernel/power/user.c
> @@ -343,6 +343,37 @@ OutS3:
>  		}
>  		break;
>  
> +	case SNAPSHOT_SET_SWAP_AREA:
> +		if (data->bitmap) {
> +			error = -EPERM;
> +		} else {
> +			struct resume_swap_area swap_area;
> +			dev_t swdev;
> +
> +			error = copy_from_user(&swap_area, (void __user *)arg,
> +					sizeof(struct resume_swap_area));
> +			if (error) {
> +				error = -EFAULT;
> +				break;
> +			}
> +
> +			/*
> +			 * User space encodes device types as two-byte values,
> +			 * so we need to recode them
> +			 */

Really?  stat() uses unsigned long and stat64() uses unsigned long long dev_t.



> +			swdev = old_decode_dev(swap_area.dev);
> +			if (swdev) {
> +				offset = swap_area.offset;
> +				data->swap = swap_type_of(swdev, offset);
> +				if (data->swap < 0)
> +					error = -ENODEV;
> +			} else {
> +				data->swap = -1;
> +				error = -EINVAL;
> +			}
> +		}
> +		break;
> +
>  	default:
>  		error = -ENOTTY;

But I wonder if we need to pass the device identified into this ioctl at
all.  What device is the ioctl() against?  ie: what do `filp' and `inode'
point at?  If it's /dev/hda1 then everything we need is right there, is it
not?

ohshit, it's a miscdevice.  I wonder if it would have defined all this
stuff to be operations against the blockdev.  Perhaps not.

Well anyway.  It might be neater to require that userspace open /dev/hda1
and pass in the fd to this ioctl.  But this code will never be neat, so
whatever.

