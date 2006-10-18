Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWJRRWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWJRRWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWJRRWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:22:12 -0400
Received: from pat.uio.no ([129.240.10.4]:64907 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1422668AbWJRRWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:22:10 -0400
Subject: Re: [REGRESSION] nfs client: Read-only file system (2.6.19-rc1,2)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Sven Hoexter <shoexter@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <45364C51.2000004@gmail.com>
References: <4534F59D.4040505@gmail.com>
	 <1161104051.5559.5.camel@lade.trondhjem.org> <eh4hhb$sp7$1@sea.gmane.org>
	 <4535EB4F.4070406@gmail.com>  <45364C51.2000004@gmail.com>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 13:22:01 -0400
Message-Id: <1161192121.6095.58.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.823, required 12,
	autolearn=disabled, AWL 1.18, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 17:46 +0200, Jiri Slaby wrote:
> Jiri Slaby wrote:
> > Do not remove CCs.
> > Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
> > Cc: Jiri Slaby <jirislaby@gmail.com>
> > 
> > Sven Hoexter wrote:
> >> Trond Myklebust wrote:
> >>> On Tue, 2006-10-17 at 17:24 +0200, Jiri Slaby wrote:
> >>
> >> Hi,
> >>
> >>>> I can't write on mounted nfs filesystem since 2.6.19-rc1 (nfs client):
> >>>> touch: cannot touch `aaa': Read-only file system
> >>>>
> >>>> strace says:
> >>>> open("aaa", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 0666) 
> >>>> = -1
> >>>> EROFS (Read-only file system)
> >>>>
> >>>> 2.6.18 behaves correctly. Settings are the same, does anybody have any
> >>>> clue?
> >>> What does "cat /proc/mounts" say?
> >> Ok I'm not the OP but I can confirm the problem.
> >>
> >>> From /proc/mounts:
> >> arthur:/mnt/disk2/mp3 /mnt/mp3 nfs 
> >> ro,nosuid,nodev,noexec,vers=3,rsize=8192,wsize=8192,hard,proto=tcp,timeo=600,retrans=2,sec=sys,addr=arthur 
> >> 0 0
> >>
> >> Reports ro here while mount still reports rw:
> >> arthur:/mnt/disk2/mp3 on /mnt/mp3 type nfs 
> >> (rw,noexec,nosuid,nodev,addr=192.168.88.80)
> > 
> > I will post my output in some hours, if still needed.
> 
> The very same thing. /etc/mtab still reports rw, while /proc/mounts says ro, weird.

I'll bet that you have always had a subdirectory of the exact same
filesystem mounted somewhere else ro, right?

The new NFS mount code will put those in the same superblock, and
whichever directory gets mounted first will determine whether or not the
superblock is marked as read-only.
Basically, NFS is now doing the exact same thing that local filesystems
have been doing all the time: if it is on the same disk, then it is all
represented by the same superblock. OTOH, if your server is exporting
more than one partition, then different partitions will be represented
by different superblocks.
We need to do this for the same reason that local filesystems do it: it
is the only way to ensure cache consistency. Otherwise, if you make
changes to a file that happens to be mounted in more than one place,
then you will see inconsistent results on the other mountpoints.

Per-mountpoint control over the 'ro' flag (i.e. to allow you to do
'mount --bind -oro /foo /bar') is a separate issue that needs further
work at the VFS level.

Cheers,
  Trond

