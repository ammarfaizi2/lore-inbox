Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423032AbWJaJb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423032AbWJaJb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423031AbWJaJb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:31:57 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31886
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422773AbWJaJb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:31:56 -0500
Date: Tue, 31 Oct 2006 01:31:54 -0800 (PST)
Message-Id: <20061031.013154.122620846.davem@davemloft.net>
To: peter.hicks@poggs.co.uk
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Thousands of interfaces
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061031092550.GA8201@tufnell.london.poggs.net>
References: <20061031092550.GA8201@tufnell.london.poggs.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hicks <peter.hicks@poggs.co.uk>
Date: Tue, 31 Oct 2006 09:25:50 +0000

[ Discussion belongs on netdev@vger.kernel.org, added to CC: ]

> I have a dual 3GHz Xeon machine with a 2.4.21 kernel and thousands (15k+) of
> ipip tunnel interfaces.  These are being used to tunnel traffic from remote
> routers, over a private network, and handed off to a third party.
 ...
> Is it possible to speed up creation of the interfaces?  Currently it takes
> around 24 hours.  Is there are more efficient way to handle a very large
> number of IP-IP tunnels?  Would upgrading to a 2.6 kernel be of use?

We just simply never imagined people would use IP tunnels on
this scale.

The following kernel patch is a quick hack that will get things to
work quickly for you, but longer term we need to add dynamic hash
table growth to this thing (and SIT tunnel, and IP GRE tunnel,
etc. etc. etc.)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 0c45565..78055cf 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -117,8 +117,8 @@ #include <net/ipip.h>
 #include <net/inet_ecn.h>
 #include <net/xfrm.h>
 
-#define HASH_SIZE  16
-#define HASH(addr) ((addr^(addr>>4))&0xF)
+#define HASH_SIZE  16384
+#define HASH(addr) ((addr^(addr>>14))&(HASH_SIZE - 1))
 
 static int ipip_fb_tunnel_init(struct net_device *dev);
 static int ipip_tunnel_init(struct net_device *dev);
