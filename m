Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272619AbRISNBD>; Wed, 19 Sep 2001 09:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274044AbRISNAy>; Wed, 19 Sep 2001 09:00:54 -0400
Received: from pc-62-30-67-108-az.blueyonder.co.uk ([62.30.67.108]:57838 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S272619AbRISNAr>; Wed, 19 Sep 2001 09:00:47 -0400
Date: Wed, 19 Sep 2001 14:00:58 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Andrew V. Samoilov" <kai@cmail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap successed but SIGBUS generated on access
Message-ID: <20010919140058.B21005@kushida.degree2.com>
In-Reply-To: <200109191036.f8JAa9J20856@cmail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109191036.f8JAa9J20856@cmail.ru>; from kai@cmail.ru on Wed, Sep 19, 2001 at 02:36:10PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew V. Samoilov wrote:
> I have bad CD-R with a some number of unreadable files.
> 
> Then user-space program use mmap system it returns ok but any
> attempt to access a memory pointed by this system call finishes 
> with SIGBUS. So Midnight Commander internal file viewer faults.

You can get the same problem even without read errors with some
configurations of NFS.  (root mmaps a file owned by someone else, but
cannot read the file due to `root_squash' on server).

> This error is 100 % reproduceable at 2.2.19 and 2.4.2 kernels.

It's not an error, it's standard behaviour.

> Is there any way to detect such problem in user-space without signal
> handlers ?

I don't think there is any way without a signal handler.

It is possible to do something useful with a signal handler sometimes.
For example, you can mmap() a zero page into the offending page once
you've got the fault address, or read() a zero page if you did
MAP_PRIVATE (this produces fewer VMAs), set a flag, and let the program
continue until it checks the flag and aborts the parsing or whatever
operation it's doing.

Unfortunately I don't think the signal handler's si_errno is set
properly to indicate the error.  So another thing to try is read() of
the offending page, to get a useful error code.  (And if the read
succeeds, that's ok because you did it at the correct address so the
program can proceed anyway).

Fwiw, unfortunately not all versions of the kernel, or all
architectures, set si_addr properly for SIGBUS.

enjoy,
-- Jamie
