Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTKKMB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 07:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTKKMB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 07:01:29 -0500
Received: from apegate.roma1.infn.it ([141.108.7.31]:32781 "EHLO apona.ape")
	by vger.kernel.org with ESMTP id S263464AbTKKMB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 07:01:26 -0500
Date: Tue, 11 Nov 2003 13:00:59 +0100 (CET)
From: "davide.rossetti" <rossetti@roma1.infn.it>
Reply-To: davide.rossetti@roma1.infn.it
To: Jesse Pollard <jesse@cats-chateau.net>
cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
In-Reply-To: <03111007291500.08768@tabby>
Message-ID: <Pine.LNX.4.44.0311111243530.810-100000@ronin.ape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, Jesse Pollard wrote:

> On Monday 10 November 2003 06:08, Ihar 'Philips' Filipau wrote:
> >    sendfile(2) - ?
> I don't think that is what he was referring to.. The sample
> code is strictly user mode file->file copying.
> > Davide Rossetti wrote:
> > > it may be orribly RTFM... but writing a simple framework I realized
> > > there is no libc/POSIX/whoknows
> > > copy(const char* dest_file_name, const char* src_file_name)
> > >
> > > What is the technical reason???
> 
> It isn't an application for the kernel.

Maybe I was misunderstood... I'm asking why the libc/iso/ansi/posix 
engineer did not add the spec a user-mode API to do copy file to file ???

if there was such a standard _user_ API, we could talk about user/kernel 
implementation issues... but my question is more "primitive" somehow :)

> > > I understand that there may be little space for kernel side
> > > optimizations in this area but anyway I'm surprised I have to write
> > >
> > > < the bits to clone the metadata of src_file_name on opening
> > > dest_file_name >
> > > const int BUFSIZE = 1<<12;
> > > char buffer[BUFSIZE];
> > > int nrb;
> > > while((nrb = read(infd, buffer, BUFSIZE) != -1) {
> > >  ret = write(outfd, buffer, nrb);
> > >  if(ret != nrb) {...}
> > > }
> > >
> > > instead of something similar to:
> > > sys_fscopy(...)
> 
> It is too simple to implement in user mode.
> 
> There are some other issues too:
> 
> The security context of the output depends on the user process.
> If it is a privileged process (ie, may change the context of the
> result) then the user process has to setup that context before
> the file is copied.
> 
> There are also some issues with mandatory security controls. If it
> is copied in kernel mode, then the previous labels could be automatically
> carried over to the resulting file... But that may not be what you
> want (and frequently, it isn't).
> 
> Now back to the copy.. You don't have to use a read/write loop- mmap
> is faster. And this is the other reason for not doing it in Kernel mode.
> Buffer management of this type is much easier in user space since the
> copy procedure doesn't have to deal with memory limitations, cache flushes
> page faulting of processes unrelated to the copy, but is related to cache
> pressure.

ok... so I have to code a framework routine which auto-benchmarks (at
either runtime or configure time) and uses at least 2 implementations, one 
using read/write and another mmap(), as I know for sure that on
different Unices they perform differently... ah.. and the day we add
sys_sendfile(fd,fd) (if it is not there yet) I have to add yet another
implementation... and doing file copies of gigabyte sized files with 
mmap() on 32bit archs isn't so trivial, you have to do windowing I 
guess...

seems scary at least ;)

<joke>
it seems similar to saying that we do not need a rename() Posix/XOpen/etc 
API as we can do:

rename(to, from) {
 link(to, from); // make hardlink
 unlink(from); // remove original
}
</joke>

regards

-- 
______/ Rossetti Davide   INFN - Roma I - APE group \______________
 pho +390649914507/412   web: http://apegate.roma1.infn.it/~rossetti
 fax +390649914423     email: davide.rossetti@roma1.infn.it        

