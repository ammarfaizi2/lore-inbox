Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314758AbSESSSz>; Sun, 19 May 2002 14:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314783AbSESSSy>; Sun, 19 May 2002 14:18:54 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:58282 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314758AbSESSSw>;
	Sun, 19 May 2002 14:18:52 -0400
Date: Sun, 19 May 2002 20:18:45 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Robert T. Johnson" <rtjohnso@cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org,
        Sailesh Krishnamurthy <sailesh@EECS.Berkeley.EDU>
Subject: Re: Bug in 2.4.19-pre8 drivers/input/joydev.c
Message-ID: <20020519201845.Q1976@ucw.cz>
In-Reply-To: <1021487163.12915.37.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 11:26:02AM -0700, Robert T. Johnson wrote:

> Sailesh Krishmurthy and I have found what we believe is an exploitable
> bug in drivers/input/joydev.c:joydev_ioctl().  It looks like the
> JSIOCSAXMAP and JSIOCSBTNMAP cases accidentally reverse the arguments to
> copy_from_user().  A user program could call these ioctls with a
> maliciously chosen arg to crash the system or gain root access.  A patch
> is attached to this message (though my mailer will probably mangle it --
> sorry).  We apologize if we have misunderstood the behavior of this
> function.

Thanks for this report, this was found and fixed already.

> 
> We found this bug using the static analysis tool cqual,
> http://www.cs.berkeley.edu/~jfoster/cqual/, developed at UC Berkeley by
> Jeff Foster, John Kodumal, and many others.
> 
> Please CC us in any replies.
> 
> Thanks for all your great work on the kernel.
> 
> Best,
> Rob Johnson (rtjohnso@cs.berkeley.edu)
> Sailesh Krishnamurthy (sailesh@cs.berkeley.edu)
> 
> 
> 
> --- joydev.c    Wed May 15 10:25:26 2002
> +++ joydev_fixed.c      Wed May 15 10:37:36 2002
> @@ -363,7 +363,7 @@
>                         return copy_to_user((struct js_corr *) arg,
> joydev->corr,
>                                                 sizeof(struct js_corr) *
> joydev->nabs) ? -EFAULT : 0;
>                 case JSIOCSAXMAP:
> -                       if (copy_from_user((__u8 *) arg, joydev->abspam,
> sizeof(__u8) *
> ABS_MAX))
> +                       if (copy_from_user(joydev->abspam, (__u8 *) arg,
> sizeof(__u8) *
> ABS_MAX))
>                                 return -EFAULT;
>                         for (i = 0; i < ABS_MAX; i++) {
>                                 if (joydev->abspam[i] > ABS_MAX) return
> -EINVAL;
> @@ -374,7 +374,7 @@
>                         return copy_to_user((__u8 *) arg,
> joydev->abspam,
>                                                 sizeof(__u8) * ABS_MAX)
> ? -EFAULT : 0;
>                 case JSIOCSBTNMAP:
> -                       if (copy_from_user((__u16 *) arg,
> joydev->absmap, sizeof(__u16) *
> (KEY_MAX - BTN_MISC)))
> +                       if (copy_from_user(joydev->absmap, (__u16 *)
> arg, sizeof(__u16) *
> (KEY_MAX - BTN_MISC)))
>                                 return -EFAULT;
>                         for (i = 0; i < KEY_MAX - BTN_MISC; i++); {
>                                 if (joydev->keypam[i] > KEY_MAX ||
> joydev->keypam[i] < BTN_MISC)
> return -EINVAL;
> 

-- 
Vojtech Pavlik
SuSE Labs
