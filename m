Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWHPWg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWHPWg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWHPWg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:36:56 -0400
Received: from hera.kernel.org ([140.211.167.34]:17611 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932300AbWHPWg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:36:56 -0400
Date: Wed, 16 Aug 2006 22:36:33 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mtosatti@redhat.com, Mikael Pettersson <mikpe@it.uu.se>
Subject: Linux 2.4.34-pre1
Message-ID: <20060816223633.GA3421@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

here's the first pre-release of 2.4.34. Nothing really serious, I only
merged the previously queued patches. Pete Zaitcev has issued a bunch
of USB fixes in usbserial and also more general locking to fix a bug
with some usb-storage devices such as the TEAC CD-210PU. We only know
that it fixed the problem for the reporter, but this should definitely
get more testing. There's also an interesting NFS fix from Jeff Layton.

Some people have asked me what the hotfix tree will become. It will
still exist in its current form to provide fixes for older versions.
But I will create a 4 digit version for latest release because people
got used to this since the 2.6-stable branch. The version suffix in
the hotfix will still reflect the equivalent head level (eg: hf33.1
will equal 2.4.33.1). I will prepare one soon with the most important
of the few bugs below.

Also, I've been asked by several people to consider merging Mikael
Pettersson's gcc4 patches :

   http://user.it.uu.se/~mikpe/linux/patches/2.4/

I've been reluctant at first for the usual reasons : "who has a 2.4
distro with gcc4 ?", and after recalling all the trouble Marcelo
had to deal with during the gcc3 update. But after discussion with
some people, I realized that the problem is not here, it's for the
kernels those people have to maintain for other systems (eg: servers,
firewalls, etc...) and which they suddenly cannot build anymore after
they have updated the distro on their desktop PC.

With Mikael's help, I've carefully split ant reviewed ALL the fixes,
and carefully logged the error they each fixed. Also, warnings and
errors have been split. I must say that those fixes mostly consist in :

  - both static and extern declarations for the same variable
  - buggy lvalue casts in assignments
  - buggy expressions such as (i < TIMEOUT > 0) and i=(++i) + FOO
  - dangerous constructs such as :

       foo = (type_foo *)
       bar = (type_bar *)(something_else);

Since most of them were sleeping bugs waiting for someone to wake
them up, I considered it was worth merging them provided that we
observe no regression. So I have created a separate tree for it
that I will merge into mainline in a few pre-releases if we don't
encounter any problem.

What has been tested right now :
  - make allmodconfig on x86 with gcc-2.95.3, 3.3.6 and 4.1.1
    => builds OK

  - make "reasonable" config on x86-smp with all 3 compileres
    => builds and boots

  - make "reasonable" config on x86_64 and PPC with gcc 4.1
    => builds and boots

  - make "reasonable" config on sparc64-smp with 3.3.5 and 4.1.1
    => builds and boots

  - build debian's sparc32 kernel with 4.1.1
    => builds

I have no problem not supporting some rare architectures, and
people who use them are welcome to port them. It's quite easy,
it took me less than two hours to fix both sparc32 and sparc64.

Also, I have checked that the patches were really not intrusive.
I could apply the following cumulative external patches on top
of a gcc4-patched kernel without even one reject :

  vhz-jiffies64, pax, strict-overcommit, epoll, dm, netdev,
  preempt, low-latency, virtual-servers, squashfs2.2, ntfs,
  cifs, acl+ea, a large bunch of netfilter's patch-o-matic,
  ebtables, layer7-classifier, openswan-1.0, tux3, loop-aes,
  aic79xx, and a lot of small other ones.

Therefore, I consider the drawbacks almost inexistent (mostly
some work on our side) compared to the advantages of getting
cleaner code and making the job easier for the users to
maintain existing setups.

At the moment, it's available as a GIT tree here :

   git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/linux-2.4-gcc4.git

and as pure patches (merged and split) here :

   http://www.kernel.org/pub/linux/kernel/people/wtarreau/linux-2.4/gcc-4/

Feedback welcome, particularly on sparc/sparc64 where it is
difficult to build a full-featured kernel, and therefore I'm
sure there might still be a few corner cases.

Thanks for your patience during this long mail :-)

Regards,
Willy


Summary of changes from v2.4.33 to v2.4.34-pre1
============================================

Jeff Layton:
      2.4 NFS client - update d_cache when server reports ENOENT on an NFS remove

Jukka Partanen:
      Fix AVM C4 ISDN card init problems with newer CPUs

Pete Zaitcev:
      Bug with USB proc_bulk in 2.4 kernel
      USB: Little Rework for usbserial
      USB: unsigned long flags

Willy Tarreau:
      [BLKMTD] : missing offset sometimes causes panics
      AVM C4 ISDN card : use cpu_relax() in busy loops
      [PKTGEN] : fix an oops when used with bonding driver (Tien ChenLi)
      export memchr() which is used by smbfs and lp driver.
      Merge branch 'next'
      Change VERSION to 2.4.34-pre1

--

