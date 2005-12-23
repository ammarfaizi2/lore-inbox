Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVLWBji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVLWBji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 20:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVLWBjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 20:39:37 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:27144 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S1751235AbVLWBjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 20:39:37 -0500
From: Ron Peterson <rpeterso@MtHolyoke.edu>
Date: Thu, 22 Dec 2005 20:39:34 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs insecure_locks / Tru64 behaviour
Message-ID: <20051223013933.GB22949@mtholyoke.edu>
References: <20051222133623.GE7814@mtholyoke.edu> <1135293713.3685.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1135293713.3685.9.camel@lade.trondhjem.org>
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 06:21:53PM -0500, Trond Myklebust wrote:
> On Thu, 2005-12-22 at 08:36 -0500, Ron Peterson wrote:
> > If I mount a linux export on Tru64, it seems the execute bit for 'other'
> > needs to be set on a directory in order edit files within it using vi.
> > 'Nobody' and 'nogroup' also appear to be special.
> 
> read all about the "no_root_squash" option

I understand that.  The thing that makes them special is that aside from
nobody and nogroup, the ownership of the directory has no impact on my
ability to edit a file in that directory.  Besides that, I'm not editing
as root.  If neither nobody or nogroup owns the directory, the execute
bit must be set for 'other' (chmod o+x) or no files in that directory
can be edited.

> As for your problem accessing files in the directory
> 
> drwxr-x---  2 root     system  4096 Dec 22 08:22 d/
> 
> as an unprivileged user on group 'kmw', the solution is obvious:
> 
> 'chgrp kmw d'
> 
> or
> 
> chmod a+x d

That's exactly the problem.  The first obvious solution doesn't work.
Your second solution does.  The directory must have the execute bit set
for other, or the the file cannot be edited, no matter who owns the
directory (unless the owner/group is nobody/nogroup).

Skøl

-Ron-

> Cheers,
>   Trond
> 
> > I'm running 2.6.14.3 on Debian Sarge.
> > 
> > For example.
> > 
> > On linux, in directory /db/test:
> > 
> > 1185# ll
> > total 16
> > drwxr-x--x  2 root     kmw     4096 Dec 21 22:39 a/
> > drwxr-x---  2 nobody   kmw     4096 Dec 21 22:39 b/
> > drwxr-x---  2 rpeterso nogroup 4096 Dec 21 22:46 c/
> > drwxr-x---  2 root     system  4096 Dec 22 08:22 d/
> > 
> > where /etc/exports looks like
> > 
> > /db/test  \
> >               depot.p(rw,sync) \
> >               polar.p(rw,sync,insecure_locks)
> > 
> > I mount this on Tru64 like:
> > 
> > mount -o tcp yogi.p:/db/test dbtest
> > 
> > Each directory a,b,c,d has a small text file named 'test':
> > 
> > -rw-rw-r--  1 root kmw 5 Dec 21 22:39 test
> > 
> > As a user in group kmw I can edit this file in directory a, b, and c.  I
> > can't edit the file in directory d.
> > 
> > I understand that Tru64 doesn't send matching credentials with nfs lock
> > requests.  The 'insecure_locks' option seems to help work around
> > permission problems on the files themselves, but doesn't seem to work
> > around the permissions of the owning directory.
> > 
> > It's probably fair to point fingers at Tru64, but it seems unlikely
> > there will be any changes to nfs on that side...
> > 
> > I'm not subscribed the lkml, so cc's are appreciated.
> > 
> > Best.
> > 
-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://pks.mtholyoke.edu:11371/pks/lookup?search=0xB6D365A1&op=vindex
