Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSJLWkW>; Sat, 12 Oct 2002 18:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbSJLWkW>; Sat, 12 Oct 2002 18:40:22 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:25039 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S261317AbSJLWkV>;
	Sat, 12 Oct 2002 18:40:21 -0400
Date: Sun, 13 Oct 2002 00:46:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alastair Stevens <alastair@camlinux.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Small oddity of the week: 2.4.20-pre
Message-ID: <20021012224609.GA23046@win.tue.nl>
References: <1034431251.2688.64.camel@dolphin.entropy.net> <20021012171642.GA22969@win.tue.nl> <1034443816.10850.70.camel@dolphin.entropy.net> <20021012180032.GA22980@win.tue.nl> <1034447457.2688.74.camel@dolphin.entropy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034447457.2688.74.camel@dolphin.entropy.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 07:30:57PM +0100, Alastair Stevens wrote:
> On Sat, 2002-10-12 at 19:00, Andries Brouwer wrote:
> > > ie - the first time, it gives me two repeated lines. This appears to be
> > > random. In a clean terminal, it'll sometimes give me only the one line
> > > on the first run, and then do two lines multiple times....
> > 
> > Could it be that you have statistics garbage in /proc/partitions?
> > That will break fdisk.
> 
> Well, I'm no expert, but it looks OK to me:
> 
> 953 alastair@dolphin:~> cat /proc/partitions
> major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect
> wuse running use aveq
> 
>    3     0   58633344 hda 413162 1219920 12595886 1973640 268105 574049
> 6745668 8302590 -2 36995689 21817577
>    3     1    7253316 hda1 8 24 64 110 0 0 0 0 0 110 110

Some vendors added statistics to /proc/partitions.
Laziness on their side. Since they patch the kernel anyway
it would have been very easy to make /proc/diskstatistics.
But vendors may do as they wish.
This breaks some software, but these same vendors patch their
versions of this software.

Then some misguided people came and wanted this in the official kernel.
Bad. It is bad enough that vendors add pollution, but that good kernel
developers want to do this is inexplicable to me.
It only causes trouble, and gains precisely nothing.

In this particular case there are two problems:
(i) the format was changed
(ii) the content has become dynamic

Many proc files like /proc/filesystems or /proc/partitions may change,
but not many times a second, and most likely not without the operator
being aware of it. This means that programs like mount and fdisk can
read these files [1]. But a /proc/partitions that contains statistics
will change many times a second, causing problems for programs that
try to read it one line at a time.

My conjecture is that you were bitten by the latter phenomenon.

Andries


[1] The correct use of mount is to give an explicit type.
The correct use of fdisk is to give an explicit device.
Nothing else is guaranteed.
Shorthand versions work with high probability. But with a
dynamic /proc/partitions they work with lower probability.
