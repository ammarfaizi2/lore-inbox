Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161257AbWF0UMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbWF0UMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWF0UMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:12:42 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:27008 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161259AbWF0UMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:12:40 -0400
Message-Id: <20060627201011.007417000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:05 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>,
       Vlad Yasevich <vladislav.yasevich@hp.com>,
       Sridhar Samudrala <sri@us.ibm.com>
Subject: [PATCH 05/25] SCTP: Limit association max_retrans setting in setsockopt.
Content-Disposition: inline; filename=sctp-limit-association-max_retrans-setting-in-setsockopt.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Vlad Yasevich <vladislav.yasevich@hp.com>

When using ASSOCINFO socket option, we need to limit the number of
maximum association retransmissions to be no greater than the sum
of all the path retransmissions. This is specified in Section 7.1.2
of the SCTP socket API draft.
However, we only do this if the association has multiple paths. If
there is only one path, the protocol stack will use the
assoc_max_retrans setting when trying to retransmit packets.

Signed-off-by: Vlad Yasevich <vladislav.yasevich@hp.com>
Signed-off-by: Sridhar Samudrala <sri@us.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/sctp/socket.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

--- linux-2.6.17.1.orig/net/sctp/socket.c
+++ linux-2.6.17.1/net/sctp/socket.c
@@ -2530,8 +2530,32 @@ static int sctp_setsockopt_associnfo(str
 
 	/* Set the values to the specific association */
 	if (asoc) {
-		if (assocparams.sasoc_asocmaxrxt != 0)
+		if (assocparams.sasoc_asocmaxrxt != 0) {
+			__u32 path_sum = 0;
+			int   paths = 0;
+			struct list_head *pos;
+			struct sctp_transport *peer_addr;
+
+			list_for_each(pos, &asoc->peer.transport_addr_list) {
+				peer_addr = list_entry(pos,
+						struct sctp_transport,
+						transports);
+				path_sum += peer_addr->pathmaxrxt;
+				paths++;
+			}
+
+			/* Only validate asocmaxrxt if we have more then
+			 * one path/transport.  We do this because path
+			 * retransmissions are only counted when we have more
+			 * then one path.
+			 */
+			if (paths > 1 &&
+			    assocparams.sasoc_asocmaxrxt > path_sum)
+				return -EINVAL;
+
 			asoc->max_retrans = assocparams.sasoc_asocmaxrxt;
+		}
+
 		if (assocparams.sasoc_cookie_life != 0) {
 			asoc->cookie_life.tv_sec =
 					assocparams.sasoc_cookie_life / 1000;

--
