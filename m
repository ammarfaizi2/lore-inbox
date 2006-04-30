Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWD3RfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWD3RfD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWD3RdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:33:16 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:45522 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751199AbWD3Rcl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:41 -0400
Message-Id: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:29:53 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 00/14] remap_file_pages protection support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again (about 8 month since last time, I have much less time during my academic
year), I'm sending for review (and for possible inclusion into -mm) protection
support for remap_file_pages, i.e. setting per-pte protections (beyond file
offset) through this syscall.

== How it works ==

Protections are set in the page tables when the
page is loaded, are saved into the PTE when the page is swapped out and restored
when the page is faulted back in.

Additionally, we modify the fault handler since the VMA protections aren't valid
for PTE with modified protections.

Finally, we must also provide, for each arch, macros to store also the
protections into the PTE; to make the kernel compile for any arch, I've added
since last time dummy default macros to keep the same functionality.

== What is this for ==

The first idea is to use this for UML - it must create a lot of single page
mappings, and managing them through separate VMAs is slow.

Additional note: this idea, with some further refinements (which I'll code after
this chunk is accepted), will allow to reduce the number of used VMAs for most
userspace programs - in particular, it will allow to avoid creating one VMA for
one guard pages (which has PROT_NONE) - forcing PROT_NONE on that page will be
enough.

This will be useful since the VMA lookup at fault time can be a bottleneck for
some programs (I've received a report about this from Ulrich Drepper and I've
been told that also Val Henson from Intel is interested about this). I guess
that since we use RB-trees, the slowness is also due to the poor cache locality
of RB-trees (since RB nodes are within VMAs but aren't accessed together with
their content), compared for instance with radix trees where the lookup has high
cache locality (but they have however space usage problems, possibly bigger, on
64-bit machines).

== Notes ==

Implementations are provided for i386, x86_64 and UML, and for some other archs
I have patches I will send, based on the ones which were in -mm when Ingo sent
the first version of this work.

You shouldn't worry for the number of patches, most of them are very little.
I've last tested them in UML against 2.6.16-rc3, but I've seen no big changes in
the VM.
--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
