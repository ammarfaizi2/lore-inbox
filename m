Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbVCPX7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbVCPX7C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbVCPX4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:56:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:35218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262885AbVCPX4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:56:18 -0500
Date: Wed, 16 Mar 2005 15:55:33 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: ralf@linux-mips.org, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       cliffw@osdl.org, tytso@mit.edu, rddunlap@osdl.org
Subject: [7/9] Timercode race in AX.25
Message-ID: <20050316235533.GF5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316235336.GY5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

----

From: Ralf Baechle DL5RB <ralf@linux-mips.org>

When destroying a socket ax25_destroy_socket tries to stop the protocol's
T1 timer before freeing the memory.  If things are just right using the
non-sync variant of del_timer means the timer will continue to run even
after the del_timer because it's adding itself again which is likely to
result in a crash when the timer is executed again a few seconds later.

del_timer_sync can be expensive, so I don't want this one to go into 2.6
mainline where I'll try to cook something that is less intrusive than
regular calls to del_timer_sync.

Signed-off-by: Ralf Baechle DL5RB <ralf@linux-mips.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- bk-afu.orig/net/ax25/ax25_timer.c	2005-03-08 13:54:06.000000000 +0000
+++ bk-afu/net/ax25/ax25_timer.c	2005-03-08 16:43:34.790532976 +0000
@@ -106,7 +106,7 @@
 
 void ax25_stop_t1timer(ax25_cb *ax25)
 {
-	del_timer(&ax25->t1timer);
+	del_timer_sync(&ax25->t1timer);
 }
 
 void ax25_stop_t2timer(ax25_cb *ax25)
