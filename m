Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSH0NtO>; Tue, 27 Aug 2002 09:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSH0NtO>; Tue, 27 Aug 2002 09:49:14 -0400
Received: from h-64-105-35-65.SNVACAID.covad.net ([64.105.35.65]:12196 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316070AbSH0NtN>; Tue, 27 Aug 2002 09:49:13 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 27 Aug 2002 06:53:19 -0700
Message-Id: <200208271353.GAA04875@adam.yggdrasil.com>
To: hch@infradead.org
Subject: Re: Loop devices under NTFS
Cc: aia21@cantab.net, kernel@bonin.ca, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002, Christoph Hellwig:
>Yes.  Anything but the filesystem itself and the generic read/write path
>is not supposed to use address space operations directly.

	Why?

	According to linux-2.5.31/Documentation/Locking,
"->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
may be called from the request handler (/dev/loop)."

	Using the page cache in loop.c saves a copy when there is a
data transformation (such as encryption) involved, and that can be
important for reducing the cost of privacy.

>> >Note that there is a more severe bug in loop.c:  it's abuse of
>> >do_generic_file_read.  
>> 
>> 	Could you please elaborate on this and give an example where
>> it return incorrect data, deadlock, generate a kernel oops, etc.?

>Depending on the filesystem implementation _anything_ may happen.
>With current intree filesystems the only real life problem is that
>it doesn't work on certain filesystems.

	Sorry for repeating myself here: If you're referring to the
stock loop.c not working with tmpfs because tmpfs lacks
{prepare,commit}_write which my patch works around (based on Jari's
patch before mine, and a patch by Andrew Morton as well).  I have yet
to hear a clear reason why any writable plain file on any given file
system could not have {prepare,commit}_write operations available.

>I think at least the network
>filesystems might be oopsable with some preparation.

	Please come up with a clear example.  I'm not asking you for a
test case that can produce it, just some narrative of the problem
occurring.

	I am aware that you can get races if someone mounts a loop
device while accessing the underlying file by some other mechanism,
but I believe that the only case where that would be done in practice
is to change the encryption of a device, and, because of the read and
write patterns involved in that, it should not be a problem.
   
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

