Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276905AbRJCHxQ>; Wed, 3 Oct 2001 03:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276906AbRJCHxG>; Wed, 3 Oct 2001 03:53:06 -0400
Received: from ns.suse.de ([213.95.15.193]:60429 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S276905AbRJCHwy>;
	Wed, 3 Oct 2001 03:52:54 -0400
To: Alex Larsson <alexl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <Pine.LNX.4.33.0110022206100.29931-100000@devserv.devel.redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Oct 2001 09:53:21 +0200
In-Reply-To: Alex Larsson's message of "3 Oct 2001 04:28:55 +0200"
Message-ID: <oupitdx9n2m.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Larsson <alexl@redhat.com> writes:

> I discovered a problem with the dnotify API while fixing a FAM bug today.
> 
> The problem occurs when you want to watch a file in a directory, and that 
> file is changed several times in the same second. When I get the directory 
> notify signal on the directory I need to stat the file to see if the 
> change was actually in the file. If the file already changed in the 
> current second the stat() result will be identical to the previous stat() 
> call, since the resolution of mtime and ctime is one second. 
> 
> This leads to missed notifications, leaving clients (such as Nautilus or 
> Konqueror) displaying an state not representing the current state.
> 
> The only userspace solutions I see is to delay all change notifications to 
> the end of the second, so that clients always read the correct state. This 
> is somewhat countrary to the idea of FAM though, as it does not give 
> instant feedback.
> 
> Is there any possibility of extending struct stat with a generation 
> counter? Or is there another solution to this problem?

make has similar problems with parallel builds on bigger multiprocessor
machines. Solaris7 has fixed this problem with adding new stat fields
to state that contains the ms for mtime/atime/ctime. There are even 
already filesystems on linux that support fine grained timestamps 
on linux, e.g. XFS has it as ns on disk. The problem is that VFS doesn't
support it currently, so it sets the ns parts always to zero. To fix 
it for m/c/atime requires new system calls for utime and stat64.
For stat is also requires a changed glibc ABI -- the glibc/2.4 stat64
structure reserved an additional 4 bytes for every timestamp, but these
either need to be used to give more seconds for the year 2038 problem
or be used for the ms fractions. y2038 is somewhat important too.

[In theory the existing additional bytes could be used for both on a
big endian host if you manage to define a numeric 48byte type in gcc
and be satisfied with 16bit ms resolution, but such a hack would
probably cause problems e.g. with other compilers. It would be
possible on Little Endian too, but only for mtime and ctime, as there
is no unused field in front of st_atime.  Overall I think a new stat
call is better. The ugly thing is just that the glibc ABI needs
updating too]

Solving it properly is a 2.5 thing.

-Andi


