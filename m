Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVC1Xff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVC1Xff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVC1Xff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:35:35 -0500
Received: from aun.it.uu.se ([130.238.12.36]:1019 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262118AbVC1Xfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:35:30 -0500
Date: Tue, 29 Mar 2005 01:35:21 +0200 (MEST)
Message-Id: <200503282335.j2SNZLTg013413@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc1-mm3 0/3] perfctr: mapped state cleanup: overview
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This set of patches change the layout of the perfctr cpu state object.
This state is mmap()able, providing a low-overhead sampling method to
user-space. But in order to limit the number of cache lines touched
at frequent operations (context switches and explicit samplings), some
kernel-private fields are unfortunately visible to user-space near the
start of the counter state object. This is both ugly and prevents the
kernel from ever changing the size of those fields.

This issue is fixed now as follows:
- The fields are reordered slightly. The freqently accessed kernel-private
  fields are now first, followed by the user-visible fields. This doesn't
  change the number of cache lines touched.
- The now contiguous user-visible fields are moved to a sub-struct.
- The kernel-private types are moved out of the user-visible parts of
  <asm-$arch/perfctr.h>.
- When mmap()ing a perfctr object, user-space must now add an offset
  to the mapping's address in order to reach the user-visible state.
  That offset is exported via a new perfctr sysfs attribute.

This is a simple straightforward change, but the patches get large
because a large number of field accesses must be adjusted.

/Mikael
