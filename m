Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161268AbWF0UNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbWF0UNt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWF0UNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:13:48 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:2432 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161266AbWF0UNp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:13:45 -0400
Message-Id: <20060627201126.254686000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:08 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>,
       Tsutomu Fujii <t-fujii@nb.jp.nec.com>,
       Vlad Yasevich <vladislav.yasevich@hp.com>,
       Sridhar Samudrala <sri@us.ibm.com>
Subject: [PATCH 08/25] SCTP: Send only 1 window update SACK per message.
Content-Disposition: inline; filename=sctp-send-only-1-window-update-sack-per-message.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Tsutomu Fujii <t-fujii@nb.jp.nec.com>

Right now, every time we increase our rwnd by more then MTU bytes, we
trigger a SACK.  When processing large messages, this will generate a
SACK for almost every other SCTP fragment. However since we are freeing
the entire message at the same time, we might as well collapse the SACK
generation to 1.

Signed-off-by: Tsutomu Fujii <t-fujii@nb.jp.nec.com>
Signed-off-by: Vlad Yasevich <vladislav.yasevich@hp.com>
Signed-off-by: Sridhar Samudrala <sri@us.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/sctp/ulpevent.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

--- linux-2.6.17.1.orig/net/sctp/ulpevent.c
+++ linux-2.6.17.1/net/sctp/ulpevent.c
@@ -51,6 +51,8 @@
 static void sctp_ulpevent_receive_data(struct sctp_ulpevent *event,
 				       struct sctp_association *asoc);
 static void sctp_ulpevent_release_data(struct sctp_ulpevent *event);
+static void sctp_ulpevent_release_frag_data(struct sctp_ulpevent *event);
+
 
 /* Initialize an ULP event from an given skb.  */
 SCTP_STATIC void sctp_ulpevent_init(struct sctp_ulpevent *event, int msg_flags)
@@ -883,6 +885,7 @@ static void sctp_ulpevent_receive_data(s
 static void sctp_ulpevent_release_data(struct sctp_ulpevent *event)
 {
 	struct sk_buff *skb, *frag;
+	unsigned int	len;
 
 	/* Current stack structures assume that the rcv buffer is
 	 * per socket.   For UDP style sockets this is not true as
@@ -892,7 +895,30 @@ static void sctp_ulpevent_release_data(s
 	 */
 
 	skb = sctp_event2skb(event);
-	sctp_assoc_rwnd_increase(event->asoc, skb_headlen(skb));
+	len = skb->len;
+
+	if (!skb->data_len)
+		goto done;
+
+	/* Don't forget the fragments. */
+	for (frag = skb_shinfo(skb)->frag_list; frag; frag = frag->next) {
+		/* NOTE:  skb_shinfos are recursive. Although IP returns
+		 * skb's with only 1 level of fragments, SCTP reassembly can
+		 * increase the levels.
+		 */
+		sctp_ulpevent_release_frag_data(sctp_skb2event(frag));
+	}
+
+done:
+	sctp_assoc_rwnd_increase(event->asoc, len);
+	sctp_ulpevent_release_owner(event);
+}
+
+static void sctp_ulpevent_release_frag_data(struct sctp_ulpevent *event)
+{
+	struct sk_buff *skb, *frag;
+
+	skb = sctp_event2skb(event);
 
 	if (!skb->data_len)
 		goto done;
@@ -903,7 +929,7 @@ static void sctp_ulpevent_release_data(s
 		 * skb's with only 1 level of fragments, SCTP reassembly can
 		 * increase the levels.
 		 */
-		sctp_ulpevent_release_data(sctp_skb2event(frag));
+		sctp_ulpevent_release_frag_data(sctp_skb2event(frag));
 	}
 
 done:

--
