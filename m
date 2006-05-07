Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWEGNKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWEGNKi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWEGNKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:10:38 -0400
Received: from exo3753.pck.nerim.net ([213.41.240.142]:20930 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S932155AbWEGNKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:10:37 -0400
Date: Sun, 7 May 2006 15:10:34 +0200
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@kvack.org>, Grant Coady <grant_lkml@dodo.com.au>,
       willy@w.ods.org
Subject: [ANNOUNCE] Linux-2.4.32-hf32.4
Message-ID: <20060507131034.GA19198@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is the fourth hotfix for 2.4.32 and older kernels. There are 9 new
fixes, 5 of which are security-related, 1 memory leak, and 3 minor bugs :

  - 2.4.32-CVE-2006-0741-always-check-that-rips-are-canonical-1   (Andi Kleen)
  - 2.4.32-CVE-2006-1524-fix-shm-mprotect-1                     (Hugh Dickins)
  - 2.4.32-CVE-2006-1056-i386-x86_64-x87-information-leak-1       (Andi Kleen)
  - 2.4.32-via-rhine-zero-pad-short-packets-1                    (Craig Brind)
  - 2.4.32-CVE-2006-1864-smbfs-escape-chroot-1                    (Olaf Kirch)
  - 2.4.32-netfilter-ipt_recent-memleak-1                        (Jesper Juhl)
  - 2.4.32-nfs-cache-consistency-with-mmap-1                     (Jeff Layton)
  - 2.4.32-vlan_ioctl-missing-checks-1                         (Mika Kukkonen)
  - 2.4.32-quota_v2-module-taints-the-kernel-1                   (Marek Szuba)

This leads to the following number of patches per kernel :

   Version | New | Total
   --------+-----+------
    2.4.28 |   9 |  170 
    2.4.29 |   9 |  167 
    2.4.30 |   9 |  101 
    2.4.31 |   9 |   88 
    2.4.32 |   9 |   38 
   --------+-----+------

Please note that two of those patches are not in mainline yet (merged at the
last minute) : the SMBFS fix (CVE-2006-1864, which is fixed in 2.6.16.14) and
the ipt_recent memory leak.

I've built it with all modules on x86-smp but not booted it yet. The detailed
changelog follows.

Please use the links below to download it :

    hotfixes home : http://linux.exosec.net/kernel/2.4-hf/
     last version : http://linux.exosec.net/kernel/2.4-hf/LATEST/LATEST/
         RSS feed : http://linux.exosec.net/kernel/hf.xml
    build results : http://bugsplatter.mine.nu/test/linux-2.4/ (Grant's site)
              GIT : http://w.ods.org/kernel/2.4/patches-2.4-hf.git/
           GITWEB : http://w.ods.org/git/?p=patches-2.4-hf.git;a=summary


Changelog from 2.4.32-hf32.3 to 2.4.32-hf32.4
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.32-CVE-2006-0741-always-check-that-rips-are-canonical-1   (Andi Kleen)

  This works around a problem in handling non canonical RIPs on SYSRET on
  Intel CPUs. They report the #GP on the SYSRET, not the next instruction
  as Linux expects it. With these changes this path should never see a non
  canonical user RIP. This is CVE-2006-0741. Roughly based on a patch by
  Ernie Petrides, but redone by AK.

+ 2.4.32-CVE-2006-1524-fix-shm-mprotect-1                     (Hugh Dickins)

  shmat stop mprotect from giving write permission to a readonly
  attachment.

+ 2.4.32-CVE-2006-1056-i386-x86_64-x87-information-leak-1       (Andi Kleen)

  AMD K7/K8 CPUs only save/restore the FOP/FIP/FDP x87 registers in FXSAVE
  when an exception is pending. This means the value leak through context
  switches and allow processes to observe some x87 instruction state of
  other processes. This is CVE-2006-1056. The problem was discovered
  originally by Jan Beulich. Richard Brunner provided the basic code for
  the workarounds with contributions from Jan.

+ 2.4.32-via-rhine-zero-pad-short-packets-1                    (Craig Brind)

  Fixes Rhine I cards disclosing fragments of previously transmitted
  frames in new transmissions.

  Before transmission, any socket buffer (skb) shorter than the ethernet
  minimum length of 60 bytes was zero-padded. On Rhine I cards the data
  can later be copied into an aligned transmission buffer without copying
  this padding. This resulted in the transmission of the frame with the
  extra bytes beyond the provided content leaking the previous contents of
  this buffer on to the network. Now zero-padding is repeated in the local
  aligned buffer if one is used.

+ 2.4.32-CVE-2006-1864-smbfs-escape-chroot-1                    (Olaf Kirch)

  Initial work and description from Olaf Kirch for kernel 2.6 :
  Mark Moseley reported that a chroot environment on a SMB share can be
  left via "cd ..\\".  Similar to CVE-2006-1863 issue with cifs, this fix
  is for smbfs (CVE-2006-1864). Steven French <sfrench@us.ibm.com> wrote:
  Looks fine to me.  This should catch the slash on lookup or equivalent,
  which will be all obvious paths of interest. Back-ported from 2.6 to 2.4
  by Willy Tarreau.

+ 2.4.32-netfilter-ipt_recent-memleak-1                        (Jesper Juhl)

  The Coverity checker spotted that we may leak 'hold' in 
  net/ipv4/netfilter/ipt_recent.c::checkentry() when the following
  is true : 
    if (!curr_table->status_proc) {
      ...
      if(!curr_table) {
      ...
        return 0;  <-- here we leak.
  Simply moving an existing vfree(hold); up a bit avoids the possible leak.

+ 2.4.32-nfs-cache-consistency-with-mmap-1                     (Jeff Layton)

  A customer of Red Hat reported a problem with cache invalidation when
  using mmapped files over NFS with the 2.4 kernel. This patch fixes this
  by checking whether the clean_pages list for the inode is empty after
  invalidate_inode_pages is called. If it's not then we set a flag so on
  the next pass through it automatically flags the data as invalid.

+ 2.4.32-vlan_ioctl-missing-checks-1                         (Mika Kukkonen)

  In vlan_ioctl_handler() the code misses couple checks for
  error return values. The same patch was merged into 2.6.

+ 2.4.32-quota_v2-module-taints-the-kernel-1                   (Marek Szuba)

  Apparently the quota_v2 module in 2.4 still lacks the licence macro
  and taints the kernel, even though the same module in 2.6 is correctly
  tagged as GPL. In case it makes things any easier, I am enclosing an
  appropriate patch.


--
Willy Tarreau - http://w.ods.org/
EXOSEC - ZAC des Metz - 3 Rue du petit robinson - 78350 JOUY EN JOSAS
N°Indigo: 0 825 075 510 - Accueil: +33 1 72 89 72 30 - Fax: +33 1 72 89 80 19
Site web : http://www.exosec.fr/

