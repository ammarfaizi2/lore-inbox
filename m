Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVCLXRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVCLXRx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVCLXRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:17:40 -0500
Received: from aun.it.uu.se ([130.238.12.36]:28361 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262052AbVCLXRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:17:16 -0500
Date: Sun, 13 Mar 2005 00:17:07 +0100 (MET)
Message-Id: <200503122317.j2CNH77v028760@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] perfctr API update 0/9: overview
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This is the last planned major perfctr API update.

This set of patches change how control data is communicated
between user-space and the kernel. The main idea is that the
control data is partitioned into "domains", and each domain is
given its own representation. The design principles were:
- Data directly corresponding to CPU register contents is sent
  in variable-length <number,value> arrays. This allows us to
  handle future CPUs with more control registers without
  breaking any binary structure layouts.
  The register numbers used are the natural numbers for that
  platform, i.e. MSR numbers on x86 and SPR numbers on PPC.
- Potentially variable-length arrays are not embedded in other
  API-visible structures, but are in separate domains.
  This allows for larger arrays in the future, and it also allows
  user-space to pass only as much data as is necessary.
  The virtual-to-physical counter mapping is handled this way.
- Simple purely software-defined structures are Ok, as long as
  they don't contain variable-length data or CPU register values.
- No embedded user-space pointers anywhere, to avoid having to
  special-case 32-bit binaries on 64-bit kernels.

The API write function takes a <domain,data,datalen> triple,
interprets the data given the domain, and updates the in-kernel
control structures accordingly. The API read function is similar.

Implementing this is done in a sequence of four logical steps:
1. The low-level drivers are adjusted to use physical register
   numbers not virtual ones when indexing their control structures.
   This is needed because with the new API, the user's control
   data will be a physically-indexed image of the CPU state, not a
   virtually-indexed image as before.
2. Common header fields in the low-level control structures are
   broken out into a separate structure. This is because those
   fields form a separate domain in the new API.
3. The low-level drivers are extended with an in-kernel API for
   writing control data in <domain,data,datalen> form to the
   control structure. A similar read API is also added.
4. sys_vperfctr_write() and sys_vperfctr_read() are converted to
   the new domain-based form.

These changes require an updated user-space library, which I'll
release tomorrow.

After this there will be some minor cleanups, and then I'll start
merging David Gibson's ppc64 driver.

/Mikael
