Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVITW5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVITW5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVITW5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:57:34 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:33462 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750722AbVITW5d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:57:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MoJ6t8j5O0s/SOM0JZGF0HWKwMeXPvleTv+TeEIJAB6YSzuuNGA8rtbE3nnDZ8szCKlLE9cHK+cF3eu0AglIPNeDdLZS8mTl4AdzcPg6QbOnI98WMpgl7qdrFX3l0TZo+DB3drRkmAWwVYifaGJwWo7ImpMc1pGPD7wp2SQt2xU=
Message-ID: <feed8cdd050920155714510453@mail.gmail.com>
Date: Tue, 20 Sep 2005 15:57:31 -0700
From: Stephen Pollei <stephen.pollei@gmail.com>
Reply-To: stephen.pollei@gmail.com
To: Alexandre Oliva <aoliva@redhat.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Nikita Danilov <nikita@clusterfs.com>,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <or4q8fvd6r.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <nikita@clusterfs.com>
	 <17197.15183.235861.655720@gargle.gargle.HOWL>
	 <200509192316.j8JNFxY8030819@inti.inf.utfsm.cl>
	 <feed8cdd0509192057e1aa9e3@mail.gmail.com>
	 <or4q8fvd6r.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Alexandre Oliva <aoliva@redhat.com> wrote:
> On Sep 20, 2005, Stephen Pollei <stephen.pollei@gmail.com> wrote:
> > On 9/19/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> >> Since when has a missing declaration prevented anyone calling a function in
> >> C?!
> > Never AFAIK... K&R, ANSI,ISO C89,  c99, whatever version that I know of...
> 
> Actually...  C99 requires a declaration (not necessarily with a
> prototype) before a function can be called.  A prior declaration is
> required for all identifiers.

OK thank you for your correction.

> I'm not sure whether this is new in C99
> or carried over from ISO C90 (AKA ANSI C89).  The fact that so many
> compilers accept calls without prior declarations is a common
> extension to the language, mainly for backward compatibility.

yep I just tested a small program with different flags...
int main(void) {
  int ret;
  ret=my_func(3);
  return 0; }

float my_func(double x) {
  return x+2.0;}

gcc -Wall test_proto.c --std=c99
and even gcc -Wall test_proto.c --std=c99 -pedantic
give me this:
test_proto.c: In function `main':
test_proto.c:6: warning: implicit declaration of function `my_func'
test_proto.c: At top level:
test_proto.c:9: warning: type mismatch with previous implicit declaration
test_proto.c:6: warning: previous implicit declaration of `my_func'
test_proto.c:9: warning: `my_func' was previously implicitly declared
to return `int'

it takes gcc -Wall test_proto.c --std=c99 -pedantic-errors to cause it
not to create the a.out .
So gcc should have caused an error as I didn't set --std=gnu99 .. bad compiler.

So I don't know howto get gcc to follow the standards in this area,
that sounds like a good thing to require.

> > It's really over silly anyway, as it will fail at link time if they
> > had matching preprocessor stuff around the function definition.

> Not really.  A compiler might optimize away the reference to the
> symbol if it's say guarded by a condition whose value can be
> determined to be false at compile time.  If you rely on that, moving
> to a different compiler that is unable to compute the condition value,
> or simply is pickier as to standard compliance, will get you errors.

True again, especially since the kernel code itself relies on that
kind of behavior in some of it's inline functions or macros for
example to cause link errors only when specific conditions arise.
so the construct:

#if conditions
/* function prototype(s) */
#else
#define whatever(a,b,c) /* something to crash the compile */
#endif
is truely the best solution, if the namesys people want to be
absolutely sure to catch all
calls to znode_is_loaded when debuging is not set....

#define znode_is_loaded(I_dont_care_you_are_going_to_) \
 } )die(]0now[>anyway<}}}}}}*bye*}
#define znode_is_loaded(z) ><<<>

Either one of the above defines should be sufficiently crappy to cause
gcc to bomb out.
I'm so sure(some say full) of it that I'm too lazy to test it out for myself.
Of course a _Pragma("error") would`a been nice.

Simply not providing a prototype to generate a warning was just
BAD(B0rken As Designed).

-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
