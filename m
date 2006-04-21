Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWDUEoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWDUEoc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWDUEoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:43393 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932237AbWDUEoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:02 -0400
Date: Thu, 20 Apr 2006 21:39:39 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Corey Minyard <minyard@acm.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/22] Open IPMI BT overflow
Message-ID: <20060421043939.GR12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="open-ipmi-bt-overflow.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Orsila <shd@jolt.modeemi.cs.tut.fi>

[PATCH] Open IPMI BT overflow

I was looking into random driver code and found a suspicious looking
memcpy() in drivers/char/ipmi/ipmi_bt_sm.c on 2.6.17-rc1:

	if ((size < 2) || (size > IPMI_MAX_MSG_LENGTH))
		return -1;
	...
	memcpy(bt->write_data + 3, data + 1, size - 1);

where sizeof bt->write_data is IPMI_MAX_MSG_LENGTH.  It looks like the
memcpy would overflow by 2 bytes if size == IPMI_MAX_MSG_LENGTH.  A patch
attached to limit size to (IPMI_MAX_LENGTH - 2).

Cc: Corey Minyard <minyard@acm.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/ipmi/ipmi_bt_sm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.9.orig/drivers/char/ipmi/ipmi_bt_sm.c
+++ linux-2.6.16.9/drivers/char/ipmi/ipmi_bt_sm.c
@@ -165,7 +165,7 @@ static int bt_start_transaction(struct s
 {
 	unsigned int i;
 
-	if ((size < 2) || (size > IPMI_MAX_MSG_LENGTH))
+	if ((size < 2) || (size > (IPMI_MAX_MSG_LENGTH - 2)))
 	       return -1;
 
 	if ((bt->state != BT_STATE_IDLE) && (bt->state != BT_STATE_HOSED))

--
