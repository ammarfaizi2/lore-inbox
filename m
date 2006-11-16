Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162273AbWKPCtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162273AbWKPCtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162267AbWKPCtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:49:14 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:29064 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162269AbWKPCtC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:49:02 -0500
Message-Id: <20061116024756.176406000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:53 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Adrian Bunk <bunk@stusta.de>
Subject: [patch 21/30] security/seclvl.c: fix time wrap (CVE-2005-4352)
Content-Disposition: inline; filename=security-seclvl.c-fix-time-wrap.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Adrian Bunk <bunk@stusta.de>

initlvl=2 in seclvl gives the guarantee
"Cannot decrement the system time".

But it was possible to set the time to the maximum unixtime value 
(19 Jan 2038) resulting in a wrap to the minimum value.

This patch fixes this by disallowing setting the time to any date
after 2031 with initlvl=2.

This patch does not apply to kernel 2.6.19 since the seclvl module was 
already removed in this kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 security/seclvl.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.18.2.orig/security/seclvl.c
+++ linux-2.6.18.2/security/seclvl.c
@@ -370,6 +370,8 @@ static int seclvl_settime(struct timespe
 				      current->group_leader->pid);
 			return -EPERM;
 		}		/* if attempt to decrement time */
+		if (tv->tv_sec > 1924988400)	/* disallow dates after 2030) */
+			return -EPERM;		/* CVE-2005-4352 */
 	}			/* if seclvl > 1 */
 	return 0;
 }

--
