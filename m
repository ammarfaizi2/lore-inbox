Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSI2OWI>; Sun, 29 Sep 2002 10:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262485AbSI2OWI>; Sun, 29 Sep 2002 10:22:08 -0400
Received: from bitchcake.off.net ([216.138.242.5]:24487 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S261678AbSI2OWH>;
	Sun, 29 Sep 2002 10:22:07 -0400
Date: Sun, 29 Sep 2002 10:27:31 -0400
From: Zach Brown <zab@zabbo.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.39 list_head debugging
Message-ID: <20020929102731.A13755@bitchcake.off.net>
References: <20020929015852.K13817@bitchcake.off.net> <Pine.LNX.4.44.0209291027120.12583-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209291027120.12583-100000@localhost.localdomain>; from mingo@elte.hu on Sun, Sep 29, 2002 at 10:33:15AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch adds some straight-forward assertions that check the
> > validity of arguments to the list_* inlines. [...]
> 
> +	BUG_ON(list == NULL);
> +	BUG_ON(list->next == NULL);
> +	BUG_ON(list->prev == NULL);
> 
> these checks are not needed - they'll trivially be oopsing when trying to
> use them, right?

sure, it's just nice to get the message immediately.

> +	BUG_ON((list->next == list) && (list->prev != list));
> +	BUG_ON((list->prev == list) && (list->next != list));
> 
> arent these redundant? If list->next->prev == list and list->prev->next ==
> list, then if list->next == list then list->prev == list. Ditto for the 
> other rule.

I don't think so.  these check for the very strange list state that
results from double list_adds.  its an accident of the ordering of our
member assignments that result in a pretty strange looking list state
after a double_add.  it passes all the double-linked assertions
(list->{next,prev}->{prev,next} == list) but doesn't follow the rule
that both prev and next must point to list if either of them do.

> so i think we only need the following two checks:
> 
> +	BUG_ON(list->next->prev != list);
> +	BUG_ON(list->prev->next != list);

try a double list_add().  these will pass, but the list is not a happy
camper :)

> and we could as well add these unconditionally (no .config complexity
> needed), until 2.6.0 or so, hm?

I'd love that.  It was just a bit of sugar to help the medicine go down.

-- 
 zach
