Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUD1Nr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUD1Nr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264793AbUD1Nr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:47:58 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:7835 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264795AbUD1NrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:47:16 -0400
Date: Wed, 28 Apr 2004 08:50:40 -0500 (CDT)
From: Brent Cook <busterbcook@yahoo.com>
X-X-Sender: busterb@ozma.hauschen
Reply-To: busterbcook@yahoo.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
In-Reply-To: <20040427230203.1e4693ac.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
 <20040427230203.1e4693ac.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Andrew Morton wrote:

> Brent Cook <busterbcook@yahoo.com> wrote:
> >
> >   Running any kernel from the 2.6.6-rc* series (and a few previous
> >  -mm*'s),
>
> It's a shame this wasn't reported earlier.

Since it was a pretty big deal on my system, I just assumed it was for
other people's too, and that someone else would have reported it by
now. I only got concerned when it persisted between rc's.

> > the pdflush process starts using near 100% CPU indefinitely after
> >  a few minutes of initial NFS traffic, as far as I can tell.
>
> Please confirm that the problem is observed on the NFS client and not the
> NFS server?  I'll assume the client.

Yes, both affected machines had the issue when connecting as a client to a
2.4.25-based NFS server.

> What other filesystems are in use on the client?

One uses Reiser on /, the other uses ext3 on /. Here is the mount table
for one machine:

/dev/hda3 on / type ext3 (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
ozma:/home on /home type nfs (rw,addr=192.168.1.1)

Running 2.6.6-rc2-mm1,
Here is a shot compiling KDE with the source on the NFS mount,
-j2. This is the initial state:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
12091 busterb   25   0 63524  59M  5140 R    38.4 23.8   0:19   0 cc1plus
12199 busterb   25   0 55660  52M  5140 R    38.0 20.8   0:07   0 cc1plus
    7 root      16   0     0    0     0 SW    4.9  0.0   0:03   0 pdflush

About 10 minutes into the process, pdflush starts taking over:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
    7 root      25   0     0    0     0 RW   34.4  0.0   3:05   0 pdflush
17856 busterb   25   0 69400  65M  5140 R    34.4 26.1   0:31   0 cc1plus
19466 busterb   25   0 43732  39M  5140 R    26.3 15.5   0:03   0 cc1plus

After stopping the compile, pdflush remains until a reboot:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
    7 root      25   0     0    0     0 RW   98.0  0.0   3:21   0 pdflush

The network light will flash continually on each machine once pdflush
gets into this state, which makes me think NFS. Each machine has
512-256 MB of ram and a single CPU.

 - Brent
