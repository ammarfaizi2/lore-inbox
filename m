Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSFMBo7>; Wed, 12 Jun 2002 21:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317397AbSFMBo6>; Wed, 12 Jun 2002 21:44:58 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:45965 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S317396AbSFMBo4>; Wed, 12 Jun 2002 21:44:56 -0400
Date: Thu, 13 Jun 2002 09:44:33 +0800 (PHT)
From: Federico Sevilla III <jijo@free.net.ph>
X-X-Sender: jijo@kalabaw
To: BugTraq Mailing List <bugtraq@securityfocus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Very large font size crashing X Font Server and Grounding Server to
 a Halt (was: remote DoS in Mozilla 1.0)
In-Reply-To: <20020610102006.A6947@lemuria.org>
Message-ID: <Pine.LNX.4.44.0206130908550.985-100000@kalabaw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

(Note: bug originally posted on BugTraq, this response is cross-posted to
the LKML because of the way the server hosting the X font server ground to
a halt.)

On Mon, 10 Jun 2002 at 10:20, Tom wrote:
> Affected
> ========
> Mozilla 1.0 and earlier
> verified on Linux and Solaris, other Unixes most likely affected as well.

Re-verified on Debian GNU/Linux running kernel 2.4.18-xfs with Mozilla
1.0.0 and XFree86 4.1.0 with the font server running on a separate server
also running on Debian GNU/Linux with kernel 2.4.18-xfs and the X font
server from XFree86 4.1.0.

The server running the X font server has 512MB RAM, 1GB swap, has one ext2
partition (/boot), one ReiserFS partition (Squid cache) and the rest are
XFS partitions. It also runs the kernel-mode NFS server v1.0 and Samba
2.2.4, among other things, and is typically headless.

> Effect
> ======
> System becomes unuseable or X windows crashes
> (varies depending on system configuration)

Here I had a workstation (that I thought 'hey, I can reboot this after
I've felt how the problem works') that used a remote font server, which
was company-wide. Yes, I'm the administrator so I killed myself. I've got
a personal note to myself, as well. "Don't try stuff posted on BugTraq on
anything connected to the network, dummy." ;)

Anyway, FWIW:

First I noticed that the Mozilla window stopped responding immediately. So
I closed it and breathed deeply. Then I noticed the server hosting the X
font server started thrashing really badly. /home is exported from the
same server via kernel-mode NFS, so file access to /home started freezing
on workstations. Samba access slowed down, but continued to work.

I was able to log on to the server with enough time to SIGKILL the
xfs-daemon process. Unfortunately this wasn't good enough. The server
started running up various processes stuck in "D" state, the OOM killer
went on panic mode and started killing things left and right, mostly from
what I notice apache and apache-ssl processes with messages like "Out of
Memory: Killed process xxxx (apache)". I was also able to do a `free`
after killing xfs-daemon and noticed that there was a lot of free memory
both physically and on swap.

Within less than ten minutes on this relatively lightly-loaded server, I
could not log in to the machine locally, even as root (whose home
directory is not NFS-exported) and load levels shot up to around 25, which
is definitely abnormal. Existing logged-on processes also got stuck in
whatever they were doing (`ps ax`, in particular is what I remember).

Attempted reboots locally via Ctrl-Alt-Delete and Magic SysRq failed
because (1) I had disabled ctrl-alt-delete mapping in inittab "for
security", and (2) I had not compiled Magic SysRq support on this
particular server. More notes to self.

> Description
> ===========
> When loading pages with a specially prepared (or erroneous) stylesheet,
> mozilla and X windows (not restricted to XFree) exhibit any of two
> undesireable behaviours. This seems to depend on the local system
> configuration, especially to the presence of xfs, but bug reports so far
> are inconclusive.
> In one scenario, X simply crashes, taking everything with it. This will result
> in the loss of unsaved work.
> In scenario two, memory useage of the X server explodes until the machine
> reaches the thrashing point, at which point only a hard kill (-9) of the
> X server can save it, provided there are enough system resources left to
> issue the kill.

In my case the workstation was easy to stabilize. I was actually able to
close all windows and exit xfce properly. It's the server running the X
font server that ground to painful halt. I do not know how things would
have been if I had the Magic SysRq enabled.

> The bug is triggered by a huge font setting done through CSS. Depending
> on the end user's system configuration, this will either trigger an
> abort in the XFree86 code ("Beziers this large not supported") or cause
> an explosive use of memory. It is unknown how much memory could get
> consumed, but follow-ups to the mozilla bug verify that machines with 1
> GB of memory still reach the thrashing point.

While I agree with BugTraq posts in response to this that applications
like Mozilla which accept font-sizes from unknown sources should have some
check to prevent such large sizes from crashing X and/or the X Font
Server, I'm alarmed by (1) the way the X font server allows itself to be
crashed like this, and (2) the way the entire Linux kernel seems to have
been unable to handle the situation. While having a central company or
department wide font server may not have been the best choice I made, this
seems like a simple way to drive a stake through a system's heart.

Suggestions on how to work around this on multiple levels would definitely
be appreciated. I'll be starting by removing the X font server from our
file and authentication server onto some high-powered workstation, but I'm
sure this won't be enough, and knowing that a user process like xfs-daemon
can drag the Linux kernel down to knees is not very comforting. :(

 --> Jijo

- -- 
Federico Sevilla III   :  <http://jijo.free.net.ph/>
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD4DBQE9B/kJ5rCBSJO3Rr4RAqYOAJ90o1C6RnU7Lgyu2mgP0XOwrL11yACWKIad
ksWA3s4feBrlFFXCX/pGlg==
=E751
-----END PGP SIGNATURE-----


