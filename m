Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVHCGxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVHCGxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVHCGuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:50:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13019 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262121AbVHCGun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:50:43 -0400
Date: Tue, 2 Aug 2005 23:50:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, mostrows@watson.ibm.com
Subject: [03/13] rocket.c: Fix ldisc ref count handling
Message-ID: <20050803065018.GR7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Michal Ostrowski <mostrows@watson.ibm.com>

If bailing out because there is nothing to receive in rp_do_receive(),
tty_ldisc_deref is not called.  Failure to do so increases the ref count=20
and causes release_dev() to hang since it can't get the ref count to 0.

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/rocket.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.12.3.orig/drivers/char/rocket.c	2005-07-28 11:17:01.000000000 -0700
+++ linux-2.6.12.3/drivers/char/rocket.c	2005-07-28 11:17:09.000000000 -0700
@@ -277,7 +277,7 @@
 		ToRecv = space;
 
 	if (ToRecv <= 0)
-		return;
+		goto done;
 
 	/*
 	 * if status indicates there are errored characters in the
@@ -359,6 +359,7 @@
 	}
 	/*  Push the data up to the tty layer */
 	ld->receive_buf(tty, tty->flip.char_buf, tty->flip.flag_buf, count);
+done:
 	tty_ldisc_deref(ld);
 }
 
