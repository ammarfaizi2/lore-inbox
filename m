Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTKJN3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTKJN3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:29:55 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:15863 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263572AbTKJN3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:29:41 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Davide Rossetti <davide.rossetti@roma1.infn.it>
Subject: Re: OT: why no file copy() libc/syscall ??
Date: Mon, 10 Nov 2003 07:29:15 -0600
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <QiyV.1k3.15@gated-at.bofh.it> <3FAF7FC8.8050503@softhome.net>
In-Reply-To: <3FAF7FC8.8050503@softhome.net>
MIME-Version: 1.0
Message-Id: <03111007291500.08768@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 November 2003 06:08, Ihar 'Philips' Filipau wrote:
>    sendfile(2) - ?
I don't think that is what he was referring to.. The sample
code is strictly user mode file->file copying.
> Davide Rossetti wrote:
> > it may be orribly RTFM... but writing a simple framework I realized
> > there is no libc/POSIX/whoknows
> > copy(const char* dest_file_name, const char* src_file_name)
> >
> > What is the technical reason???

It isn't an application for the kernel.

> > I understand that there may be little space for kernel side
> > optimizations in this area but anyway I'm surprised I have to write
> >
> > < the bits to clone the metadata of src_file_name on opening
> > dest_file_name >
> > const int BUFSIZE = 1<<12;
> > char buffer[BUFSIZE];
> > int nrb;
> > while((nrb = read(infd, buffer, BUFSIZE) != -1) {
> >  ret = write(outfd, buffer, nrb);
> >  if(ret != nrb) {...}
> > }
> >
> > instead of something similar to:
> > sys_fscopy(...)

It is too simple to implement in user mode.

There are some other issues too:

The security context of the output depends on the user process.
If it is a privileged process (ie, may change the context of the
result) then the user process has to setup that context before
the file is copied.

There are also some issues with mandatory security controls. If it
is copied in kernel mode, then the previous labels could be automatically
carried over to the resulting file... But that may not be what you
want (and frequently, it isn't).

Now back to the copy.. You don't have to use a read/write loop- mmap
is faster. And this is the other reason for not doing it in Kernel mode.
Buffer management of this type is much easier in user space since the
copy procedure doesn't have to deal with memory limitations, cache flushes
page faulting of processes unrelated to the copy, but is related to cache
pressure.
