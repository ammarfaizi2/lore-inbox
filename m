Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSIJQnr>; Tue, 10 Sep 2002 12:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317751AbSIJQnr>; Tue, 10 Sep 2002 12:43:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18244 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317694AbSIJQnq>; Tue, 10 Sep 2002 12:43:46 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it possible to use 8K page size on a i386 pc?
References: <39B5C4829263D411AA93009027AE9EBB13299663@fmsmsx35.fm.intel.com>
	<3D6C189D.7080101@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Sep 2002 10:34:12 -0600
In-Reply-To: <3D6C189D.7080101@zytor.com>
Message-ID: <m1lm69olbv.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Luck, Tony wrote:
> > H. Peter Anvin wrote:
> > 
> >>Followup to:  <200208271914.g7RJEQE07821@devserv.devel.redhat.com>
> >>By author:    Pete Zaitcev <zaitcev@redhat.com>
> >>In newsgroup: linux.dev.kernel
> >>
> >>>You may run into trouble with something that calls mmap with
> >>>a fixed address, with executables which have text sizes of
> >>>odd number of small pages. I was told that these problems are
> >>>fairly rare.
> >>
> >>Only 50% of all binaries are affected... that's fairly rare :)
> > 
> > The majority of x86 linux binaries run on ia64 with a 16K
> > pagesize (admittedly with some not-so-pretty code to fudge
> > mmap/munmap addresses ... but it is proof that you can reduce
> > the problems to "fairly rare").
> > 
> 
> It's proof that you can kluge around it.  Part of the issue is with the
> handling of the code versus data segment, which means you have to treat
> (part of) the code segment as data.
> 
> Changing the i386 port to use > 4K pages would have to go through
> similar contortions.

In particular the sysv ABI for i386 specifies a 4K page size be
supported.

The alpha ABI (which planned for page size changes) specifies all data
in binaries must be 64K aligned.  Despite initially shipping with
something smaller.  This issue is particularly important to demand
paging. 

The classic work around is to just read the entire binary into memory
and don't worry about sharing pages.  Which is an effective way to support
old a.out binaries, that had 1K alignments.

The case of mmap(MAP_FIXED) without the proper alignment can only
fail.  And of course libc would need to be updated so that
getpagesize() returns the appropriate page size.

But be very clear that anything that changes the externally visible
page size is an ABI change, and best avoided.

But note it should be possible to grow he kernels internal page size
without making it externally visible.  And allow mappings of partial
pages.  So far it has been more trouble than it is worth.

Eric
