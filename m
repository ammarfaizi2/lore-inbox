Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVIOAuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVIOAuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOAuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:50:19 -0400
Received: from nome.ca ([65.61.200.81]:32694 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S932495AbVIOAuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:50:17 -0400
Date: Wed, 14 Sep 2005 17:51:06 -0700
From: Mike Bell <mike@mikebell.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>
Subject: devfs vs udev FAQ from the other side
Message-ID: <20050915005105.GD15017@mikebell.org>
Mail-Followup-To: Mike Bell <mike@mikebell.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devfs vs udev
>From the other side

Presuppositions (True of both udev and devfs):
1) Dynamic /dev is the way of the future, and a Good Thing
2) A single major/minor combination should have only a single device
node, its other names should be symlinks. If you don't do this, you
break locking on certain classes of applications, among other things.

The above are uncontentious as far as I know. I believe Greg KH has
stated both. If you feel otherwise, please explain why.

Differences:
1) devfs creates device nodes from kernel space, and creates symlinks
  for alternative names using a userspace helper. udev handles both tasks
  from user space, by exporting the information through a different
  kernel-generated filesystem.

devfs advantages over udev:
1) devfs is smaller
  Hey, I ran the benchmarks, I have numbers, something Greg never gave.
  Took an actual devfs system of mine and disabled devfs from the
  kernel, then enabled hotplug and sysfs for udev to run.  make clean
  and surprise surprise, kernel is much bigger. Enable netlink stuff and
  it's bigger still. udev is only smaller if like Greg you don't count
  its kernel components against it, even if they wouldn't otherwise need
  to be enabled. Difference is to the tune of 604164 on udev and 588466
  on devfs. Maybe not a lot in some people's books, but a huge
  difference from the claims of other people that devfs is actually
  bigger.

  And that's just the kernel. Then because your root is read-only you
  need an early userspace, and in regular userspace the udev binary, and
  its data files, all more wasted flash (you can shave it down by
  removing stuff you don't need, but that's just more work for the busy
  coder, and udev STILL loses on size).

  On the system in question (a real-world embedded system) the devfs
  solution requires no userspace helper except for two symlinks which
  were simply created manually in init, and could have been done away
  with if necessary.

2) devfs is faster
  Despite all the many tricks that can be used to speed up udev (static
  linking, netlink, etc) devfs is still dramatically faster. On a big,
  bloated, slow-booting distribution system you may not notice so much,
  but when even your slowest booting systems are interactive in under 5
  seconds using devfs, this is quite significant time loss.

3) devfs uses less memory
  Check free. sysfs alone does udev in and that's just the kernel stuff
  that's always there.
  
  Also, the user space stuff may not have to run at all times in all
  configurations, but on a system without swap and with long-running
  apps, all that matters is its PEAK memory usage. If my app takes x MB
  and my kernel takes y MB it doesn't MATTER that udev is only running
  for one second, I still need more than x+yMB of memory.


udev advantages over devfs:
1) udev has all sorts of spiffy features
  Sure, but having device nodes exported directly from the kernel in no
  way stops you from having those spiffy features. The problem is that
  udev is doing two separate tasks, and it's easy to confuse the one it
  should be doing with the one it shouldn't.

2) udev doesn't have policy in kernel space
  Well, that's a bit of a lie. sysfs has even stricter policy in kernel
  space. What he MEANS is that udev exchanges hard-coded but symlinkable
  /dev paths for hardcoded sysfs paths, moving the hard-coded kernel
  policy from one filesystem to another.

  This argument is really the only architectural reason to go with udev.
  At all. If you really believe that the ability to name your hard drive
  /dev/foobarbaz is vital, and absolutely can't live with merely having
  /dev/foobarbaz be a symlink to the real device node, then you need udev.
  The devfs way of handling this situation was a stupid, racey misfeature
  and rightly deserves to die horribly.

  That said, read my comments on why flexible /dev naming is actually a
  bad thing and think very, very carefully about whether you actually want
  this "feature" at all. Symlinks are your friend.

3) devfs is ugly
  Part of this is true, and part of this is just the perspective of
  certain people (Greg has this fascinating world view where code
  required for devfs is garbage, and code required for udev is core
  kernel code and doesn't count against udev, which allows him to say
  udev is smaller.)
  
  The legitimate comments about devfs being ugly... well, how many
  subsystems which have been largely untouched for similar periods of
  time aren't even uglier? TTY stuff? And it's very hard to find a
  maintainer for a subsystem when it's "obsolete", patches that change
  its behaviour aren't accepted, and certain people are so vocally
  opposed to its very existence. Who wants to throw away their time
  writing code that won't even be considered, only to be hated for it?

4) devfs is unsupported, udev isn't
  True that. And even people who've tried to maintain devfs get turned
  away. So unless this document causes a few people to reexamine the
  need to remove devfs, you can reasonably assume that udev will be the
  only way to run a linux system very shortly (static /dev is already on
  its last legs). Me, I'll be disappointed if this happens, because as
  the above document indicates, I still think kernel-exported /dev is
  better (and not because I'm a lazy user-space-hater, Greg. :) ).
