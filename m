Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311278AbSCLRXJ>; Tue, 12 Mar 2002 12:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311279AbSCLRW7>; Tue, 12 Mar 2002 12:22:59 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:61361 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S311278AbSCLRWs>; Tue, 12 Mar 2002 12:22:48 -0500
Date: Tue, 12 Mar 2002 17:21:01 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Malte Starostik <malte@kde.org>, linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Message-ID: <20020312172101.A5075@kushida.apsleyroad.org>
In-Reply-To: <200203120247.05611.malte@kde.org> <20020312125543.B4281@kushida.apsleyroad.org> <E16kpHc-0002Lx-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16kpHc-0002Lx-00@starship>; from phillips@bonn-fries.net on Tue, Mar 12, 2002 at 05:37:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On March 12, 2002 01:55 pm, Jamie Lokier wrote:
> >    - dnotify causes files to notify their parent directory (yes it's
> >      ambiguous with hard links).
> 
> That's a bitch, isn't it?  The only way I can think of to deal with it
> is via a hardlink reverse map, and there are lots of worms in that
> can, including where you store it, how much it costs to maintain it,
> how persistent it should be and how to make it perfectly non-racy.

For dnotify purposes this may be solvable without a full reverse map.
Suppose that we have per-inode notifiers as I suggested, and as the imon
patch implements.  Of course, multiple listeners can attach to an
inode's notifier chain -- this is needed to support multiple processes
listening.

Then you can implement dnotify by attaching the parent directory as a
listener to each of its child inodes.  (It's a bit heavy to set up,
though).

Now, when an inode is modifed we don't guarantee to notify all the
parent directories...  but we do guarantee to notify all the ones which
are actually listening at the moment.  So it's a partial reverse map.  I
expect Al Viro would have something to say about dcache races at this
point.

For recursive parent notification, such as monitoring "/usr" to learn
about changes anywhere underneath "/usr", the above is perhaps
impractical.  We're right back to having to do "find -print" equivalent
disk activity.  Or reverse maps in the filesystem.  Ugh.

In practice I'd just give up trying to cache stat() results of hard
linked files, unless I knew I'd found all the paths to those files.
Just don't use hard links ;-)

cheers,
-- Jamie


