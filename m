Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUHUG33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUHUG33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 02:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUHUG33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 02:29:29 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:41711 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S268153AbUHUG31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 02:29:27 -0400
From: mita akinobu <amgta@yacht.ocn.ne.jp>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] shows Active/Inactive on per-node meminfo
Date: Sat, 21 Aug 2004 15:29:37 +0900
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>
References: <200408210302.25053.amgta@yacht.ocn.ne.jp> <200408201448.22566.jbarnes@engr.sgi.com>
In-Reply-To: <200408201448.22566.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408211529.37839.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 August 2004 03:48, Jesse Barnes wrote:
> Just FYI, loops like this are going to be very slow on a large machine.
> Iterating over every node in the system involves a TLB miss on every
> iteration along with an offnode reference and possibly cacheline demotion.

get_zone_counts() is used by max_sane_readahead(), and
max_sane_readahead() is often called in filemap_nopage().

If iterating over every node is going to be very slow, the following change
would have a little bit of improvement on a large machine?


--- linux-2.6.8.1-mm3/mm/readahead.c.orig	2004-08-21 15:18:08.924273720 +0900
+++ linux-2.6.8.1-mm3/mm/readahead.c	2004-08-21 15:22:31.123413392 +0900
@@ -572,6 +572,6 @@ unsigned long max_sane_readahead(unsigne
 	unsigned long inactive;
 	unsigned long free;
 
-	get_zone_counts(&active, &inactive, &free);
+	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }



