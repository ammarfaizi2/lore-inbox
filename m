Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUIAAcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUIAAcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269080AbUIAA3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:29:41 -0400
Received: from holomorphy.com ([207.189.100.168]:16575 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269067AbUHaTqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:46:01 -0400
Date: Tue, 31 Aug 2004 12:45:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: mita akinobu <amgta@yacht.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <aeb@cwi.nl>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Message-ID: <20040831194552.GQ5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	Andries Brouwer <aeb@cwi.nl>,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com> <200409010145.51224.amgta@yacht.ocn.ne.jp> <20040831192559.GN5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831192559.GN5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 12:25:59PM -0700, William Lee Irwin III wrote:
> > -	if (read(state->fd, state->buf, end - start) == end - start) {
> > -		for (off = 0; off < (end - start)/sizeof(uint32_t); ++off)
> > +	if ((state->bufcnt = read(state->fd, state->buf, end - start)) >= 0) {
> > +		for (off = 0; off < (state->bufcnt)/sizeof(uint32_t); ++off)
> >  			state->last->hits += state->buf[off];

Still wrong =( That needs to be strict inequality.


--- readprofile.c.orig2	2004-08-31 12:11:54.000000000 -0700
+++ readprofile.c	2004-08-31 12:44:25.000000000 -0700
@@ -65,6 +65,7 @@
 	int ret = 0;
 	long page_mask, start, end;
 	unsigned off;
+	ssize_t bufcnt;
 
 	if (!state->stext) {
 		if (!strcmp(state->sym, "_stext"))
@@ -101,8 +102,8 @@
 			exit(EXIT_FAILURE);
 		}
 	}
-	if (read(state->fd, state->buf, end - start) == end - start) {
-		for (off = 0; off < (end - start)/sizeof(uint32_t); ++off)
+	if ((bufcnt = read(state->fd, state->buf, end - start)) > 0) {
+		for (off = 0; off < bufcnt/sizeof(uint32_t); ++off)
 			state->last->hits += state->buf[off];
 	} else {
 		ret = 1;
