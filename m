Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751989AbWG1QZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbWG1QZq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbWG1QZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:25:46 -0400
Received: from exo3753.pck.nerim.net ([213.41.240.142]:41257 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S1751989AbWG1QZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:25:45 -0400
Date: Fri, 28 Jul 2006 18:25:42 +0200
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Cc: mtosatti@redhat.com, w@1wt.eu, Grant Coady <grant_lkml@dodo.com.au>
Subject: [ANNOUNCE] Linux 2.4.32-hf32.7
Message-ID: <20060728162542.GE19315@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I finally put together my the remaining fixes for kernel 2.4.32.
Most are security-related. Note that I've created a 2.4-hf branch
in my git tree on kernel.org, that I will be able to feed faster
than releasing a complete hotfix. It will only be for the last
release, though.

I've built it with allmodconfig but not booted it. However, since
those patches are all present in 2.4.33-rc3, I'm confident.

I plan to move all this to kernel.org soon, but in the mean time,
it is still available at the usual places :

    hotfixes home : http://linux.exosec.net/kernel/2.4-hf/
     last version : http://linux.exosec.net/kernel/2.4-hf/LATEST/LATEST/
         RSS feed : http://linux.exosec.net/kernel/hf.xml
    build results : http://bugsplatter.mine.nu/test/linux-2.4/ (Grant's site)
              GIT : http://linux.1wt.eu/kernel/2.4/patches-2.4-hf.git/
           GITWEB : http://git.1wt.eu/git/?p=patches-2.4-hf.git;a=summary

There are 14 new patches in Kernel 2.4.32-hf32.7 (see below for details) :

  - 2.4.32-CVE-2006-2935-dvd_read_bca-buffer-overflow-1       (Andreas Haumer)
  - 2.4.32-ethtool-oopses-1                                    (Willy Tarreau)
  - 2.4.32-ext3-block-bitmap-leakage-1                       (Kirill Korotaev)
  - 2.4.32-CVE-2006-0039-netfilter-possible-race-in-do_add_counters-1 (Solar Designer)
  - 2.4.32-CVE-2006-1525-ip_route_input-panic-1            (Stephen Hemminger)
  - 2.4.32-CVE-2006-1857-SCTP-parameter-length-in-hb-ack-1     (Vlad Yasevich)
  - 2.4.32-CVE-2006-1858-SCTP-respect-chunk-length-1           (Vlad Yasevich)
  - 2.4.32-CVE-2006-2271-SCTP-closed-state-1               (Sridhar Samudrala)
  - 2.4.32-CVE-2006-2272-SCTP-fragmented-control-chunks-1  (Sridhar Samudrala)
  - 2.4.32-CVE-2006-2274-SCTP-infinite-recursion-1        (Vladislav Yasevich)
  - 2.4.32-netfilter-possible-overflow-in-do_replace-1       (Kirill Korotaev)
  - 2.4.32-ACPI-range-checking-for-sleep-states-1              (Willy Tarreau)
  - 2.4.32-buffer-overflow-in-usb-rndis-1                     (Shaun Tancheff)
  - 2.4.32-ext3-link-unlink-race-3                              (Vadim Egorov)

This leads to the following number of patches per kernel :

   Version | New | Total
   --------+-----+------
    2.4.28 |  14 |  191 
    2.4.29 |  14 |  188 
    2.4.30 |  14 |  122 
    2.4.31 |  14 |  109 
    2.4.32 |  14 |   59 
   --------+-----+------

Changelog from 2.4.32-hf32.6 to 2.4.32-hf32.7
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.32-CVE-2006-2935-dvd_read_bca-buffer-overflow-1       (Andreas Haumer)

  As described in CVE-2006-2935, a typo in cdrom.c causes a buffer
  overflow in dvd_read_bca(). Use the same fix for 2.4 as for 2.6.
  Discussion here :
    http://bugzilla.kernel.org/show_bug.cgi?id=2966

+ 2.4.32-ethtool-oopses-1                                    (Willy Tarreau)

  The function pointers which were checked were for their get_* counterparts.
  Typically a copy-paste typo.

+ 2.4.32-ext3-block-bitmap-leakage-1                       (Kirill Korotaev)

  This patch fixes ext3 block bitmap leakage, which leads to "block bitmap
  differences" fsck messages on healthy filesystem. All kernels up to 2.6.17
  have this bug. Found by Vasily Averin and Andrey Savochkin. Test case
  triggered the issue was created by Dmitry Monakhov.

+ 2.4.32-CVE-2006-0039-netfilter-possible-race-in-do_add_counters-1 (Solar Designer)

  Solar Designer found a race condition in do_add_counters(). The beginning
  of paddc is supposed to be the same as tmp which was sanity-checked
  above, but it might not be the same in reality. In case the integer
  overflow and/or the race condition are triggered, paddc->num_counters
  might not match the allocation size for paddc. If the check below
  (t->private->number != paddc->num_counters) nevertheless passes (perhaps
  this requires the race condition to be triggered), IPT_ENTRY_ITERATE()
  would read kernel memory beyond the allocation size, potentially causing
  an oops or leaking sensitive data (e.g., passwords from host system or
  from another VPS) via counter increments. This requires CAP_NET_ADMIN.

+ 2.4.32-CVE-2006-1525-ip_route_input-panic-1            (Stephen Hemminger)

  This fixes http://bugzilla.kernel.org/show_bug.cgi?id=6388
  The bug is caused by ip_route_input dereferencing skb->nh.protocol of
  the dummy skb passed dow from inet_rtm_getroute (Thanks Thomas for seeing
  it). It only happens if the route requested is for a multicast IP
  address.

+ 2.4.32-CVE-2006-1857-SCTP-parameter-length-in-hb-ack-1     (Vlad Yasevich)

  If SCTP receives a badly formatted HB-ACK chunk, it is possible
  that we may access invalid memory and potentially have a buffer
  overflow.  We should really make sure that the chunk format is
  what we expect, before attempting to touch the data.

+ 2.4.32-CVE-2006-1858-SCTP-respect-chunk-length-1           (Vlad Yasevich)

  When performing bound checks during the parameter processing, we
  want to use the real chunk and paramter lengths for bounds instead
  of the rounded ones.  This prevents us from potentially walking of
  the end if the chunk length was miscalculated.  We still use rounded
  lengths when advancing the pointer. This was found during a
  conformance test that changed the chunk length without modifying
  parameters.

+ 2.4.32-CVE-2006-2271-SCTP-closed-state-1               (Sridhar Samudrala)

  Discard an unexpected chunk in CLOSED state rather can calling BUG().

+ 2.4.32-CVE-2006-2272-SCTP-fragmented-control-chunks-1  (Sridhar Samudrala)

  Use pskb_pull() to handle incoming COOKIE_ECHO and HEARTBEAT chunks that
  are received as skb's with fragment list.

+ 2.4.32-CVE-2006-2274-SCTP-infinite-recursion-1        (Vladislav Yasevich)

  There is a rare situation that causes lksctp to go into infinite recursion
  and crash the system.  The trigger is a packet that contains at least the
  first two DATA fragments of a message bundled together. The recursion is
  triggered when the user data buffer is smaller that the full data message.
  The problem is that we clone the skb for every fragment in the message.
  When reassembling the full message, we try to link skbs from the "first
  fragment" clone using the frag_list. However, since the frag_list is shared
  between two clones in this rare situation, we end up setting the frag_list
  pointer of the second fragment to point to itself.  This causes
  sctp_skb_pull() to potentially recurse indefinitely. Proposed solution is
  to make a copy of the skb when attempting to link things using frag_list.

+ 2.4.32-netfilter-possible-overflow-in-do_replace-1       (Kirill Korotaev)

  netfilter's do_replace() can overflow on addition within SMP_ALIGN()
  and/or on multiplication by NR_CPUS, resulting in a buffer overflow on
  the copy_from_user().  In practice, the overflow on addition is
  triggerable on all systems, whereas the multiplication one might require
  much physical memory to be present due to the check above.  Either is
  sufficient to overwrite arbitrary amounts of kernel memory. Found by
  Solar Designer during security audit of OpenVZ.org

+ 2.4.32-ACPI-range-checking-for-sleep-states-1              (Willy Tarreau)

  A range checking is missing in acpi_system_write_sleep() in kernel
  2.4, and writing a large integer value to /proc/acpi/sleep will cause
  an oops. Fix extracted from the PaX patch.

+ 2.4.32-buffer-overflow-in-usb-rndis-1                     (Shaun Tancheff)

  Remote NDIS response to OID_GEN_SUPPORTED_LIST only allocated space
  for the data attached to the reply, and not the reply structure
  itself. This caused other kmalloc'd memory to be corrupted.

+ 2.4.32-ext3-link-unlink-race-3                              (Vadim Egorov)

  The problem happens when link and unlink are invoked simultaneously on the
  same inode on ext3 filesystem. In this case ext3_unlink may decrement
  i_nlink to 0 and put this inode into the in-memory orphan list, while
  ext3_link will increment i_nlink back to 1 having the inode in the orphan
  list. Thus the system ends up having an inode with i_nlink == 1 in the
  orphan list. When this inode gets unused later the memory might get
  released to the free pool and then be used for some other purpose, most
  likely some other inode. From this point on any operation on the orphan
  list may result in modification of the list_head that could alredy be used
  to store some other date. Solution: keep a copy of the inode pointer,
  incrementing its reference counter, to fix the situation.


Regards,
Willy
PGP Fingerprint : 72C2 A394 02EA F546 BA6F  A7B1 E82C B631 848A 1004

