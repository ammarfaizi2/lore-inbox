Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131603AbRCSWWu>; Mon, 19 Mar 2001 17:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131625AbRCSWWj>; Mon, 19 Mar 2001 17:22:39 -0500
Received: from smtp2.sentex.ca ([199.212.134.9]:11780 "EHLO smtp2.sentex.ca")
	by vger.kernel.org with ESMTP id <S131603AbRCSWWa>;
	Mon, 19 Mar 2001 17:22:30 -0500
Message-ID: <3AB6850A.4D7FDA26@coplanar.net>
Date: Mon, 19 Mar 2001 17:15:38 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Brian Gerst <bgerst@didntduck.org>, Otto Wyss <otto.wyss@bluewin.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux should better cope with power failure
In-Reply-To: <Pine.LNX.3.95.1010319162020.12070A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> On Mon, 19 Mar 2001, Brian Gerst wrote:
> [SNIPPED...]
>
> >
> > At the very least the disk should be consistent with memory.  If the
> > dirty pages aren't written back to the disk (but not necessarily removed
> > from memory) after a reasonable idle period, then there is room for
> > improvement.
> >
>
> Hmmm. Now think about it a minute. You have a database operation
> with a few hundred files open, most of which will be deleted after
> a sort/merge completes. At the same time, you've got a few thousand
> directories with their ATIME being updated. Also, you have thousands
> of temporary files being created in /tmp during a compile that didn't
> use "-pipe".
>
> If you periodically write everything to disk, you don't have many
> CPU cycles available to do anything useful.
>
> It is up to the application to decide if anything is 'precious'.
> If you've got some database running, it's got to be checkpointed
> with some "commitable" file-system so it can be interrupted at any time.
>
> If you make your file-systems up of "slices", you can mount the
> executable stuff read/only. Currently, only /var and /tmp need to
> be writable for normal use, plus any user "slices", of course.
>  -- Yes I know you need to modify /etc/stuff occasionally (startup
> and shutdown, plus an occasional password change). I proposed
> a long time ago that /etc/mtab get moved to /var.

so how does mount update /var/mtab when mounting var? he he.

Actually, I think /etc/mtab is not needed at all.   Originally, UNIX
used to put as much onto the disk (and not in "core") as possible.
so much state information related only to one boot-cycle was
taken out of kernel and stored on disk.  /var/run/utmp, /etc/mtab,
, rmtab,  and many others.  all are invalidated by a reboot, and are yet
stored
in non-volatile storage.  kernel memory is not swappable, so they manually
separated out the minimum needed in core.

Linux currently has a lot of this info in core, and maintains the disk files
for backwards compatibility.  in the case of /etc/mtab, I believe
/proc/mounts
has the same info.  It appears to be in the same format as /etc/mtab,
so most of the groundwork has already been done.
i've considered trying just changing /etc/mtab to /proc/mounts in some
utilities, to remove the need for read-write root.  This (and other cases)
would guarantee consistency (look at /etc/mtab after restart in single
user more - ugh)

I wonder if embedded folks would like to at least keep the old behaviour
as a compile-time option;  they're in almost the same boat as early (64k
core memory) unix folks.

My favorite compromise between journaling and performance is the
compaq smart array controllers, with a battery-backed sram
write cache;  they can do (fast)lazy writes and still be perfectly reliable.
plus they keep *everything* reliable, not just metadata.

I find this a fascinating topic... the ultimate would be to use the nvram
(it's mostly empty if using LinuxBIOS)  to store a clean shutdown flag,
and/or a system heartbeat timestamp (like syslogd's)... only this timestamp
would let the hdd spin down (not hit every 20 minutes or so with a timestamp
log entry) and not wear out a flash disk based system.

Regards,

Jeremy

