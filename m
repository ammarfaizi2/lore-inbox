Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVBHRXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVBHRXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVBHRXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:23:49 -0500
Received: from peabody.ximian.com ([130.57.169.10]:50100 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261582AbVBHRX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:23:26 -0500
Subject: Re: VM disk cache behavior.
From: Robert Love <rml@novell.com>
To: jon ross <jonross@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e130a7170502080906596561d7@mail.gmail.com>
References: <e130a7170502080906596561d7@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 08 Feb 2005 12:18:03 -0500
Message-Id: <1107883084.23409.7.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 12:06 -0500, jon ross wrote:
> I have an app with a small fixed memory footprint that does a lot of
> random reads from a large file. I thought if I added more memory to
> the machine the VM would do more caching of the disk, but added memory
> does not seem to make any difference. I played with some of the params
> in /proc/sys/vm and none of them seem to have any effect.
> 
> I tired both a 2.4.20 & 2.6.10 kernels with no difference.
> 
> The machine is a Dell 2560. I tired memory configs of 512M, 1G, 4G and
> the average read-times do not change.
> 
> Do I need to set/compile anything to allow the VM to use the memory?
> If is was a way to tell how much memory the VM is using for a drive
> cache I could at least tell if my kernel is miss-configured or my app
> sucks.

More memory will allow the kernel to keep more cache in memory.  You can
see how much memory the kernel is using for cache with free(1).

That does not sound like your problem, though.  It sounds like you want
the kernel to do more _read-ahead_, e.g. cache things _before_ you even
need them (and then you might want more memory to actually keep all of
the stuff alive in the cache, but that is a secondary problem).
Unfortunately, since you are doing random reads, it is very hard for the
kernel to do intelligent read-ahead.

What you can do is pre-fault the entire file into memory.  This is not a
bad idea if you know you are going to ultimately read much of the file.

You can prefault the file automatically and asynchronously using
posix_fadvise().  Example:

	if (posix_fadvise (fd, 0, 0, POSIX_FADV_WILLNEED))
		perror ("posix_fadvise");

See posix_fadvise(2) for more information.

It might also be faster to use mmap(1) over read(2).  Then you can use
madvise().

Best,

	Robert Love


