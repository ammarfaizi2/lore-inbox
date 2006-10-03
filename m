Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWJCRcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWJCRcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWJCRbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:31:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:31964 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030348AbWJCRbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:31:03 -0400
Date: Tue, 3 Oct 2006 13:00:32 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: [RFC][PATCH 0/12] ELF Relocatable x86 bzImage (V2)
Message-ID: <20061003170032.GA30036@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Eric biederman implemented the relocatable kernel support for x86 and x86_64
and posted the patches for comments almost two months back.

http://marc.theaimsgroup.com/?l=linux-kernel&m=115443019026302&w=2

We have been testing the patches in RHEL kernels since then and things are
looking up. I think this is the time that patches can be included in -mm
and get more testing done and get rest of the issues sorted out.

Eric is currently held up with other things, so I have taken his patches
and forward ported to 2.6.18-git19. Did some minor cleanups and fixed a 
couple of bugs as faced in our testing. I have also accomodated the review
comments received last time.

Currently this patch series is only for i386. I will be posting the patches
for x86_64 later.

Following is a brief account of changes I have done since last time.

o Forward ported the patches to 2.6.18-git19
o Replaced CONFIG_PHYSICAL_START with CONFIG_PHYSICAL_ALIGN
o Added a patch to prevent section relative symbols becoming absolute
  for sections with zero size. 
o Dropped support for serial output debugging in decompressor code for
  the time being as per the discussion last time.
o Added symbol _text to few architectures so that compilation does not break
o Fix a typo in config option (CONFIG_RELOCTABLE). It was causing wrong pice
  of code to be executed and second kernel was stomping over first kernel's
  data.
o Modified __pa_symbol() definition as per Andi's comment.
o Put --emit-relocs undef #ifdef, so that relocation sections are not
  retained of CONFIG_RELOCATABLE is not set.
o Made symbol _end_rodata also section relative.
o Align .data section to 4K address otherwise data segment is loaded at
  a non-4K aligned boundary and kexec-tools do the check.

Following is the text from Eric's last post to refresh memory that
why do we need a relocatable kernel.

The problem:

We can't always run the kernel at 1MB or 2MB, and so people who need
different addresses must build multiple kernels.  The bzImage format
can't even represent loading a kernel at other than it's default address.
With kexec on panic now starting to be used by distros having a kernel
not running at the default load address is starting to become common.

The goal of this patch series is to build kernels that are relocatable
at run time, and to extend the bzImage format to make it capable of
expressing a relocatable kernel.

In extending the bzImage format I am replacing the existing unused bootsector
with an ELF header.  To express what is going on the ELF header will
have type ET_DYN.  Just like the kernel loading an ET_DYN executable
bootloaders are not expected to process relocations.  But the executable
may be shifted in the address space so long as it's alignment requirements
are met.

The i386 kernel is built to process relocations generated with --emit-relocs
(after vmlinux.lds.S) has been fixed up to sort out static and dynamic
relocations.

Thanks
Vivek
