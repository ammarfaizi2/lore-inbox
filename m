Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263730AbUDGQkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUDGQkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:40:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:3561 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263730AbUDGQkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:40:20 -0400
Date: Wed, 7 Apr 2004 09:42:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: adi@hexapodia.org, bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-Id: <20040407094222.3362e5c8.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.21.0404071119120.903-100000@dirac.phys.uwm.edu>
References: <20040406173326.0fbb9d7a.akpm@osdl.org>
	<Pine.GSO.4.21.0404071119120.903-100000@dirac.phys.uwm.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Allen <ballen@gravity.phys.uwm.edu> wrote:
>
> > > On modern Linux, apparently the correct way to bypass the buffer cache
> > > when writing to a block device is to open the block device with
> > > O_DIRECT.  This enables, for example, the user to more easily force a
> > > reallocation of a single sector of an IDE disk with a media error
> > > (without overwriting anything but the 1k "sector pair" containing the
> > > error).  dd(1) is convenient for this purpose, but is lacking a method
> > > to force O_DIRECT.  The enclosed patch adds a "conv=direct" flag to
> > > enable this usage.
> > 
> > This would be rather nice to have.  You'll need to ensure that the data
> > is page-aligned in memory.
> > 
> > While you're there, please add an fsync-before-closing option.
> 
> Andrew, am I right that this is NOT needed for the proposed O_DIRECT
> option, since open(2) says: 
>   "The I/O is synchronous, i.e., at the completion of the read(2) or
>    write(2) system call, data is guaranteed to have been transferred."
> so the write will block until data is physically on the disk.

A conv=fsync option is an irrelevant wishlist item.  If you were to provide
conv=fsync then dd should still fsync the file after performing the
direct-io read or write.

You're correct that an fsync after a direct-io read or write should not
need to perform any file data I/O.  But it will often need to perform file
metadata I/O - file allocation tables, inode, etc.  direct-io only syncs
the file data, not the file metadata.
