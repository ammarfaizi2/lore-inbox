Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTGAINh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 04:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTGAINh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 04:13:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58580 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261245AbTGAINf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 04:13:35 -0400
Date: Tue, 01 Jul 2003 01:21:07 -0700 (PDT)
Message-Id: <20030701.012107.42800729.davem@redhat.com>
To: jsalmon@thesalmons.org
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru, jmorris@redhat.com
Subject: Re: negative tcp_tw_count and other TIME_WAIT weirdness?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200307010025.h610PGmX007656@river.fishnet>
References: <200307010025.h610PGmX007656@river.fishnet>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: John Salmon <jsalmon@thesalmons.org>
   Date: Mon, 30 Jun 2003 17:25:16 -0700

   I have several fairly busy servers reporting a negative value
   for tcp_tw_count.

 I have a sneaking suspicion that this patch (already in 2.4.22-preX)
 will fix your problem.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.930.114.22 -> 1.930.114.23
#	net/ipv4/tcp_minisocks.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/07	olof@austin.ibm.com	1.930.114.23
# [TCP]: tcp_twkill leaves death row list in inconsistent state over tcp_timewait_kill.
# --------------------------------------------
#
diff -Nru a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
--- a/net/ipv4/tcp_minisocks.c	Tue Jul  1 01:25:26 2003
+++ b/net/ipv4/tcp_minisocks.c	Tue Jul  1 01:25:26 2003
@@ -447,6 +447,8 @@
 
 	while((tw = tcp_tw_death_row[tcp_tw_death_row_slot]) != NULL) {
 		tcp_tw_death_row[tcp_tw_death_row_slot] = tw->next_death;
+		if (tw->next_death)
+			tw->next_death->pprev_death = tw->pprev_death;
 		tw->pprev_death = NULL;
 		spin_unlock(&tw_death_lock);
 
