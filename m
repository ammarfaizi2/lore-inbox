Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281068AbRKTVtR>; Tue, 20 Nov 2001 16:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281288AbRKTVtH>; Tue, 20 Nov 2001 16:49:07 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:19984 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S281068AbRKTVsx>; Tue, 20 Nov 2001 16:48:53 -0500
Message-Id: <200111202134.fAKLYSt15090@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Mike Fedyk <mfedyk@matchmail.com>, Steffen Persvold <sp@scali.no>
Subject: Re: Swap
Date: Tue, 20 Nov 2001 15:33:28 -0600
X-Mailer: KMail [version 1.3.1]
Cc: Christopher Friesen <cfriesen@nortelnetworks.com>, root@chaos.analogic.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1011120111730.7650A-100000@chaos.analogic.com> <3BFAC5A1.81474E74@scali.no> <20011120131839.B4210@mikef-linux.matchmail.com>
In-Reply-To: <20011120131839.B4210@mikef-linux.matchmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 November 2001 15:18, Mike Fedyk wrote:
> On Tue, Nov 20, 2001 at 10:05:37PM +0100, Steffen Persvold wrote:
> > Christopher Friesen wrote:
> > > "Richard B. Johnson" wrote:
> > > > On Tue, 20 Nov 2001, Wolfgang Rohdewald wrote:
> > > > > On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > > > > > When a page is deleted for one executable (because we can re-read
> > > > > > it from on-disk binary), it is discarded, not paged out.
> > > > >
> > > > > What happens if the on-disk binary has changed since loading the
> > > > > program? -
> > > >
> > > > It can't. That's the reason for `install` and other methods of
> > > > changing execututable files (mv exe-file exe-file.old ; cp newfile
> > > > exe-file). The currently open, and possibly mapped file can be
> > > > re-named, but it can't be overwritten.
> > >
> > > Actually, with NFS (and probably others) it can.  Suppose I change the
> > > file on the server, and it's swapped out on a client that has it
> > > mounted.  When it swaps back in, it can get the new information.
> >
> > This sounds really dangerous... What about shared libraries ??
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

*Any* time that you write to an executing executable, all bets are off.  The 
most likely outcome is a big 'ol crash & burn.  With a local FS, Unix 
prevents you from shooting yourself in the foot, but with NFS, fire away..  
I've done it.  It *does* let you, but...

Solution:  Don't do that.  Shut them all down, on all clients, upgrade the 
binaries, then restart the processes on the clients.

As far as the scenerio that you've described, I *think* that it would 
actually work.  When the new process is fork()ed, it gets a copy of the file 
descriptors from it's parent, so the file is still open to it.  If it the 
exec()s, the new image no longer has any real ties to it's parent (at least, 
not that are relevant to this).

If it's created via clone(), then, once again, it's got it's parents 
descriptors still open, so no problem.

I think the real problems only exist over NFS and NFS-like scenerios.

Did I miss something here, or am I actually correct?  I was correct once, 
let's see...  Ooops.  That was a mistake too.

-Nick
