Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVC2Umw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVC2Umw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVC2Umw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:42:52 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:7055 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261413AbVC2UlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:41:15 -0500
Message-ID: <4249BD6B.7070600@comcast.net>
Date: Tue, 29 Mar 2005 15:41:15 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Brandon Hale <brandon@smarterits.com>, ubuntu-hardened@lists.ubuntu.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ubuntu-hardened] Re: Collecting NX information
References: <42484B13.4060408@comcast.net>	 <1112035059.6003.44.camel@laptopd505.fenrus.org>	 <4248520E.1070602@comcast.net>	 <1112036121.6003.46.camel@laptopd505.fenrus.org>	 <424857B0.4030302@comcast.net>	 <1112043246.10117.5.camel@localhost.localdomain>	 <4248828B.20708@comcast.net>	 <1112080581.6282.1.camel@laptopd505.fenrus.org>	 <4249096B.7020802@comcast.net>	 <1112083762.6282.23.camel@laptopd505.fenrus.org>	 <424911FF.1080702@comcast.net>	 <1112086016.6282.36.camel@laptopd505.fenrus.org>	 <42499C40.5030202@comcast.net>	 <1112121756.6282.88.camel@laptopd505.fenrus.org>	 <4249A78A.1040407@comcast.net> <1112124890.6282.99.camel@laptopd505.fenrus.org>
In-Reply-To: <1112124890.6282.99.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Tue, 2005-03-29 at 14:07 -0500, John Richard Moser wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----

[...]

>>/me shrugs.  It's a security blanket for him mostly; he fears automagic
>>security maintainence.
> 
> 
> who is "him" ?
> 

me in third person?  :)

> 
>>>>Remember also I'm very much against "let the compiler guess if you need
>>>>an executable stack"
>>>
>>>
>>>it's not guessing. the *compiler* emits the stack trampoline. So the
>>>*compiler* knows that it needs that stack.
>>>
>>
>>With a trampoline, things like Grub and a few libs need PT_GNU_STACK.
> 
> 
> sure they do. There's about a handful in an entire distro.

Right, so it's a toss-up:  Do you want to fix these few things, or do
you want to let trampolines exist?  Are trampolines that useful?

> 
> 
>>Of course you can't just suddenly say "OH!  Well PT_GNU_STACK should do
>>this instead!" because you'll break everything.
> 
> 
> I'm not a fan of any kind of emutrampoline. At all. But I am open to
> others making a different tradeoff; for me the option to have a
> trampoline at all is just a bypass of the non-exec stack... legit bypass
> one hopes but a bypass regardless. Some time ago we did an eval of how
> much stuff would need the emutramp (well or something equivalent) and
> the list was so small that I decided that the added risk and complexity
> were not worth it and that I rather had those 5 or so apps run with exec
> stack.
> 

Eh.

> 
>>>again what does tristate mean.. "I don't know" ? But gcc does know, with
>>>very very very few exceptions. Eg old mono is the exception because it
>>>didn't do a proper mprotect. Saying "I don't know" doesn't solve you
>>>anything, since in the end there needs to be a policy enforced anyway,
>>>it's just postponing the inevitable to a point with less knowledge.
>>>
>>
>>Remember I'm also thinking of restricted mprotect() situations as well,
>>because I'm trying to get it to the point where one set of markings has
>>a predictable effect on any kernel, be it vanilla, pax, or ES.
> 
> 
> well that is an entirely independent thing again. Really.
> I think mixing all these into one big flag is a mistake. 
> (And thats a lesson I learned the hard way, but Linus was right; don't
> mix independent things into one flag artificially. Extra flags are
> cheap. Don't complicate the world for a dozen bytes.)
> 
> 

two or four dozen bytes, eight dozen bytes in 10 years when 128 bit
systems come along, and 16i dozen planck qubytes when we get quantum
computers :)

Actually when I proposed adding PT_PAX_FLAGS to Ubuntu, the very first
argument I got was "Oh, yeah right, add just a few bytes here for this.
 Then later it'll be a few more bytes for something else.  Then a few
more for another thing.  It all adds up, especially when you have
thousands of binaries."

And if bitfield logic is "complicated," you should stop pretending to be
a programmer.


#define BIG   (1)
#define LONG  (1 << 1)
#define FAT   (1 << 2)
#define TALL  (1 << 3)
#define GREEN (1 << 4)

struct foo {
  char *myname;
  unsigned long flags;
};

struct foo *newfoo() {
  struct foo *out = malloc(sizeof(struct foo));
  out->myname = malloc(4);
  strcpy(out->myname, "bob");
  out->flags = BIG | TALL | GREEN;
  return out;
}


Easy enough?


struct foo {
  char myname[10];
  int big;
  int long;
  int fat;
  int tall;
  int green;
};

struct foo *newfoo() {
  struct foo *out = malloc(sizeof(struct foo));
  strcpy(out->myname, "bob");
  out->big = 1;
  out->tall = 1;
  out->green = 1;
  return out;
}


I don't find the above to be quite as elegant.  In fact, it looks ugly
and wasteful; even checking ...

if (myfoo->flags & BIG)

versus

if (myfoo->big)

> 
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCSb1rhDd4aOud5P8RAg2cAJ98SlxFCLcHvN+aWcVTM2VWxiRCEACfUPPl
24wpdtY/VyKHGs/YpPDo8Hk=
=mVc5
-----END PGP SIGNATURE-----
