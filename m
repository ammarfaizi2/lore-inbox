Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSILNa7>; Thu, 12 Sep 2002 09:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSILNa7>; Thu, 12 Sep 2002 09:30:59 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:55820 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S315503AbSILNa6>; Thu, 12 Sep 2002 09:30:58 -0400
Date: Thu, 12 Sep 2002 06:35:47 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Heuristic readahead for filesystems
Message-ID: <20020912063547.A5033@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20020912004520.GD10315@pegasys.ws> <Pine.LNX.3.95.1020912072949.2700A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.3.95.1020912072949.2700A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Sep 12, 2002 at 07:41:09AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 07:41:09AM -0400, Richard B. Johnson wrote:
> On Wed, 11 Sep 2002, jw schultz wrote:
> 
> > On Wed, Sep 11, 2002 at 03:21:37PM -0400, Richard B. Johnson wrote:
> > > On Wed, 11 Sep 2002, Oliver Neukum wrote:
> > > > No, it won't. But it would solve the issue of reading ahead.
> > > > Stating needs a kernel implementation of 'stat ahead'
> > > > -
> > > 
> > > I think this is discussed in the future. Write-ahead is the
> > > next problem solved. ?;)
> > 
> > Gating back to the original issue which was "readahead" of
> > stat() info...
> > 
> > The userland open of a directory could trigger an advance
> > reading of the directory data and of the inode structs of
> > all it's immediate members.  Almost all instances of a
> > usermode open on a directory will be doing fstats.  Even a
> > command line ls often has options (colour, -F, etc) turned on
> > by default that require fstat on all the entries.
> > The question would be how far ahead of the user app would
> > the kernel be.
> > 
> > I could possibly see having a fcntl() for directories to
> > pre-read just the first block of each file to accelerate
> > file-managers that use magic and perhaps forestall readahead
> > pulling in more than magic will use.
> 
> Then you are tuning a file-system for a single program
> like `ls`. Most real-world I/O to file-systems are not done
> by `ls` or even `make`. The extra read-ahead overhead is

Most real-world filesystem I/O doesn't open(2) directories.
Most filesystem I/O is stat, open and unlink of files with
full paths, no open(2) of the directory.  Notice that i
refer to the system call not internal functions that path
lookup invoke.  The list of things that open(2) directories
is very short and almost all of them stat the the majority
of the directory's contents.

> just that, 'overhead'. Since the cost of disk I/O is expensive,
> you certainly do not want to read any more than is absolutely
> necessary. There had been a lot so studies about this in the
> 70's when disks were very, very, slow. The disk-to-RAM speed
> ratio hasn't changed much even though both are much faster.
> Therefore, the conclusions of these studies, made by persons
> from DEC and IBM, should not have changed. From what I recall,
> all studies showed that read-ahead always reduced performance,
> but keeping what was already read in RAM always increased
> performance.

I'm sure there will be others that can show you the numbers.
Things have changed since those studies.  Disks are still
slooooooooow.  However the OS doesn't have to nursemaid the
transfer.  In most cases we queue requests and receive an
interrupt when the data is in memory.  _IF_ the disk 
isn't otherwise kept busy readahead reduces latency.
Most of the associated blocks have near proximity so there
is a good chance to do the readahead in a minumum number of
requests if they are fed to the queues in a batch.

> > The question would be how far ahead of the user app would
> > the kernel be.
I repeat this because i think it is a central point.  Much
of the I/O associated with directory scanning is in tight
loops that would mirror the kernel's behavior.  I have
doubts that it would produce a performance boost because it
might just be a synchronized duplication of effort.

I am not advocating doing this.  I was just exploring the
idea and bringing the thread back to the original question.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
