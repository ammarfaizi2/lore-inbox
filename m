Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265138AbUETMoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265138AbUETMoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 08:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUETMoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 08:44:12 -0400
Received: from legolas.drinsama.de ([62.91.17.164]:22457 "EHLO
	legolas.drinsama.de") by vger.kernel.org with ESMTP id S265138AbUETMoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 08:44:08 -0400
Subject: Bug in interface removal from bridges.
From: Erich Schubert <erich@debian.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1084542378.17594.12.camel@wintermute.xmldesign.de>
References: <1084542378.17594.12.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Organization: Debian GNU/Linux Developers
Message-Id: <1085057048.13106.5.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Thu, 20 May 2004 14:44:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this is the straight backport from 2.6.5 of the fix.
Can someone with authority review this and forward it to marcelo for
inclusion in the next 2.4.x release?

To verify your system is vulnerable (need bridge support):
$ brctl addbr br0
$ brctl addbr br1
$ brctl addif br0 eth0
$ brctl delif br1 eth0
(note br1 in last line, not br0!)

Here's the fix as taken from 2.6:
(fixed sometime in 2.5.x it seems; it might be worth looking at when
this was fixed - it might contain other fixes, too.)

--- net/bridge/br_if.c.2.4.21	2004-05-20 14:34:50.000000000 +0200
+++ net/bridge/br_if.c	2004-05-20 14:37:22.000000000 +0200
@@ -254,6 +254,10 @@
 int br_del_if(struct net_bridge *br, struct net_device *dev)
 {
 	int retval;
+	struct net_bridge_port *p;
+
+	if ((p = dev->br_port) == NULL || p->br != br)
+		return -EINVAL;
 
 	br_write_lock_bh(BR_NETPROTO_LOCK);
 	write_lock(&br->lock);

Greetings,
Erich

