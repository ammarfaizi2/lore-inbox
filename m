Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWIMLl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWIMLl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 07:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWIMLl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 07:41:26 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:58293 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1030416AbWIMAIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:08:50 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200609130025.k8D0PYUH007789@auster.physics.adelaide.edu.au>
Subject: 2.6.17 oops, possibly ntfs/mmap related
To: linux-kernel@vger.kernel.org
Date: Wed, 13 Sep 2006 09:55:34 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a machine which is currently making heavy use of a usb hard disc
formatted with ntfs.  There have been two occasions where the kernel has
oopsed while this disc was being accessed heavily.  Before adding this HDD
the machine in question was rock solid which leads me to think that it
might be related to ntfs.  USB drives formatted with other filesystems do
not appear to suffer from this problem.

The first oops caused the machine to totally lock up:

  BUG: unable to handle kernel paging request at virtual address e4004de0
   printing eip:
  c012de0c
  *pde = 00000000
  Oops: 0000 [#1]
  Modules linked in: ntfs 8139too via_agp agpgart usb_storage ehci_hcd uhci_hcd usbcore
  CPU:    0
  EIP:    0060:[<c012de0c>]    Not tainted VLI
  EFLAGS: 00010082   (2.6.17 #2) 
  EIP is at find_get_page+0x11/0x22
  eax: e4004de0   ebx: c02f01a8   ecx: e4004de0   edx: e4004de0
  esi: 00000000   edi: 00000066   ebp: cfc20574   esp: c770bee8
  ds: 007b   es: 007b   ss: 0068
  Process sh (pid: 10467, threadinfo=c770a000 task=cfa495c0)
  Stack: c012ea09 00000002 00000000 cfc204d8 cff882a4 cff88260 c770bf30 c5962544 
         c02f01a8 00000000 ceec10a0 080aef10 c01385d1 00000000 cfc20574 080aef10 
         c5962544 ceec10a0 00000002 c7aeb080 080aef10 ceec10a0 080aef10 c013886a 
  Call Trace:
   <c012ea09> filemap_nopage+0x98/0x2b2  <c01385d1> do_no_page+0x6d/0x1e1
   <c013886a> __handle_mm_fault+0xc4/0x162  <c0112190> do_page_fault+0x23e/0x56b
   <c01c43c1> copy_to_user+0x41/0x49  <c0111f52> do_page_fault+0x0/0x56b
   <c010342f> error_code+0x4f/0x54 
  Code: a0 fe ff ff 89 ea b9 e2 d7 12 c0 6a 02 e8 5f ec 15 00 83 c4 44 5b 5e 5f 5d c3 fa 83 c0 04 e8 2c 3f 09 00 85 c0 89 c1 74 0f 89 c2 <8b> 00 f6 c4 40 74 03 8b 51 0c ff 42 04 fb 89 c8 c3 fa 83 c0 04 


In the case of the second oops the machine was still partially usable and a
clean shutdown was possible.  However, services such as sshd were no longer
responding.

  BUG: unable to handle kernel paging request at virtual address 0010c744
   printing eip:
  c013be50
  *pde = 00000000
  Oops: 0002 [#1]
  Modules linked in: ntfs 8139too via_agp agpgart usb_storage ehci_hcd uhci_hcd usbcore
  CPU:    0
  EIP:    0060:[<c013be50>]    Tainted: G   M  VLI
  EFLAGS: 00010282   (2.6.17 #2) 
  EIP is at anon_vma_unlink+0x16/0x3c
  eax: 0010c740   ebx: cf1070cc   ecx: cf107104   edx: cf8bc740
  esi: cf8bc740   edi: b7e82000   ebp: 00000000   esp: cdad7f58
  ds: 007b   es: 007b   ss: 0068
  Process sh (pid: 20272, threadinfo=cdad6000 task=c0d8d580)
  Stack: cf1070cc cf61f3e4 c0136b5f cdad7f80 c4084b74 cf8b5860 00000001 00000000 
         c013ab92 00000000 c0371b7c 000000b9 cf8b5860 c0d8d580 c01145dd cdad6000 
         c0118187 cdad6000 00000000 00000000 cdad6000 c0118380 00000000 b7f9968c 
  Call Trace:
   <c0136b5f> free_pgtables+0x41/0x82  <c013ab92> exit_mmap+0x6a/0xb8
   <c01145dd> mmput+0x1b/0x5e  <c0118187> do_exit+0x14e/0x2d1
   <c0118380> sys_exit_group+0x0/0xd  <c010299b> syscall_call+0x7/0xb
  Code: c9 74 10 8b 11 8d 40 38 89 42 04 89 53 38 89 48 04 89 01 5b c3 56 53 8b 70 40 89 c3 85 f6 74 2e 8d 48 38 8b 40 38 8b 51 04 89 02 <89> 50 04 c7 43 38 00 01 10 00 39 36 c7 41 04 00 02 20 00 75 0e 
  EIP: [<c013be50>] anon_vma_unlink+0x16/0x3c SS:ESP 0068:cdad7f58
   <1>Fixing recursive fault but reboot is needed!

I'm not entirely sure why the kernel considered itself tainted in the second
oops and not in the first - the setup hadn't changed and precisely the same
kernel modules were loaded.  This machine does not have any external (ie:
out-of-tree) modules installed.

I'm happy to try things to narrow down the cause if it will help.

Please CC me on reply.

Thanks
  jonathan
