Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757425AbWK2AOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425AbWK2AOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 19:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757464AbWK2AOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 19:14:00 -0500
Received: from smtp.osdl.org ([65.172.181.25]:30932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757425AbWK2AN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 19:13:59 -0500
Date: Tue, 28 Nov 2006 16:13:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       trivial@kernel.org
Subject: Re: [PATCH] Don't compare unsigned variable for <0 in sys_prctl()
In-Reply-To: <9a8748490611281542l2b05ab78kef8247b04f8c5389@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611281600020.4244@woody.osdl.org>
References: <200611282317.14020.jesper.juhl@gmail.com> 
 <Pine.LNX.4.64.0611281425220.4244@woody.osdl.org> 
 <9a8748490611281434g3741045v5e7f952f633e08d3@mail.gmail.com> 
 <Pine.LNX.4.64.0611281459331.4244@woody.osdl.org>
 <9a8748490611281542l2b05ab78kef8247b04f8c5389@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2006, Jesper Juhl wrote:
> 
> I would venture that "-Wshadow" is another one of those. 

I'd agree, except for the fact that gcc does a horribly _bad_ job of 
-Wshadow, making it (again) totally unusable.

For example, it's often entirely interesting to hear about local variables 
that shadow each other. No question about it.

HOWEVER. It's _not_ really interesting to hear about a local variable that 
happens to have a common name that is also shared by a extern function. 

There just isn't any room for confusion, and it's actually not even that 
unusual - I tried using -Wshadow on real programs, and it was just 
horribly irritating.

In the kernel, we had obvious things like local use of "jiffies" that just 
make _total_ sense in a small inline function, and the fact that there 
happens to be an extern declaration for "jiffies" just isn't very 
interesting.

Similarly, with nested macro expansion, even the "local variable shadows 
another local variable" case - that looks like it should have an obvious 
warning on the face of it - really isn't always necessarily that 
interesting after all. Maybe it is a bug, maybe it isn't, but it's no 
longer _obviously_ bogus any more.

So I'm not convinced about the usefulness of "-Wshadow". ESPECIALLY the 
way that gcc implements it, it's almost totally useless in real life.

For example, I tried it on "git" one time, and this is a perfect example 
of why "-Wshadow" is totally broken:

	diff-delta.c: In function 'create_delta_index':
	diff-delta.c:142: warning: declaration of 'index' shadows a global declaration

(and there's a _lot_ of those). If I'm not allowed to use "index" as a 
local variable and include <string.h> at the same time, something is 
simply SERIOUSLY WRONG with the warning.

So the fact is, the C language has scoping rules for a reason. Can you 
screw yourself by usign them badly? Sure. But that does NOT mean that the 
same name in different scopes is a bad thing that should be warned about.

If I wanted a language that didn't allow me to do anything wrong, I'd be 
using Pascal. As it is, it turns out that things that "look" wrong on a 
local level are often not wrong after all.

			Linus
