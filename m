Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268900AbUHaTbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268900AbUHaTbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269040AbUHaT3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:29:02 -0400
Received: from holomorphy.com ([207.189.100.168]:6591 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269020AbUHaT0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:26:03 -0400
Date: Tue, 31 Aug 2004 12:25:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: mita akinobu <amgta@yacht.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <aeb@cwi.nl>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Message-ID: <20040831192559.GN5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	Andries Brouwer <aeb@cwi.nl>,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com> <200409010145.51224.amgta@yacht.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409010145.51224.amgta@yacht.ocn.ne.jp>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 August 2004 01:22, William Lee Irwin III wrote:
>> Well, since I couldn't stop vomiting for hours after I looked at the
>> code for readprofile(1), here's a reimplementation, with various
>> misfeatures removed, included as a MIME attachment.

On Wed, Sep 01, 2004 at 01:45:51AM +0900, mita akinobu wrote:
> The rewritten readprofile still ignores the last element on my machine.
> Boot option:
> 	profile=2
> System.map:
> 	c0100264 t ignore_int
> 	c0100298 T _stext
> 	c0100298 T calibrate_delay
> 	[...]
> 	c03acbf1 T __spinlock_text_end
> 	c03ae0af A _etext
> 	c03ae0b0 A __start___ex_table

It can't find anything outside a symbol in System.map, as it's
iterating over symbols in System.map. Special treatment for the final
profile buffer position is likely in order.


On Wed, Sep 01, 2004 at 01:45:51AM +0900, mita akinobu wrote:
> This is quick fix.
> --- readprofile.c.orig	2004-08-31 23:01:23.000000000 +0900
> +++ readprofile.c	2004-09-01 01:39:00.316750264 +0900
> @@ -25,6 +25,7 @@ struct profile_state {
>  	int fd, shift;
>  	uint32_t *buf;
>  	size_t bufsz;
> +	size_t bufcnt;
>  	struct sym syms[2], *last, *this;
>  	unsigned long long stext, vaddr;
>  	unsigned long total;
> @@ -101,8 +102,8 @@ static int state_transition(struct profi
>  			exit(EXIT_FAILURE);
>  		}
>  	}
> -	if (read(state->fd, state->buf, end - start) == end - start) {
> -		for (off = 0; off < (end - start)/sizeof(uint32_t); ++off)
> +	if ((state->bufcnt = read(state->fd, state->buf, end - start)) >= 0) {
> +		for (off = 0; off < (state->bufcnt)/sizeof(uint32_t); ++off)
>  			state->last->hits += state->buf[off];
>  	} else {
>  		ret = 1;

So the last read is always short, which is irritating; but bufcnt needs
to be ssize_t or the nonnegativity condition can never fail. Otherwise
it will report bogus results or terminate in a disorderly fashion if
the read() fails outright, e.g. running out of memory or interruption
by signals. So I propose the following alternative patch.


-- wli


--- readprofile.c.orig2	2004-08-31 12:11:54.000000000 -0700
+++ readprofile.c	2004-08-31 12:13:44.000000000 -0700
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
+	if ((bufcnt = read(state->fd, state->buf, end - start)) >= 0) {
+		for (off = 0; off < bufcnt/sizeof(uint32_t); ++off)
 			state->last->hits += state->buf[off];
 	} else {
 		ret = 1;
