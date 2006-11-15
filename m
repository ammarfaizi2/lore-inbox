Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030617AbWKOQBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030617AbWKOQBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030618AbWKOQBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:01:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18450 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030617AbWKOQBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:01:48 -0500
Date: Wed, 15 Nov 2006 17:01:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wright <chrisw@sous-sol.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [2.6.16/18 patch] security/seclvl.c: fix time wrap (CVE-2005-4352)
Message-ID: <20061115160146.GD5824@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

initlvl=2 in seclvl gives the guarantee
"Cannot decrement the system time".

But it was possible to set the time to the maximum unixtime value 
(19 Jan 2038) resulting in a wrap to the minimum value.

This patch fixes this by disallowing setting the time to any date
after 2031 with initlvl=2.

This patch does not apply to kernel 2.6.19 since the seclvl module was 
already removed in this kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16.32/security/seclvl.c.old	2006-11-15 13:58:05.000000000 +0100
+++ linux-2.6.16.32/security/seclvl.c	2006-11-15 16:41:51.000000000 +0100
@@ -381,6 +381,8 @@ static int seclvl_settime(struct timespe
 				      current->group_leader->pid);
 			return -EPERM;
 		}		/* if attempt to decrement time */
+		if (tv->tv_sec > 1924988400)	/* disallow dates after 2030) */
+			return -EPERM;		/* CVE-2005-4352 */
 	}			/* if seclvl > 1 */
 	return 0;
 }
