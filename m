Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWI1Jka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWI1Jka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWI1Jk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:40:29 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:29670 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751757AbWI1Jk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:40:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O5sVrdUpQZ18aIEC+MkWTJV9TGFJYIZkPlGlkxj7Ysa72Gfdszw/RGS6XU/rnUqNS3tZ054c53dKQ7gWjx23ZqRX9JJ4dKC7J2kd5vgeKG6n5kSujyXW+V7AcAPDY2SG2iSMYd4/pu03oes916aOFKS7KKOw61QycLaKHcqlQ6M=
Message-ID: <5a4c581d0609280240t6ed7200fo2540fb5297b77848@mail.gmail.com>
Date: Thu, 28 Sep 2006 11:40:27 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-git7 freezes solid on boot
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060927124652.c670785e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0609270531p52d9452fie223dbd3152bcd38@mail.gmail.com>
	 <20060927124652.c670785e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 27 Sep 2006 12:31:52 +0000
> "Alessandro Suardi" <alessandro.suardi@gmail.com> wrote:
>
> > Dell D610 running FC5, works fine with -git5, locks up
> >  in less than a second after selecting the GRUB entry
> >  for -git7, with NumLock on and nothing else working,
> >  SysRq included, except for the power switch (no need
> >  to keep it down for 10 secs though - it powers off
> >  right away).
> >
> > Since bzdiffing patch-2.6.18-git5 and -git7 shows there
> >  are framebuffer changes, I'm wondering whether anyone
> >  had already stumbled into similar issues.
> >
> > Video card is an Intel i915GM.
> >
>
> You probably want this..
>
> From: Andi Kleen <ak@suse.de>
>
> i386: Use early clobbers for semaphores now
>
> The new code does clobber the result early, so make sure to tell
> gcc to not put it into the same register as a input argument
>
> Signed-off-by: Andi Kleen <ak@suse.de>
>
> Index: linux/include/asm-i386/semaphore.h
> ===================================================================
> --- linux.orig/include/asm-i386/semaphore.h
> +++ linux/include/asm-i386/semaphore.h
> @@ -126,7 +126,7 @@ static inline int down_interruptible(str
>                 "lea %1,%%eax\n\t"
>                 "call __down_failed_interruptible\n"
>                 "2:"
> -               :"=a" (result), "+m" (sem->count)
> +               :"=&a" (result), "+m" (sem->count)
>                 :
>                 :"memory");
>         return result;
> @@ -148,7 +148,7 @@ static inline int down_trylock(struct se
>                 "lea %1,%%eax\n\t"
>                 "call __down_failed_trylock\n\t"
>                 "2:\n"
> -               :"=a" (result), "+m" (sem->count)
> +               :"=&a" (result), "+m" (sem->count)
>                 :
>                 :"memory");
>         return result;
> -

Indeed, this brought -git7 back to life for my laptop.

Thanks Andrew ! (now going to build -git9...)

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
