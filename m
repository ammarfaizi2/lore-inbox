Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266483AbRGGRh2>; Sat, 7 Jul 2001 13:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbRGGRhS>; Sat, 7 Jul 2001 13:37:18 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10959 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266483AbRGGRhD>;
	Sat, 7 Jul 2001 13:37:03 -0400
Message-ID: <3B4748BC.D9045F12@mandrakesoft.com>
Date: Sat, 07 Jul 2001 13:37:00 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107071019440.31249-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 7 Jul 2001, Jeff Garzik wrote:
> >
> > When building gcc-2.96 RPM using gcc-2.96 under kernel 2.4.7 on alpha,
> > the system goes --deeply-- into swap.  Not pretty at all.  The system
> > will be 200MB+ into swap, with 200MB+ in cache!  I presume this affects
> > 2.4.7-release also.
> 
> Note that "200MB+ into swap, with 200MB+ in cache" is NOT bad in itself.
> 
> It only means that we have scanned the VM, and allocated swap-space for
> 200MB worth of VM space. It does NOT necessarily mean that any actual
> swapping has been taking place: you should realize that the "cache" is
> likely to be not at least partly the _swap_ cache that hasn't been written
> out.
> 
> This is an accounting problem, nothing more. It looks strange, but it's
> normal.
> 
> Now, the fact that the system appears unusable does obviously mean that
> something is wrong. But you're barking up the wrong tree.

Two more additional data points,

1) partially kernel-unrelated.  MDK's "make" macro didn't support
alpha's /proc/cpuinfo output, "make -j$numprocs" became "make -j" and
fun ensued.

2) I agree that 200MB into swap and 200MB into cache isn't bad per se,
but when it triggers the OOM killer it is bad.

Alan suggested that I insert the following into the OOM killer code, as
the last test before returning 1.

	cnt++;
	if ((cnt % 5000) != 0)
		return 0;

I did this, and while watching "vmstat 3", the cache was indeed being
trimmed, whereas it was not before.

So, the OOM killer appears to be getting triggered early, but the rest
of the report was my screwup not the kernel.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
