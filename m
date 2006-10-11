Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161474AbWJKVQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161474AbWJKVQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWJKVQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:16:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:17571 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161442AbWJKVJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:02 -0400
Date: Wed, 11 Oct 2006 14:08:35 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Linux Memory Management List <linux-mm@kvack.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, alan@lxorguk.ukuu.org.uk,
       Greg KH <gregkh@suse.de>, Nick Piggin <npiggin@suse.de>
Subject: [patch 58/67] mm: bug in set_page_dirty_buffers
Message-ID: <20061011210835.GG16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="mm-bug-in-set_page_dirty_buffers.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Nick Piggin <npiggin@suse.de>

This was triggered, but not the fault of, the dirty page accounting
patches. Suitable for -stable as well, after it goes upstream.

Unable to handle kernel NULL pointer dereference at virtual address 0000004c
EIP is at _spin_lock+0x12/0x66
Call Trace:
 [<401766e7>] __set_page_dirty_buffers+0x15/0xc0
 [<401401e7>] set_page_dirty+0x2c/0x51
 [<40140db2>] set_page_dirty_balance+0xb/0x3b
 [<40145d29>] __do_fault+0x1d8/0x279
 [<40147059>] __handle_mm_fault+0x125/0x951
 [<401133f1>] do_page_fault+0x440/0x59f
 [<4034d0c1>] error_code+0x39/0x40
 [<08048a33>] 0x8048a33
 =======================

Signed-off-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/buffer.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.18.orig/fs/buffer.c
+++ linux-2.6.18/fs/buffer.c
@@ -838,7 +838,10 @@ EXPORT_SYMBOL(mark_buffer_dirty_inode);
  */
 int __set_page_dirty_buffers(struct page *page)
 {
-	struct address_space * const mapping = page->mapping;
+	struct address_space * const mapping = page_mapping(page);
+
+	if (unlikely(!mapping))
+		return !TestSetPageDirty(page);
 
 	spin_lock(&mapping->private_lock);
 	if (page_has_buffers(page)) {

--
