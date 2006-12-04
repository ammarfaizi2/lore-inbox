Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936832AbWLDSIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936832AbWLDSIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 13:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934022AbWLDSIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 13:08:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46988 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936832AbWLDSIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 13:08:24 -0500
Date: Mon, 4 Dec 2006 10:06:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: Aucoin@Houston.RR.com, "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: la la la la ... swappiness
Message-Id: <20061204100656.793d8d6a.akpm@osdl.org>
In-Reply-To: <200612041707.kB4H7Mnh020665@laptop13.inf.utfsm.cl>
References: <200612041439.kB4EdGFn025092@ms-smtp-03.texas.rr.com>
	<200612041707.kB4H7Mnh020665@laptop13.inf.utfsm.cl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2006 14:07:22 -0300
"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:

> Please explain again:
> 
> - What you are doing, step by step

That 2GB machine apparently has a 1.6GB shm segment which is mlocked.  That will
cause the VM to do one heck of a lot of pointless scanning and could, I guess,
cause false oom decisions.  It's also an ia32 highmem machine, which adds to the
fun.

We could scan more:

--- a/mm/vmscan.c~a
+++ a/mm/vmscan.c
@@ -918,6 +918,7 @@ static unsigned long shrink_zone(int pri
 	 * slowly sift through the active list.
 	 */
 	zone->nr_scan_active += (zone->nr_active >> priority) + 1;
+	zone->nr_scan_active *= 2;
 	nr_active = zone->nr_scan_active;
 	if (nr_active >= sc->swap_cluster_max)
 		zone->nr_scan_active = 0;
@@ -925,6 +926,7 @@ static unsigned long shrink_zone(int pri
 		nr_active = 0;
 
 	zone->nr_scan_inactive += (zone->nr_inactive >> priority) + 1;
+	zone->nr_scan_inactive *= 2;
 	nr_inactive = zone->nr_scan_inactive;
 	if (nr_inactive >= sc->swap_cluster_max)
 		zone->nr_scan_inactive = 0;
_

but that's rather dumb.  Better would be to remove mlocked pages from the
LRU.
