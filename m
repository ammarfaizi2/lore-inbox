Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267617AbUHEKGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267617AbUHEKGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 06:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUHEKGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 06:06:23 -0400
Received: from mailrelay2.lrz-muenchen.de ([129.187.254.102]:11428 "EHLO
	mailrelay2.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id S267617AbUHEKGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 06:06:10 -0400
Date: Thu, 5 Aug 2004 12:06:08 +0200 (CEST)
From: Mike Becher <Mike.Becher@lrz-muenchen.de>
X-X-Sender: a2825an@lxmbe01.lrz.lrz-muenchen.de
To: linux-kernel@vger.kernel.org
Subject: ptrace problem on ia64 with kernel 2.4.26
Message-Id: <Pine.LNX.4.58.0408050827430.7618@lxmbe01.lrz.lrz-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on our Linux IA64 cluster we got the problem that tools like strace, gdb, 
ddd, and other debugging tools, which depend on ptrace system call, don't
work after some days of uptime of a node. I have searched already in the 
web about information relating to that problem but haven't found any answer. 

description:
------------
On a node that got the problem (when it runs longer than 3 days) strace 
produce this output:
  [mibe@lxsrv154]# strace /bin/true
  execve("/bin/true", ["/bin/true"], [/* 38 vars */]) = 0
  upeek: ptrace(PTRACE_PEEKUSER, ... ): Input/output error
Instead on a `younger' node or fresh booted node strace works fine.

To find out what is differnt I have used also the `utrace' tool
(http://www.gelato.unsw.edu.au/IA64wiki/utrace) with a small
modification to peek info about register r4.

diff utrace.c.orig utrace.c
62c62
<   long scnum, result, error, val;
---
>   long scnum, result, result_r4, error, val;
74a75
>   result_r4 = ptrace (PTRACE_PEEKUSER, child_pid, PT_R4, 0);

With this register starts the critical area of ptrace for debuggers
when problem exists. They all don't do their work because they cannot
gather information about some registers like r4, r5, r6, r7.
Also it doesn't work for user `root'.
Whether in messages files nor in /proc filesystem nor with dmesg I
have found any info that can give me a hint what has changed. 

configuration:
--------------
We use the following configuration:
* kernel 2.4.26 (vanilla kernel) with 
  - official linux-2.4.26-ia64-040510.diff.bz2 (11-May-2004 11:18)
  - EXPORT_SYMBOL_NOVERS(iosapic_fixup_pci_interrupt) in
    linux-2.4.26/arch/ia64/kernel/ia64_ksyms.c
  - commented out 
     printk(KERN_WARNING "%s(%d): floating-point assist...)
    in linux-2.4.26/arch/ia64/kernel/traps.c
  - BitKeeper patch which fixes x86 "clear_cpu()" macro.
    on line 34 to >>> asm volatile("fnclex ; fwait");
* openafs 1.2.11
* Myrinet driver GM build ID is "1.6.4_Linux_and_AIX
* PVFS 1.6.2 with pvfs-1.6.2-01292004.patch
* following modules are loaded:
  [mibe@lxsrv154 ia64]# lsmod
  Module                  Size  Used by    Tainted: PF
  pvfs                  147336   7
  imb                    43024   0
  gm                    620176   1  (autoclean)
  libafs-2.4.26.mp     1296528   2
  e1000                 170976   1
  nls_iso8859-1           6000   1  (autoclean)
  nls_cp437               7680   1  (autoclean)
  usbkbd                  9040   0  (unused)
  ehci-hcd               54872   0  (unused)
  usb-uhci               66888   0  (unused)
  usbcore               182800   1  [usbkbd ehci-hcd usb-uhci]
  aacraid                95512   7
  sd_mod                 33856  14

Hope someone can help me to solve this problem.

best regards,
  Mike
