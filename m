Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVCEPTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVCEPTf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVCEPTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:19:35 -0500
Received: from aun.it.uu.se ([130.238.12.36]:34953 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261427AbVCEPRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:17:40 -0500
Date: Sat, 5 Mar 2005 16:17:18 +0100 (MET)
Message-Id: <200503051517.j25FHI2U001419@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: dahinds@users.sourceforge.net
Subject: [PATCH][2.4.30-pre2] fix undefined behaviour in cistpl.c
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling drivers/pcmcia/cistpl.c with gcc-4.0 generates this warning:

cistpl.c: In function 'read_cis_mem':
cistpl.c:143: warning: 'sys' is used uninitialized in this function

Note 'is' not 'may be'. And there is indeed a control flow path in
which 'sys' is updated with '+=' even though it has no initial value.
Luckily 'sys' is reassigned later before being used, making this
assignment redundant, so the fix is to simply remove it.

This problem is not present in the 2.6 kernel.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.4.30-pre2/drivers/pcmcia/cistpl.c.~1~	2004-02-18 15:16:23.000000000 +0100
+++ linux-2.4.30-pre2/drivers/pcmcia/cistpl.c	2005-03-05 15:51:37.000000000 +0100
@@ -140,7 +140,6 @@ int read_cis_mem(socket_info_t *s, int a
     } else {
 	u_int inc = 1;
 	if (attr) { mem->flags |= MAP_ATTRIB; inc++; addr *= 2; }
-	sys += (addr & (s->cap.map_size-1));
 	mem->card_start = addr & ~(s->cap.map_size-1);
 	while (len) {
 	    set_cis_map(s, mem);
