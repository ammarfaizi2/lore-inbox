Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSFJRx3>; Mon, 10 Jun 2002 13:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSFJRx2>; Mon, 10 Jun 2002 13:53:28 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:26669 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S312601AbSFJRx1>;
	Mon, 10 Jun 2002 13:53:27 -0400
Date: Mon, 10 Jun 2002 20:51:45 +0300
From: Dan Aloni <da-x@gmx.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>,
        Andreas Dilger <adilger@clusterfs.com>,
        Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
Message-ID: <20020610175145.GA10827@callisto.yi.org>
In-Reply-To: <Pine.GSO.4.05.10206101846060.17299-100000@mausmaki.cosy.sbg.ac.at> <Pine.LNX.4.44.0206100954250.30535-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 10:02:21AM -0700, Linus Torvalds wrote:
> The linux coding style _tends_ to avoid using typedefs. It's not a hard
> rule (and I did in fact apply this patch, since it otherwise looked fine),
> but it's fairly common to use an explicit "struct xxxx" instead of
> "xxxx_t".

I agree. For a better future:

--- linux-2.5.21/Documentation/CodingStyle	Mon Jun 10 20:29:26 2002
+++ linux-2.5.21/Documentation/CodingStyle	Mon Jun 10 20:46:06 2002
@@ -264,3 +264,35 @@
 
 Remember: if another thread can find your data structure, and you don't
 have a reference count on it, you almost certainly have a bug.
+
+
+		Chapter 9: Typedefs
+
+You should avoid using typedefs. It's not a hard rule but it's fairly 
+common to use an explicit "struct xxxx" instead of "xxxx_t".
+
+Hiding the fact that it's a struct causes bad things if people don't
+realize it: allocating structs on the stack is something you should be
+aware of (and careful with), and passing them as parameters is is much
+better done explicitly as a "pointer to struct".
+
+There are _some_ exceptions. For example, "pte_t" etc might well be a
+struct on most architectures, and that's ok: it's expressly designed to be
+an opaque (and still fairly small) thing. This is an example of where
+there are clear _reasons_ for the abstraction, not just abstraction for
+its own sake.
+
+For example, some people like to do things like: 
+
+ /* BAD!!! */    typedef unsigned int counter_t;    /* BAD!!! */
+
+and then use "counter_t" all over the place. I think that's not just ugly,
+but stupid and counter-productive. It makes it much harder to do things
+like "printk()" portably, for example ("should I use %u, %l or just %d?"),
+and generally adds no value. It only _hides_ information, like whether the
+type is signed or not.
+
+There is nothing wrong with just using something like "unsigned long"
+directly, even if it is a few characters longer than you might like. And
+if you care about the number of bits, use "u32" or something. Don't make
+up useless types that have no added advantage.

-- 
Dan Aloni
da-x@gmx.net


P.S.
list_t was added between 2.5.1-pre9 and 2.5.1-pre10, when you applied 
Ingo's scalable scheduler code. Since then it gained a few users: device.h, 
fs.h, sched.h, and mm.h. It can be kicked out easily.
