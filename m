Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266586AbUGKOQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266586AbUGKOQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 10:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266602AbUGKOQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 10:16:31 -0400
Received: from mail.telpin.com.ar ([200.43.18.243]:36545 "EHLO
	mail.telpin.com.ar") by vger.kernel.org with ESMTP id S266586AbUGKOQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 10:16:11 -0400
Date: Sun, 11 Jul 2004 11:19:17 -0300
From: Alberto Bertogli <albertogli@telpin.com.ar>
To: Andrew Morton <akpm@osdl.org>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syncing a file's metadata in a portable way
Message-ID: <20040711141917.GI7405@telpin.com.ar>
Mail-Followup-To: Alberto Bertogli <albertogli@telpin.com.ar>,
	Andrew Morton <akpm@osdl.org>, bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
References: <20040709030637.GB5858@telpin.com.ar> <20040709023948.59497dca.akpm@osdl.org> <20040710115404.GA11420@outpost.ds9a.nl> <20040710131459.13ffec23.akpm@osdl.org> <20040711102743.GB16199@outpost.ds9a.nl> <20040711033527.4017170d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711033527.4017170d.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 03:35:27AM -0700, Andrew Morton wrote:
> bert hubert <ahu@ds9a.nl> wrote:
> >
> > On Sat, Jul 10, 2004 at 01:14:59PM -0700, Andrew Morton wrote:
> > 
> > > If only the one file has been written to, an fsync on ext3 shouldn't
> > > produce any more writeout than an fsync on ext2.
> > (...)
> > > Either that, or SQLite is broken.
> > 
> > I'll show strace and vmstat tomorrow - I found very little writes, no mmap,
> > some fsync and massive writeouts. On ext2, performance was two orders of
> > magnitude better.
> > 
> 
> One scenario which could cause this is if the application is writing a
> large amount of data to a file and is repeatedly *overwriting* that data. 
> And the application is repeatedly adding new blocks to, and fsyncing a
> separate file.

I don't know about SQLite, but I've written a small transactional I/O
library and it seems to trigger this behaviour too.

I test with fsx opening files O_SYNC against fsx using the library with a
mode called "lingering transactions" that write the data synchronously
only once when the trasaction is commited (and fsync()s at the end, which
doesn't seem to make a significant difference).

In this mode the library creates a file for each transaction, write to it
using pwrite and then fsync both the file and the parent directory. Then
it uses pwrite to write to the real file, without syncing it.

I'm using an USB flash so disk seeks are not so costly. Here are the
results, running "fsx -R -W -p 1024 -N 1000 testfile" as root, on the
flash. For more operations (-N) the relation between the tests is pretty
much the same.

Tests are:
* sync: fsx opening everything O_SYNC (uses write())
* linger: fsx using the library with the method described avobe (uses
	pwrite and fsync)

Time is measured with "time" (real), and the time spent in write and fsync
with ltrace -S -c (in seconds), taken in different runs so ltrace overhead
doesn't show up in time. The other functions and system calls don't make a
significant difference.

I tested ext2, ext3 with data=ordered and data=writeback, without any
mount options.


test	fs      total time  write      fsync      ltrace total

sync	ext2    0m22.956s   69.007234  ---        153.888504
linger	ext2    0m27.358s   ---        81.107975  191.014929

sync	ext3-o  0m23.709s   69.143989  ---        162.130448
linger	ext3-o  0m37.234s   ---        109.51823  243.963197

sync 	ext3-w  0m22.622s   71.071572  ---        160.095286
linger	ext3-w  0m26.429s   ---        76.482683  188.377637


So ext3 in writeback mode has almost the same numbers as ext2, but using
ordered mode is much more slower in the library case.


Thanks,
		Alberto


