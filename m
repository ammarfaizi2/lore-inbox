Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267701AbTBLVzH>; Wed, 12 Feb 2003 16:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267709AbTBLVzG>; Wed, 12 Feb 2003 16:55:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:44267 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267701AbTBLVzF>;
	Wed, 12 Feb 2003 16:55:05 -0500
Date: Wed, 12 Feb 2003 14:03:38 -0800
From: Andrew Morton <akpm@digeo.com>
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT foolish question
Message-Id: <20030212140338.6027fd94.akpm@digeo.com>
In-Reply-To: <1045084764.4767.76.camel@urca.rutgers.edu>
References: <1045084764.4767.76.camel@urca.rutgers.edu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Feb 2003 22:04:48.0629 (UTC) FILETIME=[C26EFA50:01C2D2E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruno Diniz de Paula <diniz@cs.rutgers.edu> wrote:
>
> Hi,
> 
> I am trying to use O_DIRECT to read ordinary files and read syscall
> always returns 0, unless when the file size equals the fs block size.

It should be returning -1, with errno set to EINVAL.

> Is
> it true that I can only use O_DIRECT when the size of the file written
> in the inode is a multiple of block size?
> 

The file can be of any size - the kernel will zero-fill any remaining bytes.

The address and length which you pass into the read() or write() system call
must both be a multiple of the filesystem block size.

It is always safe to just use the machine's page size for alignment
calculations - no filesystem has a blocksize larger than the pagesize.

A good way to do this is to run getpagesize(), and to then malloc a buffer
which is one page larger than you need.  Then round that address up to the
next page boundary.  And perform I/O into that memory with
multiple-of-page-size requests.



In the 2.5 kernel the "must be a multiple of blocksize" requirement was
relaxed.  We now support alignments and lengths down to the minimum which is
supported by the underlying device.  Typically 512 bytes, but not always.

Portable applications should not assume that 512-byte alignment is supported.
They should query the device's aligment requirements via the BLKSSZGET ioctl
against (say) /dev/hda1.  Or they can simply try 512, 1024, 2048, ...  at
initialisation time.
