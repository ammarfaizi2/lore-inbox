Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTCCMM2>; Mon, 3 Mar 2003 07:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264754AbTCCMM2>; Mon, 3 Mar 2003 07:12:28 -0500
Received: from daimi.au.dk ([130.225.16.1]:25824 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S264730AbTCCMM0>;
	Mon, 3 Mar 2003 07:12:26 -0500
Message-ID: <3E634916.6AE643EB@daimi.au.dk>
Date: Mon, 03 Mar 2003 13:22:46 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws> <20030302130430.GI45@DervishD> <3E621235.2C0CD785@daimi.au.dk> <20030303010409.GA3206@pegasys.ws>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
> 
> On Sun, Mar 02, 2003 at 03:16:21PM +0100, Kasper Dupont wrote:
> > And we should rather aim for an implementation
> > in /proc and have mount write there directly. But there are a few
> > open questions I'd like answered before trying to implement a
> > /proc/mtab.
> 
> You are talking about adding hacks to workaround the
> original hack.  Nothing should write to mtab.  Say it with
> me "Nothing should write to mtab".

You obviously haven't read all I have written. There is nothing
I'd like more than an implementation where the kernel could
always provide the correct information, and mount would never
have to store it anywhere else. However I don't know if that is
possible, and until somebody proves it possible, we will need
mtab.

There are three groups of options:
- VFS options
- Filesystem options
- Userspace options

The VFS options are given to the mount system call in a bitmask,
and they are available through the /proc/mounts pseudo file.

The filesystem options are more complicated. They are given to
mount in the data argument. When the filesystem is first mounted
it would be trivial to save the string and provide it in
/proc/mounts (or /proc/mtab). But if the filesystem is later
remounted with a different set of options, it is nontrivial to
know in general which parts should be taken from the old string,
and which parts should be taken from the new strings. Even some
of the filesystems have gotten this wrong and would read
uninitialized variables if a remount did not specify every single
possible option.

Finally the userspace options are used by mount itself. One example
is in the case of a user option being specified in /etc/fstab,
mount will store the name of the user calling mount in /etc/mtab.
I don't know if that kind of options are also given in the data
argument, but they have no business in the kernel, they are only
used by a feature implemented in userspace. But since they are
related to a mount point, it would be nice to have the kernel
delete them once the mountpoint is unmounted.

As long as these options is not yet stored in the kernel, we
need /etc/mtab. The question is how to get them into the kernel.
One possibility would be that mount could open /proc/mtab for
writing and write a single line in the usual format. Otherwise
we could extent mount with another string argument, or we could
put them into the data argument, where they really don't belong.

Since you seem to have some opinions on how this should be done,
I'd like to know how *you* would store those options.

Another problem is the device field, in the most common cases
/etc/mtab and /proc/mounts will contain the same. But in the
case of loopback mounts and bind mounts they are different.

I think the current value of the device field in /etc/mtab is
somewhat broken for bind mounts, because the source could be
unmounted before the target. The loopback case is not optimal
either, because it works differently if you manually use
losetup and if you let mount do it by specifying -o loop.
Sometimes it is desirable to let mount automatically detach
the loopback device even if it was not setup using -o loop,
but that is not always the case.

Before we can get rid of /etc/mtab we need to agree on how
to solve those problems. There might be other cases I don't
know about, where /etc/mtab contains special values.

The remaining fields is AFAIK no problem, the current
/proc/mounts implementation get them right. The target
field in /proc/mounts did get fixed with 2.4, and the
filesystem field also contains the right value. In the case
of bind mounts /etc/mtab will contain none in the filesystem
field, but I consider that to be a bug and /proc/mounts to
be correct. And finally the last two fields always contain
0, and only exist to keep the format identical with /etc/fstab.

> 
> mount(8) and umount(8) are the only almost the only things that
> write mtab all others are readers.

What are you saying? Are they the only writers, or are there
other writers? IIRC smbmount will write /etc/mtab on its own.

> I may be wrong but the
> data argument to mount(2) looks like it should support
> everything missing from /proc/mounts.

I don't think it has everything.

> Alternatively change
> mount(2) and mount(8) and any other mount(2) callers will
> be revealed.

Sounds like a good idea on a long term. Probably it should
be possible to get warnings from the kernel like it has been
done with other obsolete interfaces.

> 
> The reason to leave a /etc/mtab symlink is so that the
> old tools other than (u)mount don't need updates.

On a long term I agree with that. But first we need a
replacement for /etc/mtab. I have come with some suggestions,
but there are still a few blanks to fill in.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
