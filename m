Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311127AbSCLM53>; Tue, 12 Mar 2002 07:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311023AbSCLM5L>; Tue, 12 Mar 2002 07:57:11 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:62640 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S311127AbSCLM4w>; Tue, 12 Mar 2002 07:56:52 -0500
Date: Tue, 12 Mar 2002 12:55:43 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Malte Starostik <malte@kde.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Message-ID: <20020312125543.B4281@kushida.apsleyroad.org>
In-Reply-To: <200203120247.05611.malte@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203120247.05611.malte@kde.org>; from malte@kde.org on Tue, Mar 12, 2002 at 02:47:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Malte Starostik wrote:
> Imagine a file manager that has a view on a large directory like
> /usr/bin. Now a file in that directory is added / removed /
> changed. With dnotify, the filemanager will have to rescan the whole
> directory as a reaction to the signal, to find out which file has
> changed. OTOH, with FAM, it gets a precise event that tells "file
> `somebinary' has been added" or similar.

It would indeed be very cool if dnotify could say which inode has been
updated.  The problem I have with FAM is that notifications aren't
immediate, which makes it useless for my fast dynamic web server
application.  For that, notifications have to be strong enough to
support the rule "if I have not received a dnotify _now_, then my cached
stat() result is valid for files in that directory _now_".

> I don't have much of a clue about the kernel, so please excuse my ignorance, 
> but the imon patch seems pretty unintrusive to me and enables more 
> fine-grained file change notifications than dnotify. Also, FAM can monitor 
> NFS-mounted directories with almost no network overhead when it's also 
> running on the server.

Ah, thanks, I didn't know about imon.

The imon API is nice -- I could use that and more efficiently than
dnotify.  (I can't use FAM because of notification delays, but the imon
device is just right).

Unfortunately the implementation is rather intrusive.  As it says, it
implies a performance hit on every file operation on all files, if any
file is being monitored.  So I can see it being disabled on high
performance servers, which is where I need it.

A fusion of imon and dnotify would be good:

   - absolute minimum impact on file operations: a small inline check,
     per inode not globally, as dnotify does now.

   - imon-style hash table used for inodes that aren't in core, so you
     can monitor a large number of files individually without pulling
     their inodes into core.  When inodes are brought into core then the
     hash table entries are moved to the in core inode, and vice versa.

     (Not sure about the reliability of hashing on inode numbers,
     though -- some filesystems don't provide reliable inode numbers).

   - dnotify-style lists of monitoring requests attached to in core
     inodes.

   - per-process monitoring sets, as dnotify does.

   - imon-style precision notification of individual files, including
     reliably monitoring files which are hard linked in different
     directories.

   - dnotify causes files to notify their parent directory (yes it's
     ambiguous with hard links).  In a per-file scheme, one possible
     flag on a file's inode would be "notify my parent directory".  I
     see no reason not to extend that to "I am a directory.  If I
     receive a notification from a child, notify _my_ parent directory",
     for those occasions when you'd like to monitor a whole directory
     hierarchy without having to do the equivalent slow disk accesses of
     "find -print" on it first.

   - guarantee that the event will be sent to the monitoring process
     immediately after the operation which triggers the event, and
     before the operation releases inode semaphore, if it has it -- so
     that monitoring processes can depend on "if I haven't received a
     notification then my stat() cache is still valid".

Some ideas.  I would really like this to be usable with my idea for a
fast dynamic web server, which is also a "make" server, so I'm willing
to put some work in here.

Feedback appreciated,
-- Jamie
