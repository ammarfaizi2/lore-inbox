Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbTAOIPw>; Wed, 15 Jan 2003 03:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTAOIPw>; Wed, 15 Jan 2003 03:15:52 -0500
Received: from dp.samba.org ([66.70.73.150]:42205 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265854AbTAOIPt>;
	Wed, 15 Jan 2003 03:15:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __cacheline_aligned_in_smp? 
In-reply-to: Your message of "Mon, 13 Jan 2003 22:32:53 -0800."
             <20030113.223253.18825371.davem@redhat.com> 
Date: Wed, 15 Jan 2003 19:02:20 +1100
Message-Id: <20030115082444.0CFFA2C123@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030113.223253.18825371.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Tue, 14 Jan 2003 12:10:12 +1100
> 
>    Hmm, you really want to weakly align it: you don't care if something follo
ws it on
>    the cacheline, (ie. don't make it into an array, but it'd be nice if other
>    things could share the cacheline) in UP.
>    
> No, that is an incorrect statement.
> 
> I want the rest of the cacheline to be absent of any write-possible
> data.  There are many members in there which are read-only and thus
> will only consume a cacheline which would never need to be written
> back to main memory due to modification.

But it's not quite that simple, either.  If we say dirty cachelines
cost twice as much as read-only ones (ie. read + write vs. read +
discard), it gives some guide.  In particular, if a structure has
parts:
	struct foo {
		readonly R;
		writeable W;
	};

And it normally fits in one cacheline, but you set the alignment of W
to a cacheline, now it fits in two, you've lost.  (Note, struct
tcp_hashinfo is not such a structure, this is just talking to the
gallery).

> You really don't understand what I'm trying to accomplish.

No.  Thanks for the explanation.

> I want alignment on cache line boundary, and I don't want anything
> else in that cacheline.

A "read-mostly" section might be appropriate, then.  Of course, you'd
have to split the structure, in that case, and it's not worth it if
there are only a few of these.

Have I finally got it through my thick skull now?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
