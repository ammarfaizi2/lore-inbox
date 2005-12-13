Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbVLMIb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbVLMIb3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVLMIbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:31:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:43907 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932552AbVLMIYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:50 -0500
Date: Tue, 13 Dec 2005 00:22:20 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       david@gibson.dropbear.id.au, wli@holomorphy.com
Subject: [patch 04/26] Fix crash when ptrace poking hugepage areas
Message-ID: <20051213082220.GE5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-crash-when-ptrace-poking-hugepage-areas.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Gibson <david@gibson.dropbear.id.au>

set_page_dirty() will not cope with being handed a page * which is part of
a compound page, but not the master page in that compound page.  This case
can occur via access_process_vm() if you attemp to write to another
process's hugepage memory area using ptrace() (causing an oops or hang).

This patch fixes the bug by only calling set_page_dirty() from
access_process_vm() if the page is not a compound page.  We already use a
similar fix in bio_set_pages_dirty() for the case of direct io to
hugepages.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: William Irwin <wli@holomorphy.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 kernel/ptrace.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.14.3.orig/kernel/ptrace.c
+++ linux-2.6.14.3/kernel/ptrace.c
@@ -238,7 +238,8 @@ int access_process_vm(struct task_struct
 		if (write) {
 			copy_to_user_page(vma, page, addr,
 					  maddr + offset, buf, bytes);
-			set_page_dirty_lock(page);
+			if (!PageCompound(page))
+				set_page_dirty_lock(page);
 		} else {
 			copy_from_user_page(vma, page, addr,
 					    buf, maddr + offset, bytes);

--
