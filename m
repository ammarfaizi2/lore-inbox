Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbRBTWna>; Tue, 20 Feb 2001 17:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130197AbRBTWnK>; Tue, 20 Feb 2001 17:43:10 -0500
Received: from p91b.xDSL-1mm.sentex.ca ([64.7.134.220]:29943 "EHLO
	littleboy.jernet.localnet") by vger.kernel.org with ESMTP
	id <S130188AbRBTWnH>; Tue, 20 Feb 2001 17:43:07 -0500
Message-ID: <3A92F17E.BFEDEADD@sympatico.ca>
Date: Tue, 20 Feb 2001 17:36:46 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Dresser <mdresser@windsormachine.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <01022020011905.18944@gimli> <96uijf$uer$1@penguin.transmeta.com> <3A92DCE0.BEE5E90E@sympatico.ca> <3A92DF84.E39E415C@windsormachine.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Dresser wrote:

> the way i'm reading this, the problem is there's 65535 files in the directory
> /where/postfix/lives.  rm * or what have you, is going to take forever and
> ever, and bog the machine down while its doing it.  My understanding is you
> could do the rm *, and instead of it reading the tree over and over for every
> file that has to be deleted, it just jumps one or two blocks to the file that's
> being deleted, instead of thousands of files to be scanned for each file
> deleted.
>

I thought about it again, and the proformance problem with "rm *" is that
the shell reads and sorts the directory, passes each file as a separate
argument to rm, which then causes the kernel to lookup each file
from a random directory block (random because of previous sort),
modify that directory block, then read another... after a few seconds
the modified blocks start to be written back to disk while new ones
are looked up... disk seek contention.  and this becomes hard on the
dir. block cache (wherever this is) since from source each dir entry
is just over 256 bytes (?) 65535 files would require 16MB to
cache dir entries.  Plus it has to read in all the inodes, modify,
then write, taking up xxMB more.  You're probably swapping
out,  with swap partition on same disk, the disk may explode.

If it were truly doing a linear scan, it might be faster.  Two
successive mods to same dir block would be merged
onto same write.

Perhaps rm -rf . would be faster?  Let rm do glob expansion,
without the sort.  Care to recreate those 65535 files and try it?

or use ls with the nosort flag pipe through xargs then to rm...
again loose sorting but don't delete directory or subdirs.

>
> Jeremy Jackson wrote:
>
> > > In article <01022020011905.18944@gimli>,
> > > Daniel Phillips  <phillips@innominate.de> wrote:
> > > >Earlier this month a runaway installation script decided to mail all its
> > > >problems to root.  After a couple of hours the script aborted, having
> > > >created 65535 entries in Postfix's maildrop directory.  Removing those
> > > >files took an awfully long time.  The problem is that Ext2 does each
> > > >directory access using a simple, linear search though the entire
> > > >directory file, resulting in n**2 behaviour to create/delete n files.
> > > >It's about time we fixed that.
> >

