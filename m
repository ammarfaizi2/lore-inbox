Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTFFRPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 13:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFFRPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 13:15:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35340 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262127AbTFFRPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 13:15:10 -0400
Date: Fri, 6 Jun 2003 10:28:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: __user annotations
In-Reply-To: <7369DBDA-983E-11D7-8338-000A95A0560C@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0306061016250.20324-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Jun 2003, Hollis Blanchard wrote:
> 
> I was hoping for a little more explanation on that before I used it... 
> for example, will the following code generate a warning? An error?

A warning. But only if you have "check" installed, and do the kernel build 
with "C=1". You can build the whole kernel that way, just do a

	"make C=1 bzImage >& make-output"

and you'll still get a fully functional kernel as a result, but you'll 
also get a whole lot of warnings for drivers etc that haven't been 
annotated.

The nice thing about the annotations is that not only do they give proper 
warnings for the whole call-chain if there is something strange, they 
actually make the source code more readable. You no longer worry about 
whether a pointer is a user pointer or a kernel pointer - it's obvious 
from the sources.

> void func_b(void *b) { }
> 
> void func_a(__user void *a)
> {
> 	func_b(a);
> }
> 
> How about the other way, passing a normal pointer to a function with 
> __user in its prototype?

Also a warning. For example, doing a

	make C=1 sound/oss/awe_wave.o

results in this output:

	  CHECK   sound/oss/awe_wave.c
	warning: sound/oss/awe_wave.c:2049:21: incorrect type in argument 1 (different address spaces)
	warning: sound/oss/awe_wave.c:2049:21:   expected void [noderef] *to<asn:1>
	warning: sound/oss/awe_wave.c:2049:21:   got char *
	warning: sound/oss/awe_wave.c:2855:50: incorrect type in argument 2 (different address spaces)
	warning: sound/oss/awe_wave.c:2855:50:   expected void const [noderef] *from<asn:1>
	warning: sound/oss/awe_wave.c:2855:50:   got char const *addr
	warning: sound/oss/awe_wave.c:3046:33: incorrect type in argument 2 (different address spaces)
	warning: sound/oss/awe_wave.c:3046:33:   expected void const [noderef] *from<asn:1>
	warning: sound/oss/awe_wave.c:3046:33:   got char const *addr
	warning: sound/oss/awe_wave.c:3155:32: incorrect type in argument 2 (different address spaces)
	warning: sound/oss/awe_wave.c:3155:32:   expected void const [noderef] *from<asn:1>
	warning: sound/oss/awe_wave.c:3155:32:   got char const *addr
	warning: sound/oss/awe_wave.c:3291:39: incorrect type in argument 2 (different address spaces)
	warning: sound/oss/awe_wave.c:3291:39:   expected void const [noderef] *from<asn:1>
	warning: sound/oss/awe_wave.c:3291:39:   got char const *addr
	warning: sound/oss/awe_wave.c:3338:36: incorrect type in argument 2 (different address spaces)
	warning: sound/oss/awe_wave.c:3338:36:   expected void const [noderef] *from<asn:1>
	warning: sound/oss/awe_wave.c:3338:36:   got char const *addr
	warning: sound/oss/awe_wave.c:3397:35: incorrect type in argument 2 (different address spaces)
	warning: sound/oss/awe_wave.c:3397:35:   expected void const [noderef] *from<asn:1>
	warning: sound/oss/awe_wave.c:3397:35:   got char const *addr
	warning: sound/oss/awe_wave.c:3454:35: incorrect type in argument 2 (different address spaces)
	warning: sound/oss/awe_wave.c:3454:35:   expected void const [noderef] *from<asn:1>
	warning: sound/oss/awe_wave.c:3454:35:   got char const *addr
	warning: sound/oss/awe_wave.c:3673:50: incorrect type in argument 2 (different address spaces)
	warning: sound/oss/awe_wave.c:3673:50:   expected void const [noderef] *from<asn:1>
	warning: sound/oss/awe_wave.c:3673:50:   got char const *addr
	warning: sound/oss/awe_wave.c:4964:55: incorrect type in argument 2 (different address spaces)
	warning: sound/oss/awe_wave.c:4964:55:   expected void const [noderef] *from<asn:1>
	warning: sound/oss/awe_wave.c:4964:55:   got char const *addr
	warning: sound/oss/awe_wave.c:5072:55: incorrect type in argument 2 (different address spaces)
	warning: sound/oss/awe_wave.c:5072:55:   expected void const [noderef] *from<asn:1>
	warning: sound/oss/awe_wave.c:5072:55:   got char const *addr
	  CC      sound/oss/awe_wave.o

(Right now, "check" does NOT warn about dereferencing a __user pointer 
directly, that will require it to walk the expression tree a second time 
after evaluating the types, and I've been lazy. But the capability is 
there, that's why __user pointers are marked [noderef].).

> I'm just worried that as soon as I use __user once, entire call chains 
> are going to start spewing warnings/errors.

Absolutely. They largely already do - I cleaned up the code kernel files, 
but I didn't have the energy to clean up drivers.

HOWEVER, usually it's very obvious to fix the whole chain, unless some
type is sometimes used for kernel addresses and sometimes for user 
addresses (which networking does with iovec's, for example).

And "check" does give pretty good error messages, pointing out exactly 
which argument it doesn't like, and why, and where the original 
declaration was if there are declaration conflicts etc. That is, after 
all, the whole point of "check".

You can get check from

	bk://kernel.bkbits.net/torvalds/sparse

if you want to play with it.

> I was under the impression that text/plain attachments were ok with 
> you, but it looks like inline will work too.

text/plain is _workable_ (so I did actually apply the patch), but inline
is preferred.

		Linus

