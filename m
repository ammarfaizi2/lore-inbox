Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTFBJim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTFBJim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:38:42 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:14580 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262073AbTFBJik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:38:40 -0400
Date: Mon, 2 Jun 2003 02:49:10 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: [BK PATCH][LSM] Early init for security modules and various cleanups
Message-ID: <20030602024910.B27233@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a batch of LSM updates.  This patchset allows for statically
linked security modules to be initialized earlier in the boot sequence
to give consistent security labels to the earliest dynamically created
objects such as filesystems and kernel threads.  This patch was acked
by nearly all the arch maintainers, then subsequently updated based on
Sam Ravnborg's feedback.  The current version was floated passed arch
maintainers without much response, but it did at least get one ack
from DaveM.

Additional changes are removing two unused hooks, fixing a bug that Jakub
Jelinek reported in setfs[ug]id, and fixing some capability checks in
oom killer.

Please consider pulling from: bk://lsm.bkbits.net/linus-2.5

This will update these files:

 arch/alpha/vmlinux.lds.S                  |    3 +
 arch/arm/vmlinux-armo.lds.in              |    1 
 arch/arm/vmlinux-armv.lds.in              |    1 
 arch/cris/vmlinux.lds.S                   |    4 +-
 arch/h8300/platform/h8300h/generic/rom.ld |    1 
 arch/i386/vmlinux.lds.S                   |    1 
 arch/ia64/vmlinux.lds.S                   |    4 ++
 arch/m68k/vmlinux-std.lds                 |    1 
 arch/m68k/vmlinux-sun3.lds                |    1 
 arch/m68knommu/vmlinux.lds.S              |    4 --
 arch/mips/vmlinux.lds.S                   |    1 
 arch/mips64/vmlinux.lds.S                 |    1 
 arch/parisc/vmlinux.lds.S                 |    1 
 arch/ppc/vmlinux.lds.S                    |    2 +
 arch/ppc64/vmlinux.lds.S                  |    1 
 arch/s390/vmlinux.lds.S                   |    1 
 arch/sh/vmlinux.lds.S                     |    1 
 arch/sparc/vmlinux.lds.S                  |    1 
 arch/sparc64/vmlinux.lds.S                |    1 
 arch/x86_64/vmlinux.lds.S                 |    1 
 fs/namei.c                                |    2 -
 include/asm-generic/vmlinux.lds.h         |    6 +++
 include/linux/init.h                      |    6 +++
 include/linux/security.h                  |   49 ++++++------------------------
 init/main.c                               |    2 -
 kernel/sys.c                              |   20 ++++--------
 mm/oom_kill.c                             |    7 ++--
 security/capability.c                     |   10 ------
 security/dummy.c                          |   12 -------
 security/root_plug.c                      |    3 -
 security/security.c                       |   13 +++++++
 31 files changed, 77 insertions(+), 85 deletions(-)

with these changes:

Chris Wright:
  o [LSM] early init for security modules.  As discussed before, this allows
  for early initialization of security modules when compiled statically into
  the kernel.  The standard do_initcalls is too late for complete coverage of
  all filesystems and threads, for example.
  o [LSM] Remove security_inode_permission_lite hook
  o [LSM] Remove task_kmod_set_label hook, it is no longer necessary

Jakub Jelínek:
  o [LSM] make sure setfsuid/setfsgid return values are right. Before
  include/linux/security.h was added, setfsuid/setfsgid always returned

Stephen D. Smalley:
  o [LSM] Replaced the direct capability bit tests with calls to the
  security_capable hook in mm/oom_kill.c

thanks,
-chris
--
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
