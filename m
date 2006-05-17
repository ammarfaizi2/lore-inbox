Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWEQWN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWEQWN2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWEQWNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:13:25 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:7040 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751239AbWEQWNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:13:06 -0400
Message-Id: <20060517221401.062369000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:09 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Marcel Holtmann <holtmann@redhat.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Kirill Korotaev <dev@sw.ru>, Solar Designer <solar@openwall.com>,
       Patrick McHardy <kaber@trash.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 09/22] [PATCH] Netfilter: do_add_counters race, possible oops or info leak (CVE-2006-0039)
Content-Disposition: inline; filename=netfilter-do_add_counters-race-possible-info-leak.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Solar Designer found a race condition in do_add_counters(). The beginning
of paddc is supposed to be the same as tmp which was sanity-checked
above, but it might not be the same in reality. In case the integer
overflow and/or the race condition are triggered, paddc->num_counters
might not match the allocation size for paddc. If the check below
(t->private->number != paddc->num_counters) nevertheless passes (perhaps
this requires the race condition to be triggered), IPT_ENTRY_ITERATE()
would read kernel memory beyond the allocation size, potentially causing
an oops or leaking sensitive data (e.g., passwords from host system or
from another VPS) via counter increments.  This requires CAP_NET_ADMIN.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=191698

Cc: Solar Designer <solar@openwall.com>
Cc: Kirill Korotaev <dev@sw.ru>
Cc: Patrick McHardy <kaber@trash.net>
(chrisw: rebase of Solar's patch to 2.6.16.16)
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 net/ipv4/netfilter/arp_tables.c |    2 +-
 net/ipv4/netfilter/ip_tables.c  |    2 +-
 net/ipv6/netfilter/ip6_tables.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.16.16.orig/net/ipv4/netfilter/arp_tables.c
+++ linux-2.6.16.16/net/ipv4/netfilter/arp_tables.c
@@ -941,7 +941,7 @@ static int do_add_counters(void __user *
 
 	write_lock_bh(&t->lock);
 	private = t->private;
-	if (private->number != paddc->num_counters) {
+	if (private->number != tmp.num_counters) {
 		ret = -EINVAL;
 		goto unlock_up_free;
 	}
--- linux-2.6.16.16.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2.6.16.16/net/ipv4/netfilter/ip_tables.c
@@ -1063,7 +1063,7 @@ do_add_counters(void __user *user, unsig
 
 	write_lock_bh(&t->lock);
 	private = t->private;
-	if (private->number != paddc->num_counters) {
+	if (private->number != tmp.num_counters) {
 		ret = -EINVAL;
 		goto unlock_up_free;
 	}
--- linux-2.6.16.16.orig/net/ipv6/netfilter/ip6_tables.c
+++ linux-2.6.16.16/net/ipv6/netfilter/ip6_tables.c
@@ -1120,7 +1120,7 @@ do_add_counters(void __user *user, unsig
 
 	write_lock_bh(&t->lock);
 	private = t->private;
-	if (private->number != paddc->num_counters) {
+	if (private->number != tmp.num_counters) {
 		ret = -EINVAL;
 		goto unlock_up_free;
 	}

--
