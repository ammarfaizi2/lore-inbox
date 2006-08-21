Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWHUSs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWHUSs3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWHUSr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:47:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:30598 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750723AbWHUSro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:47:44 -0400
Date: Mon, 21 Aug 2006 11:46:03 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/20] Kill HASH_HIGHMEM from route cache hash sizing
Message-ID: <20060821184603.GD21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="kill-hash_highmem-from-route-cache-hash-sizing.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Kirill Korotaev <dev@sw.ru>

[IPV4]: Limit rt cache size properly.

During OpenVZ stress testing we found that UDP traffic with random src
can generate too much excessive rt hash growing leading finally to OOM
and kernel panics.

It was found that for 4GB i686 system (having 1048576 total pages and
225280 normal zone pages) kernel allocates the following route hash:
syslog: IP route cache hash table entries: 262144 (order: 8, 1048576
bytes) => ip_rt_max_size = 4194304 entries, i.e.  max rt size is
4194304 * 256b = 1Gb of RAM > normal_zone

Attached the patch which removes HASH_HIGHMEM flag from
alloc_large_system_hash() call.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/route.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.8.orig/net/ipv4/route.c
+++ linux-2.6.17.8/net/ipv4/route.c
@@ -3144,7 +3144,7 @@ int __init ip_rt_init(void)
 					rhash_entries,
 					(num_physpages >= 128 * 1024) ?
 					15 : 17,
-					HASH_HIGHMEM,
+					0,
 					&rt_hash_log,
 					&rt_hash_mask,
 					0);

--
