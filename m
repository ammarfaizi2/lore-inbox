Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVCZV5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVCZV5p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 16:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCZV5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 16:57:45 -0500
Received: from exosec.net1.nerim.net ([62.212.114.195]:45871 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S261312AbVCZV5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 16:57:39 -0500
Date: Sat, 26 Mar 2005 22:57:33 +0100
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.29-hf6 fixes 4 vulnerabilities
Message-ID: <20050326215733.GA31786@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's the sixth hotfix for linux-2.4.29 :

   http://linux.exosec.net/kernel/2.4-hf/

Note: this update fixes 2 oopses and 4 security vulnerabilities and is in
sync with 2.4.30-rc3 :

    CAN-2005-0400: kernel memory leak in ext2 mkdir()
    CAN-2005-0750: bluetooth range checking bug
    CAN-2005-0794: potential DOS in load_elf_library.
    CAN-2005-0815: range checking flaws in isofs

Users of 2.4.29 and 2.4.29-hf up to and including hf5 are encouraged to
upgrade either to -hf6 or to plain 2.4.30 when it emerges.

You'll find appended to this mail the small changelog from hf5.

Regards,
Willy

--

Changelog From 2.4.29-hf5 to 2.4.29-hf6 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed

Note: this update fixes 2 oopses and 4 security vulnerabilities :

    CAN-2005-0400: kernel memory leak in ext2 mkdir()
    CAN-2005-0750: bluetooth range checking bug
    CAN-2005-0794: potential DOS in load_elf_library.
    CAN-2005-0815: range checking flaws in isofs


+ atm_get_addr-signedness-fix-1                                  (Simon Horman)

  [PATCH] Backport v2.6 ATM copy-to-user signedness fix.
  The signdness fix for atm_get_addr() in  2.6 seems to be needed for 2.4 as
  well. This relates to the bugs reported in this document :
  http://www.guninski.com/where_do_you_want_billg_to_go_today_3.html

+ af_bluetooth-checks-unsigned-only-1                         (marcel holtmann)

  CAN-2005-0750: Fix af_bluetooth range checking bug, discovered by Ilja van
  Sprundel <ilja@suresec.org>

+ ext2-mkdir-leaks-kernel-memory-1                              (mathieu lafon)

  CAN-2005-0400: ext2 mkdir() directory entry random kernel memory leak.
  I think I have discovered a potential security problem in ext2: when a new
  directory is created, the ext2 block written to disk is not initialized.
  An information leak can then be found after the two directory entries ('.'
  and '..') or in the name buffer of each entry (struct ext2_dir_entry_2).
  
+ load_elf_library-potential-dos-2                                 (Herbert Xu)

  CAN-2005-0794: Potential DOS in load_elf_library.
  Yichen Xie <yxie@cs.stanford.edu> points out that load_elf_library can
  modify `elf_phdata' before freeing it. Contains latest mismerge fix from
  Andreas Arens.

+ isofs-range-checking-flaws-1                                   (chris wright)

  [PATCH] isofs: Handle corupted rock-ridge info slightly better.
  Michal Zalewski <lcamtuf@dione.ids.pl> discovers range checking flaws in
  iso9660 filesystem. CAN-2005-0815 is assigned to this issue.
 
+ degraded-soft-raid1-can-corrupt-data-1                           (Neil Brown)

  [PATH] md: allow degraded raid1 array to resync after an unclean shutdown.
  If a raid1 array has more than two devices, and not all are working,
  then it will not resync after an unclean shutdown (as it will think
  that it should reconstruct a failed drive, and will find there aren't
  any spares...). Problem found by Mario Holbe.

+ usb-serial_write-oops-1                                        (Pete Zaitcev)

  [PATCH] USB: fix oops in serial_write
  When I split the __serial_write off serial_write, the former took the NULL
  check away with it. However, the new serial_write still has an reference
  remaining in down(&port->sem). Joachim Nilsson corrected me.

+ link_path_walk-refcount-problem-1                                (Greg Banks)

  [PATCH] link_path_walk refcount problem allows umount of active filesystem
  Following an absolute symlink opens a window during which the filesystem
  containing the symlink has an outstanding dentry count and no outstanding
  vfsmount count.  A umount() of the filesystem can (incorrectly) proceed,
  resulting in the "Busy inodes after unmount" message and an oops shortly
  thereafter.
  
+ netlink-multicast-bind-race-1                                    (Herbert Xu)

  [NETLINK]: Fix multicast bind/autobind race.
  Now it is possible for netlink_bind to race against netlink_autobind running
  on the same socket on another CPU.  The result would be a socket that's on
  mc_list with groups set to zero. This socket will be left on the list even
  after it is destroyed. The fix is to remove the zeroing in netlink_autobind.

+ tun-check-for-underflow-1                                   (Patrick McHardy)

  [TUN]: Fix check for underflow. Backport fix from 2.6.x.

+ tcp-bic-reset-cwnd-on-loss-1                              (Stephen Hemminger)

  [TCP]: BIC not binary searching correctly. 2.4 version of same fix as 2.6.11.
  The problem is that BIC is supposed to reset the cwnd to the last loss value
  rather than ssthresh when loss is detected.  The correct code (from the BIC
  TCP code for Web100) is in this patch.

+ useless-f_count-leaves-fs-busy-1                                 (Neil Brown)

  [PATCH] nlm: fix f_count leak
  I can't see any reason for this file->f_count++.  Removing it fixes a bug
  which leaves an exported filesystem busy (and so unmountable) if a callback
  for a lock held on that filesystem ever failed. Found by Terence Rokop.

--

