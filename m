Return-Path: <linux-kernel-owner+w=401wt.eu-S964947AbWLOBeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWLOBeH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWLOBeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:34:06 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46053 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964807AbWLOBd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:33:59 -0500
Message-Id: <20061215013648.197529000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:33:49 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Milan Broz <mbroz@redhat.com>,
       device-mapper development <dm-devel@redhat.com>,
       Alasdair G Kergon <agk@redhat.com>
Subject: [patch 12/24] dm snapshot: fix freeing pending exception
Content-Disposition: inline; filename=dm-snapshot-fix-freeing-pending-exception.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Milan Broz <mbroz@redhat.com>

Fix oops when removing full snapshot
kernel bugzilla bug 7040

If a snapshot became invalid (full) while there is outstanding 
pending_exception, pending_complete() forgets to remove
the corresponding exception from its exception table before freeing it.

Already fixed in 2.6.19.

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/md/dm-snap.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.18.5.orig/drivers/md/dm-snap.c
+++ linux-2.6.18.5/drivers/md/dm-snap.c
@@ -691,6 +691,7 @@ static void pending_complete(struct pend
 
 		free_exception(e);
 
+		remove_exception(&pe->e);
 		error_snapshot_bios(pe);
 		goto out;
 	}

--
