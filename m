Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUIAQU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUIAQU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUIAQSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:18:46 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:14058 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S266474AbUIAQJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:09:11 -0400
From: mita akinobu <amgta@yacht.ocn.ne.jp>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Date: Thu, 2 Sep 2004 01:09:32 +0900
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <aeb@cwi.nl>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040831192559.GN5492@holomorphy.com> <20040831194552.GQ5492@holomorphy.com>
In-Reply-To: <20040831194552.GQ5492@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409020109.32605.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 September 2004 04:45, William Lee Irwin III wrote:
> Still wrong =( That needs to be strict inequality.
>
>
> --- readprofile.c.orig2	2004-08-31 12:11:54.000000000 -0700
> +++ readprofile.c	2004-08-31 12:44:25.000000000 -0700
> @@ -65,6 +65,7 @@
>  	int ret = 0;
>  	long page_mask, start, end;
>  	unsigned off;
> +	ssize_t bufcnt;
>
>  	if (!state->stext) {
>  		if (!strcmp(state->sym, "_stext"))
> @@ -101,8 +102,8 @@
>  			exit(EXIT_FAILURE);
>  		}
>  	}
> -	if (read(state->fd, state->buf, end - start) == end - start) {
> -		for (off = 0; off < (end - start)/sizeof(uint32_t); ++off)
> +	if ((bufcnt = read(state->fd, state->buf, end - start)) > 0) {
> +		for (off = 0; off < bufcnt/sizeof(uint32_t); ++off)
>  			state->last->hits += state->buf[off];
>  	} else {
>  		ret = 1;

If you're passing profile=0 on boot, it exits very early.
(when readprofile saw the symbol whose address is same with next line's
symbol address)

and,
On ia64, the following System.map was generated:

[...]
a000000100000000 A _stext
a000000100000000 A _text		(*)
a000000100000000 T ia64_ivt
a000000100000000 t vhpt_miss

Since the symbol "_text" (*) has absolute symbol type, it could not pass the
is_text() check, and readprofile exits immediately.

BTW, if profile=>1 is passed, The range between start and end in
state_transition() is overlapped every call. Is it intentional?

# readprofile -b (after applied below patch)

[...]
__wake_up_common:
          c011f1d8              47		(*)
__wake_up:
          c011f1d8              47		(*)
          c011f1dc               2



--- readprofile.c.orig	2004-09-02 00:04:55.904405440 +0900
+++ readprofile.c	2004-09-02 00:37:37.277231448 +0900
@@ -25,6 +25,7 @@ struct profile_state {
 	int fd, shift;
 	uint32_t *buf;
 	size_t bufsz;
+	ssize_t bufcnt;
 	struct sym syms[2], *last, *this;
 	unsigned long long stext, vaddr;
 	unsigned long total;
@@ -60,6 +61,32 @@ static long profile_off(unsigned long lo
 	return (((vaddr - state->stext) >> state->shift) + 1)*sizeof(uint32_t);
 }
 
+int optBin;
+
+static void display_hits(struct profile_state *state)
+{
+	char *name = state->last->name;
+	unsigned long hits = state->last->hits;
+
+	if (!hits)
+		return;
+	if (!optBin)
+		printf("%*lu %s\n", digits(), hits, name);
+	else {
+		unsigned long long vaddr = state->last->vaddr;
+		int shift = state->shift;
+		unsigned int off;
+		
+		printf("%s:\n", name);
+		for (off = 0; off < state->bufcnt/sizeof(uint32_t); ++off)
+			if (state->buf[off]) {
+				printf("\t%*llx", digits(),
+					((vaddr >> shift) + off) << shift);
+				printf("\t%*lu\n", digits(), state->buf[off]);
+			}
+	}
+}
+
 static int state_transition(struct profile_state *state)
 {
 	int ret = 0;
@@ -101,16 +128,14 @@ static int state_transition(struct profi
 			exit(EXIT_FAILURE);
 		}
 	}
-	if (read(state->fd, state->buf, end - start) == end - start) {
-		for (off = 0; off < (end - start)/sizeof(uint32_t); ++off)
+	if ((state->bufcnt = read(state->fd, state->buf, end - start)) > 0) {
+		for (off = 0; off < state->bufcnt/sizeof(uint32_t); ++off)
 			state->last->hits += state->buf[off];
 	} else {
 		ret = 1;
 		strcpy(state->last->name, "*unknown*");
 	}
-	if (state->last->hits)
-		printf("%*lu %s\n", digits(), state->last->hits,
-							state->last->name);
+	display_hits(state);
 	state->total += state->last->hits;
 out:
 	return ret;
@@ -169,7 +194,7 @@ int main(int argc, char * const argv[])
 {
 	FILE *system_map = NULL;
 	int c, ret, profile_buffer = -1;
-	static const char optstr[] = "m:p:";
+	static const char optstr[] = "m:p:b";
 
 	while ((c = getopt(argc, argv, optstr)) != EOF) {
 		switch (c) {
@@ -195,6 +220,9 @@ int main(int argc, char * const argv[])
 					exit(EXIT_FAILURE);
 				}
 				break;
+			case 'b':
+				optBin = 1;
+				break;
 			case '?':
 			default:
 				fprintf(stderr, "usage: %s [ -m mapfile ] "

