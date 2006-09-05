Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWIEIux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWIEIux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 04:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWIEIux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 04:50:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37787 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965053AbWIEIuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 04:50:52 -0400
Date: Tue, 5 Sep 2006 10:43:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 07/16] GFS2: Directory handling
Message-ID: <20060905084334.GA16788@elte.hu>
References: <1157031298.3384.797.camel@quoit.chygwyn.com> <Pine.LNX.4.61.0609041314470.21005@yvahk01.tjqt.qr> <1157445854.3384.965.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157445854.3384.965.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Whitehouse <swhiteho@redhat.com> wrote:

> > >+static inline int __gfs2_dirent_find(const struct gfs2_dirent *dent,
> > >+				     const struct qstr *name, int ret)
> > >+{
> > >+	if (dent->de_inum.no_addr != 0 &&
> > >+	    be32_to_cpu(dent->de_hash) == name->hash &&
> > >+	    be16_to_cpu(dent->de_name_len) == name->len &&
> > >+	    memcmp((char *)(dent+1), name->name, name->len) == 0)
> > 
> > Nocast.
> > 
> ok

actually, sizeof(*dent) != 1, so how can a non-casted memcmp be correct 
here?

> > >+	if ((char *)cur + cur_rec_len >= bh_end) {
> > >+		if ((char *)cur + cur_rec_len > bh_end) {
> > >+			gfs2_consist_inode(dip);
> > >+			return -EIO;
> > >+		}
> > >+		return -ENOENT;
> > >+	}
> > 
> > if((char *)cur + cur_rec_len > bh_end) {
> > 	gfs2_consist_inode(dip);
> > 	return -EIO;
> > } else if((char *)cur + cur_rec_len == bh_end)
> > 	return -ENOENT;
> > 
> ok

this one is not OK! Firstly, Jan, and i mentioned this before, please 
stop using 'if(', it is highly inconsistent and against basic taste. We 
only use this construct for function calls (and macros), not for C 
statements.

Secondly, whenever we have curly braces in the first block, we tend to 
do it in the second block too, for easier parsing. I.e.:

	if ((char *)cur + cur_rec_len > bh_end) {
		gfs2_consist_inode(dip);
		return -EIO;
	} else {
		if ((char *)cur + cur_rec_len == bh_end)
			return -ENOENT;
	}

Thirdly, the original code was quite fine as-is! What's the point of 
introducing random perturbations like this? It is an open invitation for 
the introduction of bugs... So unless there is a clear style reason to 
do a change, i'd suggest to not touch the code.

	Ingo
