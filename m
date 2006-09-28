Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWI1Xj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWI1Xj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWI1Xj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:39:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1495 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750973AbWI1Xj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:39:27 -0400
Date: Fri, 29 Sep 2006 01:39:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 1/3] swsusp: Add ioctl for swap files support
Message-ID: <20060928233920.GI26653@elf.ucw.cz>
References: <200609290005.17616.rjw@sisk.pl> <20060928154237.d91abb1f.akpm@osdl.org> <20060928230339.GF26653@elf.ucw.cz> <200609290135.33683.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609290135.33683.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-09-29 01:35:33, Rafael J. Wysocki wrote:
> On Friday, 29 September 2006 01:03, Pavel Machek wrote:
> > Hi!
> > 
> > > On Fri, 29 Sep 2006 00:13:38 +0200
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > To be able to use swap files as suspend storage from the userland suspend
> > > > tools we need an additional ioctl() that will allow us to provide the kernel
> > > > with both the swap header's offset and the identification of the resume
> > > > partition.
> > > > 
> > > > The new ioctl() should be regarded as a replacement for the
> > > > SNAPSHOT_SET_SWAP_FILE ioctl() that from now on will be considered as
> > > > obsolete, but has to stay for backwards compatibility of the interface.
> > > > 
> > > > +
> > > > +/*
> > > > + * This structure is used to pass the values needed for the identification
> > > > + * of the resume swap area from a user space to the kernel via the
> > > > + * SNAPSHOT_SET_SWAP_AREA ioctl
> > > > + */
> > > > +struct resume_swap_area {
> > > > +	u_int16_t dev;
> > > > +	loff_t offset;
> > > > +} __attribute__((packed));
> > 
> > > 
> > > hmm.  Asking the compiler to pack 16-bit and 64-bit quantities in this
> > > manner is a bit risky.  I guess it'll do the right thing, consistently,
> > > across all compiler versions and vendors and 32-bit-on-64-bit-kernel, etc.
> > > 
> > > But from a defensiveness/paranoia POV it'd be better to use a u32 here, I
> > > suspect.  (Will access to that loff_t cause an alignment trap on ia64?  Any
> > > other CPUs?  Dunno).
> > 
> > Perhaps just loff_t offset; u32 dev; ? If 64-bit variable is first, we
> > should avoid most problems, no?
> 
> Done.  Updated patch follows.

Looks okay to me.


> Greetings,
> Rafael
> 
> 
> ---
> To be able to use swap files as suspend storage from the userland suspend
> tools we need an additional ioctl() that will allow us to provide the kernel
> with both the swap header's offset and the identification of the resume
> partition.
> 
> The new ioctl() should be regarded as a replacement for the
> SNAPSHOT_SET_SWAP_FILE ioctl() that from now on will be considered as
> obsolete, but has to stay for backwards compatibility of the interface.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/power.h |   13 ++++++++++++-
>  kernel/power/user.c  |   31 +++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.18-mm2/kernel/power/power.h
> ===================================================================
> --- linux-2.6.18-mm2.orig/kernel/power/power.h
> +++ linux-2.6.18-mm2/kernel/power/power.h
> @@ -119,7 +119,18 @@ extern int snapshot_image_loaded(struct 
>  #define SNAPSHOT_SET_SWAP_FILE		_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
>  #define SNAPSHOT_S2RAM			_IO(SNAPSHOT_IOC_MAGIC, 11)
>  #define SNAPSHOT_PMOPS			_IOW(SNAPSHOT_IOC_MAGIC, 12, unsigned int)
> -#define SNAPSHOT_IOC_MAXNR	12
> +#define SNAPSHOT_SET_SWAP_AREA		_IOW(SNAPSHOT_IOC_MAGIC, 13, void *)
> +#define SNAPSHOT_IOC_MAXNR	13
> +
> +/*
> + * This structure is used to pass the values needed for the identification
> + * of the resume swap area from a user space to the kernel via the
> + * SNAPSHOT_SET_SWAP_AREA ioctl
> + */
> +struct resume_swap_area {
> +	loff_t offset;
> +	u_int32_t dev;
> +} __attribute__((packed));
>  
>  #define PMOPS_PREPARE	1
>  #define PMOPS_ENTER	2
> Index: linux-2.6.18-mm2/kernel/power/user.c
> ===================================================================
> --- linux-2.6.18-mm2.orig/kernel/power/user.c
> +++ linux-2.6.18-mm2/kernel/power/user.c
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
>  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
