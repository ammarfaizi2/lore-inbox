Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbUL1XAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUL1XAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUL1XAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:00:53 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:15263 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261151AbUL1XAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:00:44 -0500
Subject: Re: [2.6 patch] /net/ax25/: some cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: bunk@stusta.de, ralf@linux-mips.org, linux-hams@vger.kernel.org,
       netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041228100507.7b374b5e.davem@davemloft.net>
References: <20041212211339.GX22324@stusta.de>
	 <20041227185151.2a7ceb71.davem@davemloft.net>
	 <1104237408.20944.70.camel@localhost.localdomain>
	 <20041228100507.7b374b5e.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104270846.26109.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 21:54:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-12-28 at 18:05, David S. Miller wrote:
> Send a patch to netdev and CC: me to fix this as is standard
> procedure for getting changes into the networking.  :-)

Attached - revert to 2.6.9 behaviour.

I suspect given that someone made the change for a reason that there
should probably be a sysctl to switch between AX.25 (as 2.6.9) and "kind
of routed AX.25-ish" (as 2.6.10).

--- ../linux.vanilla-2.6.10/net/ax25/af_ax25.c	2004-12-25 21:15:46.000000000 +0000
+++ net/ax25/af_ax25.c	2004-12-26 22:07:44.000000000 +0000
@@ -207,8 +207,16 @@
 			continue;
 		if (s->ax25_dev == NULL)
 			continue;
-		if (ax25cmp(&s->source_addr, src_addr) == 0 &&
-		    ax25cmp(&s->dest_addr, dest_addr) == 0) {
+		if (ax25cmp(&s->source_addr, src_addr) == 0 && ax25cmp(&s->dest_addr, dest_addr) == 0 && s->ax25_dev->dev == dev) {
+			if (digi != NULL && digi->ndigi != 0) {
+				if (s->digipeat == NULL)
+					continue;
+				if (ax25digicmp(s->digipeat, digi) != 0)
+					continue;
+			} else {
+				if (s->digipeat != NULL && s->digipeat->ndigi != 0)
+					continue;
+			}
 			ax25_cb_hold(s);
 			spin_unlock_bh(&ax25_list_lock);
 

