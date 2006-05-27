Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWE0CGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWE0CGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 22:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWE0CGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 22:06:10 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:4551 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751757AbWE0CGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 22:06:09 -0400
Message-ID: <348695566.26678@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 27 May 2006 10:06:16 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/33] readahead: state based method - routines
Message-ID: <20060527020616.GA7418@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469543.10865@ustc.edu.cn> <20060526101536.08e7f5be.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526101536.08e7f5be.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 10:15:36AM -0700, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > Define some helpers on struct file_ra_state.
> > 
> > +/*
> > + * The 64bit cache_hits stores three accumulated values and a counter value.
> > + * MSB                                                                   LSB
> > + * 3333333333333333 : 2222222222222222 : 1111111111111111 : 0000000000000000
> > + */
> > +static int ra_cache_hit(struct file_ra_state *ra, int nr)
> > +{
> > +	return (ra->cache_hits >> (nr * 16)) & 0xFFFF;
> > +}
> 
> So...   why not use four u16s?

Sure, me too, have been thinking about it ;-)

> > +/*
> > + * Submit IO for the read-ahead request in file_ra_state.
> > + */
> > +static int ra_dispatch(struct file_ra_state *ra,
> > +			struct address_space *mapping, struct file *filp)
> > +{
> > +	enum ra_class ra_class = ra_class_new(ra);
> > +	unsigned long ra_size = ra_readahead_size(ra);
> > +	unsigned long la_size = ra_lookahead_size(ra);
> > +	pgoff_t eof_index = PAGES_BYTE(i_size_read(mapping->host)) + 1;
> 
> Sigh.  I guess one gets used to that PAGES_BYTE thing after a while.  If
> you're not familiar with it, it obfuscates things.
> 
> <hunts around for its definition>
> 
> So in fact it's converting a loff_t to a pgoff_t.  Why not call it
> convert_loff_t_to_pgoff_t()?  ;)
> 
> Something better, anyway.  Something lower-case and an inline-not-a-macro, too.

I'm now using DIV_ROUND_UP(), maybe we can settle with that.

> > +	int actual;
> > +
> > +	if (unlikely(ra->ra_index >= eof_index))
> > +		return 0;
> > +
> > +	/* Snap to EOF. */
> > +	if (ra->readahead_index + ra_size / 2 > eof_index) {
> 
> You've had a bit of a think and you've arrived at a design decision
> surrounding the arithmetic in here.  It's very very hard to look at this line
> of code and to work out why you decided to implement it in this fashion. 
> The only way to make such code comprehensible (and hence maintainable) is
> to fully comment such things.

Sorry for being a bit lazy.

It is true that some situations are rather tricky, and some
if()/numbers are carefully chosen. I'll continue expanding/detailing
the documentation with future releases. Or would you prefer to add
them as small and distinct patches?

Comments for this one(also rationalized code):

        /* 
         * Snap to EOF, if the request
         *      - crossed the EOF boundary;
         *      - is close to EOF(explained below).
         * 
         * Imagine a file sized 18 pages, and we dicided to read-ahead the
         * first 16 pages. It is highly possible that in the near future we
         * will have to do another read-ahead for the remaining 2 pages,
         * which is an unfavorable small I/O.
         * 
         * So we prefer to take a bit risk to enlarge the current read-ahead,
         * to eliminate possible future small I/O.
         */
        if (ra->readahead_index + ra_readahead_size(ra)/4 > eof_index) {
                ra->readahead_index = eof_index;
                if (ra->lookahead_index > eof_index)
                        ra->lookahead_index = eof_index;
                ra->flags |= RA_FLAG_EOF;
        }

Wu
