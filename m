Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269482AbRHCRZc>; Fri, 3 Aug 2001 13:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269490AbRHCRZS>; Fri, 3 Aug 2001 13:25:18 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:53168 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S269482AbRHCRYt>; Fri, 3 Aug 2001 13:24:49 -0400
Date: Fri, 3 Aug 2001 13:24:57 -0400
To: Lawrence Greenfield <leg+@andrew.cmu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010803132457.A30127@cs.cmu.edu>
Mail-Followup-To: Lawrence Greenfield <leg+@andrew.cmu.edu>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080317471707.01827@starship> <20010803121638.A28194@cs.cmu.edu> <0108031854120A.01827@starship> <Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva> <s5gvgkacqlm.fsf@egghead.curl.com> <200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0108031854120A.01827@starship> <200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 06:54:12PM +0200, Daniel Phillips wrote:
> On Friday 03 August 2001 18:16, Jan Harkes wrote:
> > On Fri, Aug 03, 2001 at 05:47:17PM +0200, Daniel Phillips wrote:
> > > On Friday 03 August 2001 17:18, Jan Harkes wrote:
> > > > Working on a distributed filesystem with somewhat weaker than UNIX
> > > > semantics might have skewed my vision. In Coda not every client will be
> > > > able to figure out which are all of the possibly paths that can lead to
> > > > a file object. And although we currently try our best to block
> > > > hardlinked directories they could possibly exist, making the problems
> > > > even worse.
> > >
> > > We don't need all the paths, and not any specific path, just a path.
> >
> > Even if that path leads to a name that got removed, thereby forcing the
> > object into lost+found? I thought the MTA did something like,
> 
> We'd better get confirmation from the MTA expert in the thread.
> 
> > fd = open(tmp/file)
> > write(fd)
> > fsync(fd)
> > link(tmp/file, new/file)
> > fsync(fd)		*1
> > unlink(tmp/file)
> >
> > *1 If this fsync only syncs the path leading to tmp/file, and the unlink
> > tmp/file is written back to disk, which is likely because we're only
> > creating/syncing stuff in tmp.  Now, until new/file is written there is
> > no path information leading to the file anymore which makes this as
> > 'safe' as not syncing path name information at all.
> 
> Nice clear example!  Yes, in essence we would have synced the original
> path twice.  If this is what the MTA is really doing I'm willing to join
> the "MTA is broken" camp.

Here is the relevant mail,

On Mon, Jul 30, 2001 at 01:11:32PM -0400, Lawrence Greenfield wrote:
} BSD softupdates allows you to call fsync() on the file, and this will
} sync the directories all the way up to the root if necessary.
} 
} Thus BSD fsync() actually guarantees that when it returns, the file
} (and all of it's filenames) will survive a reboot.
} 
} Sendmail does:
} fd = open(tmp)
} write(fd)
} fsync(fd)
} rename(tmp, final)
} fsync(fd)
} 
} Cyrus IMAP does:
} fd = open(tmp)
} write(fd)
} fsync(fd)
} link(tmp, final1)
} link(tmp, final2)
} link(tmp, final3)
} fsync(fd)
} close(fd)
} unlink(tmp)
} 
} The idea that Linux fsync() doesn't actually make the file survive
} reboots is pretty ridiculous.

As you can see, the 'sync a path leading to the file' semantics from SuS
don't work in the Cyrus IMAP case as is specifically requires to have
_all_ paths committed to disk before fsync returns.

On Fri, Aug 03, 2001 at 06:54:12PM +0200, Daniel Phillips wrote:
> On Friday 03 August 2001 18:16, Jan Harkes wrote:
> > Now if the application would use the directory sync, it can actually
> > tell the kernel that that new/file name is the interesting one to keep
> > and that tmp doesn't even need to be written to disk at all.
> 
> Yep.  Or if it used rename, which updates the dcache entries, instead
> of link/unlink.

MTA's that want to do reliable deliveries using multiple processes (or
on a networked filesystem) tend to not use rename because it implicitly
unlinks the target if it already exists and this could lead to loss of
mail that was already considered as being delivered.

Jan

