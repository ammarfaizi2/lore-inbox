Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWI1W4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWI1W4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWI1W4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:56:41 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:1421 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030389AbWI1W4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:56:40 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm 1/3] swsusp: Add ioctl for swap files support
Date: Fri, 29 Sep 2006 00:58:32 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200609290005.17616.rjw@sisk.pl> <200609290013.39137.rjw@sisk.pl> <20060928154237.d91abb1f.akpm@osdl.org>
In-Reply-To: <20060928154237.d91abb1f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609290058.32593.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 29 September 2006 00:42, Andrew Morton wrote:
> On Fri, 29 Sep 2006 00:13:38 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > To be able to use swap files as suspend storage from the userland suspend
> > tools we need an additional ioctl() that will allow us to provide the kernel
> > with both the swap header's offset and the identification of the resume
> > partition.
> > 
> > The new ioctl() should be regarded as a replacement for the
> > SNAPSHOT_SET_SWAP_FILE ioctl() that from now on will be considered as
> > obsolete, but has to stay for backwards compatibility of the interface.
> > 
> > +
> > +/*
> > + * This structure is used to pass the values needed for the identification
> > + * of the resume swap area from a user space to the kernel via the
> > + * SNAPSHOT_SET_SWAP_AREA ioctl
> > + */
> > +struct resume_swap_area {
> > +	u_int16_t dev;
> > +	loff_t offset;
> > +} __attribute__((packed));
> >
> 
> hmm.  Asking the compiler to pack 16-bit and 64-bit quantities in this
> manner is a bit risky.  I guess it'll do the right thing, consistently,
> across all compiler versions and vendors and 32-bit-on-64-bit-kernel, etc.
> 
> But from a defensiveness/paranoia POV it'd be better to use a u32 here, I
> suspect.  (Will access to that loff_t cause an alignment trap on ia64?  Any
> other CPUs?  Dunno).

I'm not sure too.  Will change it to a 32-bit value.

> 
> >  #define PMOPS_PREPARE	1
> >  #define PMOPS_ENTER	2
> > Index: linux-2.6.18-mm1/kernel/power/user.c
> > ===================================================================
> > --- linux-2.6.18-mm1.orig/kernel/power/user.c
> > +++ linux-2.6.18-mm1/kernel/power/user.c
> > @@ -343,6 +343,37 @@ OutS3:
> >  		}
> >  		break;
> >  
> > +	case SNAPSHOT_SET_SWAP_AREA:
> > +		if (data->bitmap) {
> > +			error = -EPERM;
> > +		} else {
> > +			struct resume_swap_area swap_area;
> > +			dev_t swdev;
> > +
> > +			error = copy_from_user(&swap_area, (void __user *)arg,
> > +					sizeof(struct resume_swap_area));
> > +			if (error) {
> > +				error = -EFAULT;
> > +				break;
> > +			}
> > +
> > +			/*
> > +			 * User space encodes device types as two-byte values,
> > +			 * so we need to recode them
> > +			 */
> 
> Really?  stat() uses unsigned long and stat64() uses unsigned long long dev_t.

I don't know what the remaining 6 bytes are used for.  Anyway we need to use
old_decode_dev() to get this right.

> > +			swdev = old_decode_dev(swap_area.dev);
> > +			if (swdev) {
> > +				offset = swap_area.offset;
> > +				data->swap = swap_type_of(swdev, offset);
> > +				if (data->swap < 0)
> > +					error = -ENODEV;
> > +			} else {
> > +				data->swap = -1;
> > +				error = -EINVAL;
> > +			}
> > +		}
> > +		break;
> > +
> >  	default:
> >  		error = -ENOTTY;
> 
> But I wonder if we need to pass the device identified into this ioctl at
> all.  What device is the ioctl() against?  ie: what do `filp' and `inode'
> point at?  If it's /dev/hda1 then everything we need is right there, is it
> not?
> 
> ohshit, it's a miscdevice.  I wonder if it would have defined all this
> stuff to be operations against the blockdev.  Perhaps not.

Nope.  We need char-like read() and write().

> Well anyway.  It might be neater to require that userspace open /dev/hda1
> and pass in the fd to this ioctl.  But this code will never be neat, so
> whatever.

:-)
