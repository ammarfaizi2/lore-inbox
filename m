Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319845AbSINC5Q>; Fri, 13 Sep 2002 22:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319846AbSINC5Q>; Fri, 13 Sep 2002 22:57:16 -0400
Received: from almesberger.net ([63.105.73.239]:58890 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S319845AbSINC5P>; Fri, 13 Sep 2002 22:57:15 -0400
Date: Sat, 14 Sep 2002 00:02:00 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jeff Chua <jchua@fedex.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] initrd >24MB corruption (fwd)
Message-ID: <20020914000159.A3352@almesberger.net>
References: <Pine.LNX.4.44.0208271038450.25059-100000@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208271038450.25059-100000@boston.corp.fedex.com>; from jchua@fedex.com on Tue, Aug 27, 2002 at 10:49:13AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
> Who else can help with this problem? I tried to write to Werner
> Almesberger <werner.almesberger@epfl.ch> (no such email)

That one is gone. wa@almesberger.net should work for the
forseeable future.

> I'm suspecting that somehow part of initrd is being corrupted during boot

The initrd is typically loaded below 16 MB. Your bzImage
uncompresses after the loaded kernel, so if your kernel is, say,
3 MB and compresses to 1 MB (that's a reasonably lean 2.4.19 kernel),
up to about 4.5 MB are overwritten already when getting the kernel
in place. A 6 MB/2 MB kernel would happy scribble over ~8.5 MB.

See also figures 7 and 8 of
http://www.almesberger.net/cv/papers/ols2k-9.ps

> ... does that mean the gzipped fs can only be <8MB? That could explain why
> the ram6MB.gz worked and ram8MB.gz doesn't.

The 8 MB mapping affects mainly the maximum kernel size and
shouldn't matter in this case. If you want to try anyway, you
should be able to increase the mapping by pushing
arch/i386/kernel/head.S:empty_zero_page down by a page, and
adjusting the .org below too.

So, assuming the problem is indeed the kernel overwriting initrd,
there are three things you can do to avoid this:

 - use a smaller initrd (they were never meant to be quite
   *that* big anyway :-)
 - make your kernel smaller
 - get your boot loader to load the initrd at a higher
   address, or find a boot loader that does (no, I don't
   know which ones do, and whether they do this reliably.
   Section 2.5 of my booting paper (see above) explains
   some potential pitfalls.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
