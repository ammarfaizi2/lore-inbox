Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263869AbUEHTC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbUEHTC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 15:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUEHTC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 15:02:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:61397 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263869AbUEHTCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 15:02:20 -0400
Date: Sat, 8 May 2004 12:01:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: manfred@colorfullife.com, davej@redhat.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040508120148.1be96d66.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
References: <20040506200027.GC26679@redhat.com>
	<20040506150944.126bb409.akpm@osdl.org>
	<409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Sat, 8 May 2004, Andrew Morton wrote:
> >   */
> >  struct qstr {
> >  	const unsigned char *name;
> > -	unsigned int len;
> >  	unsigned int hash;
> > -};
> > +	unsigned short len;
> > +} __attribute__((packed));
> 
> This would make me nervous.

yeah, that was just mucking about.

> Also, in your previous patch (which I'm not as convinced might be wrong), 
> the d_qstr pointer removal makes me worry:
> 
> -       struct qstr * d_qstr;           /* quick str ptr used in lockless lookup and concurrent d_move */
> 
> I thought the point of d_qstr was that when we do the lockless lookup,
> we're guaranteed to always see "stable storage" in the sense that when we
> follow the d_qstr, we will always get a "char *" + "len" that match, and
> we could never see a partial update (ie len points to the old one, and
> "char *" points to the new one).

It looks that way.

> In particular, think about the "d_compare(parent, qstr, name)" / 
> "memcmp(qstr->name, str, len)" part - what if "len" doesn't match str, 
> because a concurrent d_move() is updating them, and maybe we will compare 
> past the end of kernel mapped memory or something?
> 
> (In other words, the "move_count" check should protect us from returning a 
> wrong dentry, but I'd worry that we'd do something that could cause 
> serious problems before we even get to the "move_count" check).
> 
> Hmm?
> 
> Btw, I'd love to be proven wrong, since I hate that d_qstr, and I think 
> your d_qstr removal patch otherwise looked wonderful.

It looks very similar to 2.4 actually ;)

I think we can simply take ->d_lock a bit earlier in __d_lookup.  That will
serialise against d_move(), fixing the problem which you mention, and also
makes d_movecount go away.
