Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbTB0Tfy>; Thu, 27 Feb 2003 14:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTB0Tfy>; Thu, 27 Feb 2003 14:35:54 -0500
Received: from crack.them.org ([65.125.64.184]:24239 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S266257AbTB0Tfu>;
	Thu, 27 Feb 2003 14:35:50 -0500
Date: Thu, 27 Feb 2003 14:45:22 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invalid compilation without -fno-strict-aliasing
Message-ID: <20030227194522.GA10427@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <873cmbghai.fsf@student.uni-tuebingen.de> <200302262047.h1QKlm0P001784@eeyore.valparaiso.cl> <20030226205754.GA29466@nevyn.them.org> <20030226172213.O3910@devserv.devel.redhat.com> <b3lovr$16j$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3lovr$16j$1@penguin.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 07:30:03PM +0000, Linus Torvalds wrote:
> In article <20030226172213.O3910@devserv.devel.redhat.com>,
> Jakub Jelinek  <jakub@redhat.com> wrote:
> >
> >To fix that, __constant_memcpy would have to access the data through
> >union,
> 
> Which is impossible, since memcpy _fundamentally_ cannot know what the
> different types are..
> 
> > or you could as well forget about __constant_memcpy and use
> >__builtin_memcpy where gcc will take care about the constant copying.
> 
> Which is impossible because (a) historically __builtin_memcpy does a bad
> job and (b) it doesn't solve the generic case anyway, ie for other
> non-memcpy things.
> 
> The fact is, for type-based alias analysis gcc needs a way to tell it
> "this can alias", which it doesn't have.  Unions are _not_ useful,
> _regardless_ of what silly language lawyers say, since they are not a
> generic method.  Unions only work for trivial and largely uninteresting
> cases, and it doesn't _matter_ what C99 says about the issue, since that
> nasty thing called "real life" interferes.
> 
> Until we get some non-union way to say "this can alias", that
> -fno-strict-alias has to stay because gcc is too broken to allow us
> doing interesting stuff in-line without it. 
> 
> My personal opinion is (and was several years ago when this started
> coming up) that a cast (any cast) should do it. But I don't are _what_
> it is, as long as it is syntactically sane and isn't limited to special
> cases like unions.

Well, if that's all you're asking for, it's easy - I don't know if
you'll agree that the syntax is sane, but it's there.  From the GCC 3.3
manual:

`may_alias'
     Accesses to objects with types with this attribute are not
     subjected to type-based alias analysis, but are instead assumed to
     be able to alias any other type of objects, just like the `char'
     type.  See `-fstrict-aliasing' for more information on aliasing
     issues.

     Example of use:

          typedef short __attribute__((__may_alias__)) short_a;

          int
          main (void)
          { 
            int a = 0x12345678;
            short_a *b = (short_a *) &a;

            b[1] = 0;

            if (a == 0x12345678)
              abort();

            exit(0);
          }

     If you replaced `short_a' with `short' in the variable
     declaration, the above program would abort when compiled with
     `-fstrict-aliasing', which is on by default at `-O2' or above in
     recent GCC versions.


So you define a typedef for unsigned long which has the __may_alias__
attribute, and you go to town writing memcpy inline with that type
instead of a normal unsigned long.


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
