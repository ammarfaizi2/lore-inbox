Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUIAQbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUIAQbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUIAQaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:30:25 -0400
Received: from holomorphy.com ([207.189.100.168]:41414 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267747AbUIAQ2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:28:00 -0400
Date: Wed, 1 Sep 2004 09:27:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: mita akinobu <amgta@yacht.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <aeb@cwi.nl>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Message-ID: <20040901162754.GC5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	Andries Brouwer <aeb@cwi.nl>,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040831192559.GN5492@holomorphy.com> <20040831194552.GQ5492@holomorphy.com> <200409020109.32605.amgta@yacht.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409020109.32605.amgta@yacht.ocn.ne.jp>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 01:09:32AM +0900, mita akinobu wrote:
> If you're passing profile=0 on boot, it exits very early.
> (when readprofile saw the symbol whose address is same with next line's
> symbol address)
> and,
> On ia64, the following System.map was generated:
> [...]
> a000000100000000 A _stext
> a000000100000000 A _text		(*)
> a000000100000000 T ia64_ivt
> a000000100000000 t vhpt_miss
> Since the symbol "_text" (*) has absolute symbol type, it could not pass the
> is_text() check, and readprofile exits immediately.

That is bizarre and very irritating, as at first glance it appears to
require strcmp() on every entry until _stext is set.


On Thu, Sep 02, 2004 at 01:09:32AM +0900, mita akinobu wrote:
> BTW, if profile=>1 is passed, The range between start and end in
> state_transition() is overlapped every call. Is it intentional?
> # readprofile -b (after applied below patch)
> [...]
> __wake_up_common:
>           c011f1d8              47		(*)
> __wake_up:
>           c011f1d8              47		(*)
>           c011f1dc               2

Overlapping the symbols was intentional, yes. The way profiling works
is that the shift passed by profile= represents a power-of-two-sized
divisor that the virtual addresses are divided by. These bins don't
respect symbol boundaries and in fact multiple functions may share them.
I choose to account a bin to all symbols whose virtual address range
overlaps it.


> --- readprofile.c.orig	2004-09-02 00:04:55.904405440 +0900
> +++ readprofile.c	2004-09-02 00:37:37.277231448 +0900
> @@ -25,6 +25,7 @@ struct profile_state {
>  	int fd, shift;
>  	uint32_t *buf;
>  	size_t bufsz;
> +	ssize_t bufcnt;
>  	struct sym syms[2], *last, *this;
>  	unsigned long long stext, vaddr;
>  	unsigned long total;
> @@ -60,6 +61,32 @@ static long profile_off(unsigned long lo
>  	return (((vaddr - state->stext) >> state->shift) + 1)*sizeof(uint32_t);
>  }
>  
> +int optBin;

No global variables and no studlycaps...


On Thu, Sep 02, 2004 at 01:09:32AM +0900, mita akinobu wrote:
> +static void display_hits(struct profile_state *state)
> +{
> +	char *name = state->last->name;
> +	unsigned long hits = state->last->hits;
> +
> +	if (!hits)
> +		return;
> +	if (!optBin)
> +		printf("%*lu %s\n", digits(), hits, name);
> +	else {
> +		unsigned long long vaddr = state->last->vaddr;
> +		int shift = state->shift;
> +		unsigned int off;
> +		
> +		printf("%s:\n", name);
> +		for (off = 0; off < state->bufcnt/sizeof(uint32_t); ++off)
> +			if (state->buf[off]) {
> +				printf("\t%*llx", digits(),
> +					((vaddr >> shift) + off) << shift);
> +				printf("\t%*lu\n", digits(), state->buf[off]);
> +			}
> +	}
> +}

Okay, now that you have a use for ->bufcnt in struct state, it may make
sense to keep it around.


On Thu, Sep 02, 2004 at 01:09:32AM +0900, mita akinobu wrote:
>  static int state_transition(struct profile_state *state)
>  {
>  	int ret = 0;
> @@ -101,16 +128,14 @@ static int state_transition(struct profi
>  			exit(EXIT_FAILURE);
>  		}
>  	}
> -	if (read(state->fd, state->buf, end - start) == end - start) {
> -		for (off = 0; off < (end - start)/sizeof(uint32_t); ++off)
> +	if ((state->bufcnt = read(state->fd, state->buf, end - start)) > 0) {
> +		for (off = 0; off < state->bufcnt/sizeof(uint32_t); ++off)
>  			state->last->hits += state->buf[off];
>  	} else {
>  		ret = 1;
>  		strcpy(state->last->name, "*unknown*");
>  	}
> -	if (state->last->hits)
> -		printf("%*lu %s\n", digits(), state->last->hits,
> -							state->last->name);
> +	display_hits(state);
>  	state->total += state->last->hits;
>  out:
>  	return ret;

It may make more sense to pass a display callback instead, particularly
if potential future usage in a library wants to render to streams that
are not stdout or cares to render to things that aren't streams. This
looks like it's against an older version... this seems to qualify as
enough interest to at least use source control.


-- wli
