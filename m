Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSKCTb6>; Sun, 3 Nov 2002 14:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSKCTb6>; Sun, 3 Nov 2002 14:31:58 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:41695 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S262387AbSKCTbu>; Sun, 3 Nov 2002 14:31:50 -0500
Date: Sun, 3 Nov 2002 14:38:22 -0500
From: Matt Zimmerman <mdz@debian.org>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: team@security.debian.org, nethack@packages.debian.org,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Nethack setgid screwup
Message-ID: <20021103193822.GT31490@mizar.alcor.net>
Mail-Followup-To: Aaron Lehmann <aaronl@vitelus.com>,
	team@security.debian.org, nethack@packages.debian.org,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <20021103050042.GA25215@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103050042.GA25215@vitelus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 09:00:42PM -0800, Aaron Lehmann wrote:

> ----- Forwarded message from Alexander Viro <viro@math.psu.edu> -----
> On Sat, 2 Nov 2002, Linus Torvalds wrote:
> 
> > But I like Al's idea of mount binds even more, although it requires maybe
> > a bit more administration.
> 
> OK, will do - will be fun to take a break from drivers/* and devfs excrements
> I'm digging in...
> 
> BTW, here's a fresh demonstration (found half an hour ago) that capabilities
> do *not* permit more lax attitude when writing stuff with elevated priveleges:
> 	* /usr/lib/games/nethack/recover is run at the boot time (as root)
> to recover crashed games.
> 	* Debian nethack 3.4.0-3.1 has it installed root.games and it
> is group-writable - cretinism in debian/rules, upstream is not guilty
> in that (BTW, so is /usr/lib/games/nethack/recover-helper).
> 	* ergo, any exploitable hole in sgid-games binary (rogue, for
> instance) is trivially elevated to root exploit.

mizar:[/tmp] dpkg -l nethack
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  nethack        3.4.0-3.1      Overhead dungeon-crawler game (dummy package
mizar:[/tmp] ls -l /usr/lib/games/nethack/recover*
-rwxrwsr-x    1 root     games        6088 2002-07-06 17:54 /usr/lib/games/nethack/recover
-rwxrwxr-x    1 root     root          283 2002-07-06 17:54 /usr/lib/games/nethack/recover-helper
mizar:[/tmp] grep recover /etc/init.d/nethack
# Nethack save-file recovery script for Debian
    test -x /usr/lib/games/nethack/recover-helper || exit 0
      # Refuse to recover root's nethack files.
        echo "Ignoring root's Nethack unrecovered save file."
        # script running as the user which recovers everything
        su "$owner" -c /usr/lib/games/nethack/recover-helper 

The script has worked this way since at least version 3.3.0-7, which is
found in Debian 2.2 (potato).  Is there some other situation you found where
recover would be run as root, other than when explicitly started by root?

This is still a serious bug, of course, and allows gid games to be exploited
to gain the privileges of a user with a recoverable saved game, but not root
(at least not trivially).

-- 
 - mdz
