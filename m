Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbRBTXhw>; Tue, 20 Feb 2001 18:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130899AbRBTXhm>; Tue, 20 Feb 2001 18:37:42 -0500
Received: from hermes.mixx.net ([212.84.196.2]:64520 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129767AbRBTXhe>;
	Tue, 20 Feb 2001 18:37:34 -0500
From: Daniel Phillips <phillips@innominate.de>
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>,
        Mike Dresser <mdresser@windsormachine.com>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Date: Wed, 21 Feb 2001 00:08:35 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01022020011905.18944@gimli> <3A92DF84.E39E415C@windsormachine.com> <3A92F17E.BFEDEADD@sympatico.ca>
In-Reply-To: <3A92F17E.BFEDEADD@sympatico.ca>
MIME-Version: 1.0
Message-Id: <01022100361408.18944@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Jeremy Jackson wrote:
> Mike Dresser wrote:
> 
> > the way i'm reading this, the problem is there's 65535 files in the directory
> > /where/postfix/lives.  rm * or what have you, is going to take forever and
> > ever, and bog the machine down while its doing it.  My understanding is you
> > could do the rm *, and instead of it reading the tree over and over for every
> > file that has to be deleted, it just jumps one or two blocks to the file that's
> > being deleted, instead of thousands of files to be scanned for each file
> > deleted.
> 
> I thought about it again, and the proformance problem with "rm *" is that
> the shell reads and sorts the directory, passes each file as a separate
> argument to rm, which then causes the kernel to lookup each file
> from a random directory block (random because of previous sort),
> modify that directory block, then read another... after a few seconds
> the modified blocks start to be written back to disk while new ones
> are looked up... disk seek contention.  and this becomes hard on the
> dir. block cache (wherever this is) since from source each dir entry
> is just over 256 bytes (?) 65535 files would require 16MB to
> cache dir entries.  Plus it has to read in all the inodes, modify,
> then write, taking up xxMB more.  You're probably swapping
> out,  with swap partition on same disk, the disk may explode.
> 
> If it were truly doing a linear scan, it might be faster.  Two
> successive mods to same dir block would be merged
> onto same write.
> 
> Perhaps rm -rf . would be faster?  Let rm do glob expansion,
> without the sort.  Care to recreate those 65535 files and try it?
> 
> or use ls with the nosort flag pipe through xargs then to rm...
> again loose sorting but don't delete directory or subdirs.

Indeed, rm -rf is faster.  It does a readdir to get all the directory
entries in internal order, then calls unlink to remove them, one at a
time.  This removes each entry from the front of the file, shortening
the time that has to be spent scanning forward in the file to find the
target entry.  Manfred Spraul observed that this could be speeded up
with by caching the file position, and sent me a patch to do that.  It
did speed things up - about 20%.

But actually, rm is not problem, it's open and create.  To do a
create you have to make sure the file doesn't already exist, and
without an index you have to scan on average half the directory file. 
Open requires a similar scan.  Here we are talking about using an index
to speed that up quadraticly when operating on N files.  That is the
real gravy.

-- 
Daniel
