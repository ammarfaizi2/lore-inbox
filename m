Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280952AbRKTVng>; Tue, 20 Nov 2001 16:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280998AbRKTVn1>; Tue, 20 Nov 2001 16:43:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:42115 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280952AbRKTVnH>; Tue, 20 Nov 2001 16:43:07 -0500
Date: Tue, 20 Nov 2001 16:43:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Steffen Persvold <sp@scali.no>,
        Christopher Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <20011120131839.B4210@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.3.95.1011120163024.14793A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, Mike Fedyk wrote:

> On Tue, Nov 20, 2001 at 10:05:37PM +0100, Steffen Persvold wrote:
> > Christopher Friesen wrote:
> > > 
> > > "Richard B. Johnson" wrote:
> > > >
> > > > On Tue, 20 Nov 2001, Wolfgang Rohdewald wrote:
> > > >
> > > > > On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > > > > > When a page is deleted for one executable (because we can re-read it from
> > > > > > on-disk binary), it is discarded, not paged out.
> > > > >
> > > > > What happens if the on-disk binary has changed since loading the program?
> > > > > -
> > > >
> > > > It can't. That's the reason for `install` and other methods of changing
> > > > execututable files (mv exe-file exe-file.old ; cp newfile exe-file).
> > > > The currently open, and possibly mapped file can be re-named, but it
> > > > can't be overwritten.
> > > 
> > > Actually, with NFS (and probably others) it can.  Suppose I change the file on
> > > the server, and it's swapped out on a client that has it mounted.  When it swaps
> > > back in, it can get the new information.
> > > 
> > 
> > This sounds really dangerous... What about shared libraries ??
> > 
> 
> IIRC (if wrong flame...)
> 
> When you delete an open file, the entry is removed from the directory, but
> not unlinked until the file is closed.  This is a standard UNIX semantic.
> 
> Now, if you have a set of processes with shared memory, and one closes, and
> another is created to replace, the new process will get the new libraries,
> or even new version of the process.  This could/will bring down the entire
> set of processes.
> 
> Apps like samba come to mind...
> 
> Mike

If the file is local, everything is fine. A file won't actually
be deleted until the last access is closed. However, the long-standing
problem with NFS is that it's `phony`. Basically, we send a message
to a server that says "Give me a directory listing...". The server
does the `opendir()` etc., and returns the results. If I want to
open a file on the server, the server has no knowledge of the `open`.
The client's software just emulated a file-system open(). When the
client wants to read data from a server's file, it sends a message;
"Gimmie data from file xxx, offset x, length y.". The server responds
with that data. To get that data, the server did an open/lseek/read/close.

So, as far as the server is concerned, that file is closed. Somebody
else (with privilege) can delete the file and replace it. The client,
the one that got the data for an executable, doesn't even know it.

This is 'nice' for the server, it doesn't have the overhead of maintaining
a file-system state. That's why servers are supposed to be read-only.
However, somebody has got to write the stuff to the file-system that's
going to (eventually) be read-only. Beware when such access occurs.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


