Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290846AbSARVsW>; Fri, 18 Jan 2002 16:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290847AbSARVsN>; Fri, 18 Jan 2002 16:48:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30592 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290846AbSARVsA>; Fri, 18 Jan 2002 16:48:00 -0500
Date: Fri, 18 Jan 2002 16:49:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Doug Alcorn <lathi@seapine.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jan 2002, Doug Alcorn wrote:

> 
> I had a weird situation with my application where the user deleted all
> the database files while the app was still reading and writing to the
> opened file descriptor.  What was weird to me was that the app didn't
> complain.  It just went merrily about it's business as if nothing were
> wrong.  Of course, after the app shut down all it's data was lost.
> 
> Since I didn't expect this behavior I wrote a simple little program to
> test it[1].  Sure enough, you can rm a file that has opened file
> descriptors and no errors are generated.  Interestingly, sun solaris
> does the same thing.  Since this is the case, I thought this might be
> a feature instead of a bug (ms-win doesn't allow the rm).  So, my
> question is where is this behavior defined?  Is it a kernel issue?
> Does POSIX define this behavior?  Is it a libc issue?  
> 
> I tried to google this, but couldn't think of the right terms to
> describe it.  As I'm not on lkm, I would appreciate a CC: to
> <doug@lathi.net>.

This is a characteristic of a VFS (Virtual File System) on any
Unix system. The file doesn't go away until it is closed by
everybody that accesses it. However, you can remove or rename it
even when it's open for write by other tasks. If a task has an
open file-descriptor and keeps it open, it could 'fix' a possibly
deleted file, by opening it again with

         new_fd = open("filename", O_CREAT|O_RDWR, 0644);

(without O_TRUNC) and it will remain in existance after all
file descriptors are closed, because it was "created" again
after it was deleted by another task. However, if all descriptors
are closed before you recreate it, data are permanently lost.
In this case, it's a new file.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


