Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUHaQpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUHaQpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUHaQpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:45:36 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:41957 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261711AbUHaQpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:45:33 -0400
From: mita akinobu <amgta@yacht.ocn.ne.jp>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Date: Wed, 1 Sep 2004 01:45:51 +0900
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <aeb@cwi.nl>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com>
In-Reply-To: <20040829162252.GG5492@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409010145.51224.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 August 2004 01:22, William Lee Irwin III wrote:
> Well, since I couldn't stop vomiting for hours after I looked at the
> code for readprofile(1), here's a reimplementation, with various
> misfeatures removed, included as a MIME attachment.

The rewritten readprofile still ignores the last element on my machine.

Boot option:
	profile=2

System.map:
	c0100264 t ignore_int
	c0100298 T _stext
	c0100298 T calibrate_delay
	[...]
	c03acbf1 T __spinlock_text_end
	c03ae0af A _etext
	c03ae0b0 A __start___ex_table

This is quick fix.


--- readprofile.c.orig	2004-08-31 23:01:23.000000000 +0900
+++ readprofile.c	2004-09-01 01:39:00.316750264 +0900
@@ -25,6 +25,7 @@ struct profile_state {
 	int fd, shift;
 	uint32_t *buf;
 	size_t bufsz;
+	size_t bufcnt;
 	struct sym syms[2], *last, *this;
 	unsigned long long stext, vaddr;
 	unsigned long total;
@@ -101,8 +102,8 @@ static int state_transition(struct profi
 			exit(EXIT_FAILURE);
 		}
 	}
-	if (read(state->fd, state->buf, end - start) == end - start) {
-		for (off = 0; off < (end - start)/sizeof(uint32_t); ++off)
+	if ((state->bufcnt = read(state->fd, state->buf, end - start)) >= 0) {
+		for (off = 0; off < (state->bufcnt)/sizeof(uint32_t); ++off)
 			state->last->hits += state->buf[off];
 	} else {
 		ret = 1;

