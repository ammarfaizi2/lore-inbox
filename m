Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292131AbSCRTCv>; Mon, 18 Mar 2002 14:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292130AbSCRTCm>; Mon, 18 Mar 2002 14:02:42 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:18953 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S291948AbSCRTC3>; Mon, 18 Mar 2002 14:02:29 -0500
Message-ID: <3C963954.87168F84@zip.com.au>
Date: Mon, 18 Mar 2002 11:00:36 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C959D55.14768770@zip.com.au> <200203181641.g2IGf1M20210@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Andrew Morton writes:
> > Note that it applies to a file descriptor.  If
> > posix_fadvise(FADV_DONTNEED) is called against a file descriptor,
> > and someone else has an fd open against the same file, that other
> > user gets their foot shot off.  That's OK.
> 
> Let me verify that I understand what you're saying. Process A and B
> independently open the file. The file is already in the cache (because
> other processes regularly read this file). Process A is slowly reading
> stuff. Process B does FADV_DONTNEED on the whole file. The pages are
> dropped.
> 
> You're saying this is OK? How about this DoS attack:
>         int fd = open ("/lib/libc.so", O_RDONLY, 0);
>         while (1) {
>                 posix_fadvise (fd, 0, 0, FADVISE_DONTNEED);
>                 sleep (1);
>         }
> 
> Let me see that disc head move! Wheeee!
> 

POSIX_FADV_DONTNEED could only unmap pages from the caller's
VMA's, so the problem would only affect other processes which
share the same mm - CLONE_MM threads.

If some other process has a reference on the pages then they
wouldn't get unmapped as a result of this.  It's the same
as madvise(MADV_DONTNEED).

-
