Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWCYEMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWCYEMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWCYEMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:12:14 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:12959
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750782AbWCYEMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:12:13 -0500
Date: Fri, 24 Mar 2006 20:11:53 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net
Subject: [PATCH 07/08] NET: Ensure device name passed to SO_BINDTODEVICE is NULL terminated.
Message-ID: <20060325041153.GH16955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325040852.GA16955@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

The user can pass us arbitrary garbage so we should ensure the
string they give us is null terminated before we pass it on
to dev_get_by_index() et al.

Found by Solar Designer.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 net/core/sock.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.15.6.orig/net/core/sock.c
+++ linux-2.6.15.6/net/core/sock.c
@@ -403,8 +403,9 @@ set_rcvbuf:
 			if (!valbool) {
 				sk->sk_bound_dev_if = 0;
 			} else {
-				if (optlen > IFNAMSIZ) 
-					optlen = IFNAMSIZ; 
+				if (optlen > IFNAMSIZ - 1)
+					optlen = IFNAMSIZ - 1;
+				memset(devname, 0, sizeof(devname));
 				if (copy_from_user(devname, optval, optlen)) {
 					ret = -EFAULT;
 					break;
