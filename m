Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282829AbRLGJqL>; Fri, 7 Dec 2001 04:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282824AbRLGJqB>; Fri, 7 Dec 2001 04:46:01 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:27289 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282823AbRLGJpn>; Fri, 7 Dec 2001 04:45:43 -0500
Message-Id: <5.1.0.14.2.20011207092244.049f6720@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 07 Dec 2001 09:45:17 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: kernel: ldt allocation failed
Cc: vkire@pixar.com (Kiril Vidimce), dmaas@dcine.com (Dan Maas),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <E16CH6i-00059b-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:15 07/12/01, Alan Cox wrote:
> > I don't see how one can magically tell that this is an NVIDIA problem.
>
>We don't know. But since we don't have their source and they have our
>source only they can tell you.

Not doing any debugging is fine.

However, looking at 2.4.16/arch/i386/kernel/process.c::copy_segments() 
which generates this message it seems odd: It returns void, yet it can fail 
because it is doing a vmalloc().

When the vmalloc() fails, the new_mm->context.segments is set to NULL and 
the function returns.

That seems wrong, no? Shouldn't there be a panic() when the allocation 
fails at least? Or even better the function should perhaps return an error 
code?

Considering there is only one caller (kernel/fork.c::copy_mm()) it would be 
easy to modify copy_mm() to handle a returned error code gracefully and 
goto fail_nomem, which would in turn result in kernel/fork.c::do_fork(), 
the only caller of copy_mm(), cleaning up properly and returning an error code.

Or have I missed something and the situation where the ldt is missing can 
be recovered from? - I would think (without looking into this in the kernel 
code) that loosing the local descriptor table would be rather detrimental 
on the first context switch to the new process created by fork... And 
considering all kinds of errors are being handled in this code path, except 
for the vmalloc() failure, it seems like a good idea to add the appropriate 
fail mechanism.

If nvidia is causing this to get triggered they will likely run into 
problems elsewhere anyway and we don't care but we should get the kernel 
working. As it is AFAICS we have a potential DOS, just get the box close to 
OOM and start calling man 2 fork and/or man 3 clone and you could trigger 
this with a finite probability.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

