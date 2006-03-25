Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWCYEdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWCYEdA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWCYE1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:27:53 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:51388
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750837AbWCYE1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:27:36 -0500
Date: Fri, 24 Mar 2006 20:27:15 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>, Chris Wright <chrisw@sous-sol.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/20] NET: Ensure device name passed to SO_BINDTODEVICE is NULL terminated.
Message-ID: <20060325042715.GL21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="net-ensure-device-name-passed-to-so_bindtodevice-is-null-terminated.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
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

--- linux-2.6.16.orig/net/core/sock.c
+++ linux-2.6.16/net/core/sock.c
@@ -404,8 +404,9 @@ set_rcvbuf:
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

--
