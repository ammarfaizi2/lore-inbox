Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSH0RAP>; Tue, 27 Aug 2002 13:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSH0RAO>; Tue, 27 Aug 2002 13:00:14 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:63237 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316573AbSH0RAN>; Tue, 27 Aug 2002 13:00:13 -0400
Date: Tue, 27 Aug 2002 18:04:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: aia21@cantab.net, kernel@bonin.ca, linux-kernel@vger.kernel.org
Subject: Re: Loop devices under NTFS
Message-ID: <20020827180427.A30606@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Adam J. Richter" <adam@yggdrasil.com>, aia21@cantab.net,
	kernel@bonin.ca, linux-kernel@vger.kernel.org
References: <200208271353.GAA04875@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208271353.GAA04875@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Aug 27, 2002 at 06:53:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 06:53:19AM -0700, Adam J. Richter wrote:
> 	Why?
> 
> 	According to linux-2.5.31/Documentation/Locking,
> "->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
> may be called from the request handler (/dev/loop)."

Just because it's present in current code it doesn't mean it's right.
Calling aops directly from generic code is a layering violation and
it will not survive 2.5.

> 	Using the page cache in loop.c saves a copy when there is a
> data transformation (such as encryption) involved, and that can be
> important for reducing the cost of privacy.

Separating a stackalbe encryption block device from the loop driver is
a good idea.  The current loop code is a horrible mess because it tries
to do the job of three drivers in one.

> >Depending on the filesystem implementation _anything_ may happen.
> >With current intree filesystems the only real life problem is that
> >it doesn't work on certain filesystems.
> 
> 	Sorry for repeating myself here: If you're referring to the
> stock loop.c not working with tmpfs because tmpfs lacks
> {prepare,commit}_write which my patch works around (based on Jari's
> patch before mine, and a patch by Andrew Morton as well).  I have yet
> to hear a clear reason why any writable plain file on any given file
> system could not have {prepare,commit}_write operations available.

No, tmpfs also does not use generic_file_read but a sligh variation,
calling do_generic_file_read on tmpfs inodes will not always works as
expected.  Don't do it.

> 	Please come up with a clear example.  I'm not asking you for a
> test case that can produce it, just some narrative of the problem
> occurring.

loop on nfs, do_generic_file_read is called without the needed 
nfs_revalidate_inode, thus i_size is outdated, and loop might happily
read out of the filesize.

> 	I am aware that you can get races if someone mounts a loop
> device while accessing the underlying file by some other mechanism,
> but I believe that the only case where that would be done in practice
> is to change the encryption of a device, and, because of the read and
> write patterns involved in that, it should not be a problem.

This is true for filesystems like nfs (above) that only revalidate and then
call generic_file_read.  For totally different implementations anything can
happen.  Even if it mostly works it's not the kind of design we want to have
in the kernel.

