Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbULXD03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbULXD03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 22:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbULXD02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 22:26:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4553 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261353AbULXD0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 22:26:12 -0500
Date: Fri, 24 Dec 2004 03:26:10 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Bruce Allan <bwa@us.ibm.com>
Cc: matthew@wil.cx, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] [resend] VFS locking errors on max offset edge cases
Message-ID: <20041224032610.GB11543@parcelfarce.linux.theplanet.co.uk>
References: <1103842880.4702.87.camel@w-bwa3.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103842880.4702.87.camel@w-bwa3.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 03:01:20PM -0800, Bruce Allan wrote:
> A number of Connectathon (http://www.connectathon.org/nfstests.html)
> POSIX/fcntl() locking tests fail (even on local filesystems) at various
> edge cases (i.e. around maximum allowable offsets) on 64-bit
> architectures.

OK, that's bad and needs to be fixed.

> The overflow tests in fs/compat.c were superfluous where they were
> located because if there was a conflicting lock, l_start and l_len would
> have been overwritten with the values owned by the conflicting lock; if
> no conflicting lock, sys_fcntl() would have returned any applicable
> error.  The tests are moved above the call to sys_fcntl() to capture
> overflow errors which would not have been caught by sys_fcntl(), eg.
> obvious overflow when _FILE_OFFSET_BITS == 32.

I don't buy this explanation though.  With your patch, we're testing
the lock the user passed in to see if it'd overflow.  Clearly, that
can never happen.  The checks are supposed to be testing whether the
conflicting lock is outside the limits that a program using a 32-bit
off_t can cope with.

> These tests also had a couple 'off by one' errors when comparing with
> the maximum allowable offset.

Perhaps just fix that, and don't move the tests around?

> @@ -537,17 +537,19 @@ asmlinkage long compat_sys_fcntl64(unsig
>  		ret = get_compat_flock(&f, compat_ptr(arg));
>  		if (ret != 0)
>  			break;
> +		if ((cmd == F_GETLK) &&
> +		    ((f.l_start > COMPAT_OFF_T_MAX) ||
> +		     ((f.l_start + f.l_len - 1) > COMPAT_OFF_T_MAX))) {
> +				ret = -EOVERFLOW;
> +				break;
> +			}
> +		}
>  		old_fs = get_fs();
>  		set_fs(KERNEL_DS);
>  		ret = sys_fcntl(fd, cmd, (unsigned long)&f);
>  		set_fs(old_fs);
> -		if (cmd == F_GETLK && ret == 0) {
> -			if ((f.l_start >= COMPAT_OFF_T_MAX) ||
> -			    ((f.l_start + f.l_len) > COMPAT_OFF_T_MAX))
> -				ret = -EOVERFLOW;
> -			if (ret == 0)
> -				ret = put_compat_flock(&f, compat_ptr(arg));
> -		}
> +		if (cmd == F_GETLK && ret == 0)
> +			ret = put_compat_flock(&f, compat_ptr(arg));
>  		break;
>  
>  	case F_GETLK64:
> @@ -556,19 +558,21 @@ asmlinkage long compat_sys_fcntl64(unsig
>  		ret = get_compat_flock64(&f, compat_ptr(arg));
>  		if (ret != 0)
>  			break;
> +		if ((cmd == F_GETLK64) &&
> +		    ((f.l_start > COMPAT_LOFF_T_MAX) ||
> +		     ((f.l_start + f.l_len - 1) > COMPAT_LOFF_T_MAX))) {
> +				ret = -EOVERFLOW;
> +				break;
> +			}
> +		}
>  		old_fs = get_fs();
>  		set_fs(KERNEL_DS);
>  		ret = sys_fcntl(fd, (cmd == F_GETLK64) ? F_GETLK :
>  				((cmd == F_SETLK64) ? F_SETLK : F_SETLKW),
>  				(unsigned long)&f);
>  		set_fs(old_fs);
> -		if (cmd == F_GETLK64 && ret == 0) {
> -			if ((f.l_start >= COMPAT_LOFF_T_MAX) ||
> -			    ((f.l_start + f.l_len) > COMPAT_LOFF_T_MAX))
> -				ret = -EOVERFLOW;
> -			if (ret == 0)
> -				ret = put_compat_flock64(&f, compat_ptr(arg));
> -		}
> +		if (cmd == F_GETLK64 && ret == 0)
> +			ret = put_compat_flock64(&f, compat_ptr(arg));
>  		break;
>  
>  	default:
> diff -Nurp -X dontdiff linux-2.6.10-rc3-vanilla/fs/locks.c linux-2.6.10-rc3/fs/locks.c
> --- linux-2.6.10-rc3-vanilla/fs/locks.c	2004-12-23 11:52:50.902423742 -0800
> +++ linux-2.6.10-rc3/fs/locks.c	2004-12-23 12:02:35.268404863 -0800
> @@ -314,7 +314,8 @@ static int flock_to_posix_lock(struct fi
>  
>  	/* POSIX-1996 leaves the case l->l_len < 0 undefined;
>  	   POSIX-2001 defines it. */
> -	start += l->l_start;
> +	if ((start += l->l_start) < 0)
> +		return -EINVAL;

I hate assignments inside if statements.  Make this:

	start += l->l_start;
	if (start < 0)
		return -EINVAL;

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
