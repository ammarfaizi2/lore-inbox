Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRBTKQi>; Tue, 20 Feb 2001 05:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129528AbRBTKQ3>; Tue, 20 Feb 2001 05:16:29 -0500
Received: from mail2.aracnet.com ([216.99.193.35]:25357 "EHLO
	mail2.aracnet.com") by vger.kernel.org with ESMTP
	id <S129183AbRBTKQQ>; Tue, 20 Feb 2001 05:16:16 -0500
Date: Tue, 20 Feb 2001 02:16:09 -0800
From: Kevin Turner <acapnotic@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.1] system goes glacial, Reiser on /usr doesn't sync
Message-ID: <20010220021609.B11523@troglodyte.menefee>
Reply-To: He-Who-Is-Not-Subscribed-to-LKML 
	  <acapnotic@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version:
Linux version 2.4.1-pre12 (gcc version 2.95.3 20010125 (prerelease))

Possible suspect players: 
  dpkg seems to trigger the bug
  ReiserFS is the partition that doesn't sync
  binfmt_misc shows up in the call traces.

Symptoms:

The system assumes glacial speeds.  If you're *lucky*, you'll see one
widget re-paint in X before the next ice age.  Ctrl-alt-delete is
unresponsive, as are attempts to start proccesses via the network or
joystick port.  Keypresses to programs such as getty are not echoed.
All program output to console and network is stopped dead.  If you leave
for a several-hour-long coffee break and come back to it, there's still
no evidence that you banged on the keyboard.

What does work: If not in X, I may switch between VTs.  Keypresses are
echoed on VTs without running processes.  And the machine still pings.
Occasionally (a few times a minute at most), you'll see the HDD LED
blink.

When it happens: Sometimes, not always, when accessing the package
database or updating installed packages with the Debian's "dpkg" tool.

When it *didn't* happen: before I switched to kernel 2.4.x.

Debugging information:

After I had about enough of this, I recompiled the kernel with
CONFIG_REISERFS_CHECK and Magic SysRq.  ReiserFS gives no debugging
messages of any sort during these episodes.  Magic SysRq, however, does
work.

Magic-tErminate clears everything up and the system resumes normal
operation.

Magic-Sync appears not to work, as "Ok" and "Done" don't appear.  But
after Magic-E, they do show up.  Logs show that one partition actually
sync'd before termination, the others didn't.  The partition where it
stalled just so happens to be a ReiserFS partition (3.5.x format).

kernel: SysRq: Emergency Sync
kernel: Syncing device 03:01 ... OK
kernel: Syncing device 16:02 ... <6>SysRq: Terminate All Tasks
kernel: OK
kernel: Syncing device 16:01 ... OK
kernel: Syncing device 03:03 ... OK


03:01 - ext2  /
16:02 - ReiFS /usr (note: /var is a symlink to /usr/root-var)
16:01 - ext2  /home
03:03 - ext2  /other

In ReiserFS's defense, /usr and /var are the patitions that dpkg was
most likely to have open files on, so perhaps that was it.

When I asked magic about running processes, it said that, among other
things, there was one apt-get, one dpkg, and three instances of
dpkg-deb.  Of those, dpkg was the only one in 'R' state, the others were
'S'.  Here's the call trace:


dpkg      R 00000000     0  9278   9152  9285  (NOTLB)
Call Trace: [__alloc_pages+372/720] [grow_buffers+62/364]
[refill_freelist+28/48] [refill_freelist+41/48] [getblk+242/264]
[binfmt_misc:__insmod_binfmt_misc_O/lib/modules/2.4.1-pre12/kernel/fs/bi+-621596/96]
[binfmt_misc:__insmod_binfmt_misc_O/lib/modules/2.4.1-pre12/kernel/fs/bi+-970133/96]
[binfmt_misc:__insmod_binfmt_misc_O/lib/modules/2.4.1-pre12/kernel/fs/bi+-750728/96]
[binfmt_misc:__insmod_binfmt_misc_O/lib/modules/2.4.1-pre12/kernel/fs/bi+-976628/96]
[binfmt_misc:__insmod_binfmt_misc_O/lib/modules/2.4.1-pre12/kernel/fs/bi+-918150/96]
[binfmt_misc:__insmod_binfmt_misc_O/lib/modules/2.4.1-pre12/kernel/fs/bi+-976370/96]
[binfmt_misc:__insmod_binfmt_misc_O/lib/modules/2.4.1-pre12/kernel/fs/bi+-1080871/96]
[permission+42/48] [vfs_link+141/192] [sys_link+202/300]


Why binfmt_misc?  I'll be burned if I know.  It is true that one of the
packages I was installing this run was related to binfmt_misc
("binfmt-support"), but that wasn't the case the previous times this bug
has happened.  On the other hand, I don't have call traces for those
times.


Linux version 2.4.1-pre12 (gcc version 2.95.3 20010125 (prerelease))
dpkg version 1.3.8.1
arch is i586 (GenuineIntel Pentium MMX)
disks are IDE
48 MB RAM
swap > 200 MB

Motherboard: ABIT-TX5
Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)

More logs are posted at:
http://olug.cs.oberlin.edu/~kturner/bugs/glacial-2.4.1.html
The kernel's configuration is at:
http://olug.cs.oberlin.edu/~kturner/bugs/config-2.4.1-pre12


And yes, I will try upgrading to a newer kernel.  But since I can't
quite reproduce this on demand yet, I thought I'd report it now while
the logbits are fresh.

-- 
Kevin Turner <acapnotic@users.sourceforge.net> | OpenPGP encryption welcome here
I usually subscribe to lists I post to, but for LKML I'm making an exception =)
Please feel free to CC me on all follow-ups.
