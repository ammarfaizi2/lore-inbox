Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVCXPaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVCXPaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbVCXP3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:29:24 -0500
Received: from geode.he.net ([216.218.230.98]:23312 "HELO noserose.net")
	by vger.kernel.org with SMTP id S262526AbVCXPZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:25:50 -0500
From: ecashin@noserose.net
Message-Id: <1111677943.31453@geode.he.net>
Date: Thu, 24 Mar 2005 07:25:43 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [9/12]: add note about the need for deadlock-free sk_buff allocation
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


add note about the need for deadlock-free sk_buff allocation

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/Documentation/aoe/todo.txt b/Documentation/aoe/todo.txt
--- a/Documentation/aoe/todo.txt	1969-12-31 19:00:00.000000000 -0500
+++ b/Documentation/aoe/todo.txt	2005-03-10 12:19:57.000000000 -0500
@@ -0,0 +1,14 @@
+There is a potential for deadlock when allocating a struct sk_buff for
+data that needs to be written out to aoe storage.  If the data is
+being written from a dirty page in order to free that page, and if
+there are no other pages available, then deadlock may occur when a
+free page is needed for the sk_buff allocation.  This situation has
+not been observed, but it would be nice to eliminate any potential for
+deadlock under memory pressure.
+
+Because ATA over Ethernet is not fragmented by the kernel's IP code,
+the destructore member of the struct sk_buff is available to the aoe
+driver.  By using a mempool for allocating all but the first few
+sk_buffs, and by registering a destructor, we should be able to
+efficiently allocate sk_buffs without introducing any potential for
+deadlock.


-- 
  Ed L. Cashin <ecashin@coraid.com>
