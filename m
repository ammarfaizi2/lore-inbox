Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVCPX7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVCPX7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbVCPX6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:58:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:63889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262886AbVCPXzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:55:37 -0500
Date: Wed, 16 Mar 2005 15:54:43 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: davem@davemloft.net, kaber@trash.net, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       cliffw@osdl.org, tytso@mit.edu, rddunlap@osdl.org
Subject: [3/9] [IPSEC]: Fix __xfrm_find_acq_byseq()
Message-ID: <20050316235443.GB5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316235336.GY5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

----

From: "David S. Miller" <davem@davemloft.net>

This function, as it's name implies, is supposed to only
return IPSEC objects which are in the XFRM_STATE_ACQ
("acquire") state.  But it returns any object with the
matching sequence number.

This is wrong and confuses IPSEC daemons to no end.

[XFRM]: xfrm_find_acq_byseq should only return XFRM_STATE_ACQ states.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>

diff -Nru a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
--- a/net/xfrm/xfrm_state.c	2005-03-16 14:27:04 -08:00
+++ b/net/xfrm/xfrm_state.c	2005-03-16 14:27:04 -08:00
@@ -609,7 +609,7 @@
 
 	for (i = 0; i < XFRM_DST_HSIZE; i++) {
 		list_for_each_entry(x, xfrm_state_bydst+i, bydst) {
-			if (x->km.seq == seq) {
+			if (x->km.seq == seq && x->km.state == XFRM_STATE_ACQ) {
 				xfrm_state_hold(x);
 				return x;
 			}
