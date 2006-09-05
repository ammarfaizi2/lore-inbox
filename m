Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWIEJ0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWIEJ0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 05:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWIEJ0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 05:26:08 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:60352 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965178AbWIEJ0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 05:26:06 -0400
Date: Tue, 5 Sep 2006 11:22:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Steven Whitehouse <swhiteho@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 07/16] GFS2: Directory handling
In-Reply-To: <20060905084334.GA16788@elte.hu>
Message-ID: <Pine.LNX.4.61.0609051111480.28583@yvahk01.tjqt.qr>
References: <1157031298.3384.797.camel@quoit.chygwyn.com>
 <Pine.LNX.4.61.0609041314470.21005@yvahk01.tjqt.qr>
 <1157445854.3384.965.camel@quoit.chygwyn.com> <20060905084334.GA16788@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > >+static inline int __gfs2_dirent_find(const struct gfs2_dirent *dent,
>> > >+				     const struct qstr *name, int ret)
>> > >+{
>> > >+	if (dent->de_inum.no_addr != 0 &&
>> > >+	    be32_to_cpu(dent->de_hash) == name->hash &&
>> > >+	    be16_to_cpu(dent->de_name_len) == name->len &&
>> > >+	    memcmp((char *)(dent+1), name->name, name->len) == 0)
>> > 
>> > Nocast.
>> > 
>> ok
>
>actually, sizeof(*dent) != 1, so how can a non-casted memcmp be correct 
>here?

There is an implicit reinterpret_cast<> from char* to void* when using 
memcmp, because void* is what memcpy takes as first argument. So, in effect 
we are doing

	memcmp((void *)(char *)(dent + 1), ...)

and that cast is, in this case, redundant, meaning we can do

	memcmp((void *)(dent + 1), ...)

But since conversion from and to void* is implicit in C, we can do

	memcmp(dent + 1, ...)


>> > >+	if ((char *)cur + cur_rec_len >= bh_end) {
>> > >+		if ((char *)cur + cur_rec_len > bh_end) {
>> > >+			gfs2_consist_inode(dip);
>> > >+			return -EIO;
>> > >+		}
>> > >+		return -ENOENT;
>> > >+	}
>> > 
>> > if((char *)cur + cur_rec_len > bh_end) {
>> > 	gfs2_consist_inode(dip);
>> > 	return -EIO;
>> > } else if((char *)cur + cur_rec_len == bh_end)
>> > 	return -ENOENT;
>> > 
>> ok
>
>this one is not OK! Firstly, Jan, and i mentioned this before, please 
>stop using 'if(', it is highly inconsistent and against basic taste. We 
>only use this construct for function calls (and macros), not for C 
>statements.

Now there is no rule in CodingStyle for this yet. Plus, I was wanting to show
how to reorder the construct, so change in whitespace between "if" and "(" is
outoftopic.

11:17 gwdg-wb04A:~/linux > grep -Pri '(if|for|while)\(' . | wc -l
24242

[To be honest, I also present the other number:]
11:17 gwdg-wb04A:~/linux > grep -Pri '(if|for|while) \(' . | wc -l
380895

Although a minority, it does not seem so uncommon.



>Secondly, whenever we have curly braces in the first block, we tend to 
>do it in the second block too, for easier parsing. I.e.:
>
>	if ((char *)cur + cur_rec_len > bh_end) {
>		gfs2_consist_inode(dip);
>		return -EIO;
>	} else {
>		if ((char *)cur + cur_rec_len == bh_end)
>			return -ENOENT;
>	}

I would very much like to do just this

		many insns;
	} else if(...) {
		single insn;
	}

but again, some people think no {} should be there because it's just a single
insn. Though I don't go harvesting in lkml.org archives right now to prove
this claim.



>Thirdly, the original code was quite fine as-is! What's the point of 
>introducing random perturbations like this? It is an open invitation for 
>the introduction of bugs... So unless there is a clear style reason to 
>do a change, i'd suggest to not touch the code.

Intent was reduction of indent. ""The answer to that is that if you need
more than 3 levels of indentation, you're screwed anyway, and should fix
your program."" so says CodingStyle, though the 3-level barrier was only
touched this time.

No offense!



Jan Engelhardt
-- 
