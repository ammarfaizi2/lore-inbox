Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSKDB36>; Sun, 3 Nov 2002 20:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264613AbSKDB36>; Sun, 3 Nov 2002 20:29:58 -0500
Received: from astron.Berkeley.EDU ([128.32.92.108]:46834 "EHLO
	astron.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S262796AbSKDB34>; Sun, 3 Nov 2002 20:29:56 -0500
Date: Sun, 3 Nov 2002 17:36:28 -0800 (PST)
From: James Colby Kraybill <colby@astro.berkeley.edu>
To: linux-kernel@vger.kernel.org
Subject: Bad Descriptor error (autofs/nfs)
Message-ID: <Pine.GSO.4.44.0211031717220.768-100000@celestial>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I am attempting to integrate some RedHat 7.3 based Linux machines
into a pre-existing network of ~150 sunsparc solaris machines.

I have run across an odd problem which did not yield to many
google web and usetnet searches.

Here's the problem:

I am logged into the machine and everything  seems to work
fine interoperating with the solaris machines.  User directories
are mounted via NFS (using autofs), so, I try to do an ls of another
user's directory and get the following:

% ls ~user
ls: write error: Bad file descriptor

I can cd ~user and run ls and it works fine, I see the
files in the user's directory.
If I cd ~ and then do the ls ~user again, it works fine,
I see the files in the user's directory.  So, it's as if
some table somewhere isn't properly uptodate on the
intial ls.

When I run strace on both instances, I see everything
looking about the same (except for some pointers and
file descriptor numbers being different) up to this
point:

ioctl(1, SNDCTL_TMR_TIMEBASE, 0xbffff550) = -1 EBADF (Bad file descriptor)
ioctl(1, 0x5413, 0xbffff618)            = -1 EBADF (Bad file descriptor)

Under the "correctly" working one, I see this:

ioctl(1, SNDCTL_TMR_TIMEBASE, 0xbffff560) = -1 ENOTTY (Inappropriate ioctl
for device)
ioctl(1, 0x5413, 0xbffff628)            = -1 ENOTTY (Inappropriate ioctl
for device)

In the case of the Bad descriptor, there are more error messages
further into ls that also return EBADF, but there are _no_ EBADF's in
the "correctly" running one.

Here is why I think this might be a kernel related problem:

I am running autofs.  When I do the ls ~user, the correct
disk does get mounted, but it will still return the EBADF
message.  When I cd into the directory, and do the ls,
it works fine.  And from that point on, I can ls ~user
with impunity, unless I let the automounter unmount
the disk automatically.  Then the same thing starts
happening.  Perhaps there is something in the way that
the file system routines are failing to
create a fully proper file descriptor until some other
init routine runs by cd'ing to the disk (causing
a different cascade of stat's to be executed?)

The autofs version is autofs-3.1.7-28

Other important information:

I am using nis+.  The user information is coming from
the nis+ server. The nis utils are version 1.4.1

Output of ver_linux:

Linux lynx 2.4.18-17.7.xcustom #2 Mon Oct 28 13:15:36 PST 2002 i686
unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         binfmt_misc vmnet parport_pc parport vmmon autofs
nfs lockd sunrpc natsemi ipchains ide-cd cdrom ext3 jbd
usb-uhci usbcore

Thanks in advance for any advice on this.

---------------------------------------------------------------------
James Colby Kraybill                       Radio Astronomy Laboratory
colby@astro.berkeley.edu           University of California, Berkeley




