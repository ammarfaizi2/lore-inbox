Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285799AbRLHDqg>; Fri, 7 Dec 2001 22:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285796AbRLHDq1>; Fri, 7 Dec 2001 22:46:27 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:52744 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S285795AbRLHDqG>;
	Fri, 7 Dec 2001 22:46:06 -0500
Subject: File copy system call proposal
From: Quinn Harris <quinn@nmt.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 20:42:36 -0700
Message-Id: <1007782956.355.2.camel@quinn.rcn.nmt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to propose implementing a file copy system call.
I expect the initial reaction to such a proposal would be "feature
bloat" but I believe some substantial benefits can be seen possibly
making it worthwhile, primarily the following:

Copy on write:
>From my experience most files that are copied on the same partition are
copied from a source code directory (eg /usr/src/{src dir}) to somewhere
else in /usr.  These copied files are seldomly modified but usually
truncated (when copied over again).
Instead of actually copying the file in these circumstances something
similar to a hard link could be created.  But unlike a hard link, when
data is written to the file a real duplicate of the file (or possibly
part of the file) will be created.  This is basically identical to the
way a processes memory space is duplicated on a fork.  To create an
illusion of an actual copied file the file system will need to
explicitly support this feature.  This can also eliminate duplication in
the buffer cache when a file is copied.

This feature would drastically reduce the time taken to install a
program from a compiled source tarball.  I also expect on my system this
feature would save about 1/6 of my hard drive space.  Of course this
wouldn't affect performance if the source and destination files are on
different partitions.

All kernel copy:
Commands like cp and install open the source and destination file using
the open sys call.  The data from the source is copied to the
destination by repeatedly calling the read then write sys calls.  This
process involves copying the data in the file from kernel memory space
to the user memory space and back again.  Note that all this copying is
done by the kernel upon calling read or write.  I would expect if this
can be moved completely into the kernel no memory copy operations would
be performed by the processor by using hardware DMA.

On my system a copy takes about 1s of the CPU time per 20MB copied (PII
300Mhz) much of which I expect is spent just copying memory.  This
figure seems a bit high to copy memory so someone please correct me if I
am wrong.


Implementing these features especially the copy on write I expect will
not be trivial.  In addition code that copies files like cp must be
modified to take advantage of these features.

Will many other users benefit from these features?  Will implementing
them (especially copy on write) cause an excessive addition to the code
of the kernel?

Quinn Harris (quinn@nmt.edu)

