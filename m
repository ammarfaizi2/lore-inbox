Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262569AbREZXY0>; Sat, 26 May 2001 19:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbREZXYQ>; Sat, 26 May 2001 19:24:16 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262580AbREZW6z>;
	Sat, 26 May 2001 18:58:55 -0400
Date: Sat, 26 May 2001 08:17:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105261139360.30264-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105260812280.3684-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 May 2001, Rik van Riel wrote:
> 
> I am smoking the "tested the patch and wasn't able to reproduce
> a deadlock" stuff.

I'd be happier if _anybody_ was smoking the "thought about the problem
some more" stuff as well.

I can easily imagine that this part of your patch

                if (gfp_mask & __GFP_WAIT) {
                        memory_pressure++;
-                       try_to_free_pages(gfp_mask);
-                       goto try_again;
+                       if (!order || free_shortage()) {
+                               int progress = try_to_free_pages(gfp_mask);
+                               if (progress || gfp_mask & __GFP_IO)
+                                       goto try_again;
+                       }
                }

is fine. The fact that other parts of your patch were NOT fine should make
you go "Hmm, maybe Linus dismissed it for a reason" instead.

Testing is good. But I want to understand how we get into the situation in
the first place, and whether there are ways to alleviate those problems
too.

Testing and finding that the bug went away under your workload is
good. But thinking that that should stop discussion about the _proper_ fix
is stupid, Rik.

		Linus

