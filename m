Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317697AbSG2DrC>; Sun, 28 Jul 2002 23:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317712AbSG2DrC>; Sun, 28 Jul 2002 23:47:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14610 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317697AbSG2DrB>; Sun, 28 Jul 2002 23:47:01 -0400
Date: Sun, 28 Jul 2002 20:51:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <20020728.195055.105468330.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0207282048230.913-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, David S. Miller wrote:
>
>    Also skb_release_data(), ___pskb_trim() and __pskb_pull_tail().  Can these
>    ever perform the final release against a page which is on the LRU?
>    In interrupt context?
>
> These page releases run from either user or softint context.
>
> They must never run from HW irqs, in fact there is a BUG()
> check there against this.

>From a page cache standpoint softirq's are 100% equivalent to hardware
irq's, so that doesn't much help here.

> Any page that can be found in the page cache can end up here.  So
> whatever that mean for "release against a page which is on the LRU"
> applies here.

Being in the page cache can be ok. What is _not_ ok is if this function
can ever be the last user to release such a page (ie the original page
count of the page had better be held on by something else - which usually
is the page-cacheness itself, since shrinking the page cache will only
happen for pages that are unused).

		Linus

