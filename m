Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVIIGoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVIIGoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 02:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVIIGoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 02:44:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751238AbVIIGoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 02:44:06 -0400
Date: Thu, 8 Sep 2005 23:43:42 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Mark J Cox <mjc@redhat.com>,
       aviro@redhat.com, davem@redhat.com, chrisw@osdl.org
Subject: [PATCH 10/9] raw_sendmsg DoS (CAN-2005-2492)
Message-ID: <20050909064342.GE7991@shell0.pdx.osdl.net>
References: <20050908012842.299637000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908012842.299637000@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I missed this one when launching review cycle, thanks to Mark Cox for
catching oversight.

-stable review patch.  If anyone has any  objections, please let us know.
------------------

From: Al Viro <aviro@redhat.com>

Fix unchecked __get_user that could be tricked into generating a
memory read on an arbitrary address.  The result of the read is not
returned directly but you may be able to divine some information about
it, or use the read to cause a crash on some architectures by reading
hardware state.  CAN-2005-2492.

Fix from Al Viro, ack from Dave Miller.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 net/ipv4/raw.c |    2 +-
 net/ipv6/raw.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.13.y/net/ipv4/raw.c
===================================================================
--- linux-2.6.13.y.orig/net/ipv4/raw.c
+++ linux-2.6.13.y/net/ipv4/raw.c
@@ -358,7 +358,7 @@ static void raw_probe_proto_opt(struct f
 
 			if (type && code) {
 				get_user(fl->fl_icmp_type, type);
-				__get_user(fl->fl_icmp_code, code);
+			        get_user(fl->fl_icmp_code, code);
 				probed = 1;
 			}
 			break;
Index: linux-2.6.13.y/net/ipv6/raw.c
===================================================================
--- linux-2.6.13.y.orig/net/ipv6/raw.c
+++ linux-2.6.13.y/net/ipv6/raw.c
@@ -619,7 +619,7 @@ static void rawv6_probe_proto_opt(struct
 
 			if (type && code) {
 				get_user(fl->fl_icmp_type, type);
-				__get_user(fl->fl_icmp_code, code);
+				get_user(fl->fl_icmp_code, code);
 				probed = 1;
 			}
 			break;
