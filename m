Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284415AbRLHT1i>; Sat, 8 Dec 2001 14:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284421AbRLHT12>; Sat, 8 Dec 2001 14:27:28 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:23818 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S284415AbRLHT1V>;
	Sat, 8 Dec 2001 14:27:21 -0500
Subject: Re: File copy system call proposal
From: Quinn Harris <quinn@nmt.edu>
To: Thomas Cataldo <thomas.cataldo@laposte.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1007833194.17577.0.camel@buffy>
In-Reply-To: <1007782956.355.2.camel@quinn.rcn.nmt.edu> 
	<1007833194.17577.0.camel@buffy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 08 Dec 2001 12:23:50 -0700
Message-Id: <1007839431.371.0.camel@quinn.rcn.nmt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-12-08 at 10:39, Thomas Cataldo wrote:
> On Sat, 2001-12-08 at 04:42, Quinn Harris wrote:
> > I would like to propose implementing a file copy system call.
> > I expect the initial reaction to such a proposal would be "feature
> > bloat" but I believe some substantial benefits can be seen possibly
> > making it worthwhile, primarily the following:
> 
> I think  
> 
> ssize_t  sendfile(int  out_fd,  int  in_fd, off_t *offset, size_t count)
> 
> is what you are looking for, isn't it ?
> 
> > 
> > Copy on write:
> > >From my experience most files that are copied on the same partition are
> > copied from a source code directory (eg /usr/src/{src dir}) to somewhere
> > else in /usr.  These copied files are seldomly modified but usually
> > truncated (when copied over again).
> > Instead of actually copying the file in these circumstances something
> > similar to a hard link could be created.  But unlike a hard link, when
> > data is written to the file a real duplicate of the file (or possibly
> > part of the file) will be created.  This is basically identical to the
> > way a processes memory space is duplicated on a fork.  To create an
> > illusion of an actual copied file the file system will need to
> > explicitly support this feature.  This can also eliminate duplication in
> > the buffer cache when a file is copied.
> > 
> > This feature would drastically reduce the time taken to install a
> > program from a compiled source tarball.  I also expect on my system this
> > feature would save about 1/6 of my hard drive space.  Of course this
> > wouldn't affect performance if the source and destination files are on
> > different partitions.
> > 
> > All kernel copy:
> > Commands like cp and install open the source and destination file using
> > the open sys call.  The data from the source is copied to the
> > destination by repeatedly calling the read then write sys calls.  This
> > process involves copying the data in the file from kernel memory space
> > to the user memory space and back again.  Note that all this copying is
> > done by the kernel upon calling read or write.  I would expect if this
> > can be moved completely into the kernel no memory copy operations would
> > be performed by the processor by using hardware DMA.
> > 
> > On my system a copy takes about 1s of the CPU time per 20MB copied (PII
> > 300Mhz) much of which I expect is spent just copying memory.  This
> > figure seems a bit high to copy memory so someone please correct me if I
> > am wrong.
> > 
> > 
> > Implementing these features especially the copy on write I expect will
> > not be trivial.  In addition code that copies files like cp must be
> > modified to take advantage of these features.
> > 
> > Will many other users benefit from these features?  Will implementing
> > them (especially copy on write) cause an excessive addition to the code
> > of the kernel?
> > 
> > Quinn Harris (quinn@nmt.edu)
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

I wasn't aware of the sendfile system call.  But it apears that just
like the mmap, write method suggested by H. Peter Anvin a memory copy is
still performed when copying files from discs to duplicate the data for
the buffer cache.  This would undoubtedly be faster than repeatedly
calling read and write as it avoids one mem copy.  Yet GNU
fileutils-4.1, that cp and install are part of, uses the read/write
method.  I expect this is primarily because of portability issues but I
wouldn't think the use of mmap would cause portability issues.

Infact a patch for file utils that does this is availible at
http://mail.gnu.org/pipermail/bug-fileutils/2001-May/001700.html and by
using time on cp, a mmap copy apears to require nearly half the CPU time
of normal.  This would suggest to me that eliminating the memcopy on the
call to write would allow even the largest file copies to be performed
with very nominal support from the processor.



