Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWIFXOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWIFXOn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWIFXA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:00:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:57547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751800AbWIFXAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:00:51 -0400
Date: Wed, 6 Sep 2006 15:54:58 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       "David S. Miller" <davem@davemloft.net>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Michael Rash <mbr@cipherdyne.org>, Patrick McHardy <kaber@trash.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 01/37] TEXTSEARCH: Fix Boyer Moore initialization bug
Message-ID: <20060906225458.GB15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="textsearch-fix-boyer-moore-initialization-bug.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Michael Rash <mbr@cipherdyne.org>

[TEXTSEARCH]: Fix Boyer Moore initialization bug

The pattern is set after trying to compute the prefix table, which tries
to use it. Initialize it before calling compute_prefix_tbl, make
compute_prefix_tbl consistently use only the data from struct ts_bm
and remove the now unnecessary arguments.

Signed-off-by: Michael Rash <mbr@cipherdyne.org>
Signed-off-by: Patrick McHardy <kaber@trash.net>
Acked-by: David Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 lib/ts_bm.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- linux-2.6.17.11.orig/lib/ts_bm.c
+++ linux-2.6.17.11/lib/ts_bm.c
@@ -112,15 +112,14 @@ static int subpattern(u8 *pattern, int i
 	return ret;
 }
 
-static void compute_prefix_tbl(struct ts_bm *bm, const u8 *pattern,
-			       unsigned int len)
+static void compute_prefix_tbl(struct ts_bm *bm)
 {
 	int i, j, g;
 
 	for (i = 0; i < ASIZE; i++)
-		bm->bad_shift[i] = len;
-	for (i = 0; i < len - 1; i++)
-		bm->bad_shift[pattern[i]] = len - 1 - i;
+		bm->bad_shift[i] = bm->patlen;
+	for (i = 0; i < bm->patlen - 1; i++)
+		bm->bad_shift[bm->pattern[i]] = bm->patlen - 1 - i;
 
 	/* Compute the good shift array, used to match reocurrences 
 	 * of a subpattern */
@@ -151,8 +150,8 @@ static struct ts_config *bm_init(const v
 	bm = ts_config_priv(conf);
 	bm->patlen = len;
 	bm->pattern = (u8 *) bm->good_shift + prefix_tbl_len;
-	compute_prefix_tbl(bm, pattern, len);
 	memcpy(bm->pattern, pattern, len);
+	compute_prefix_tbl(bm);
 
 	return conf;
 }

--
