Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbTB0TYq>; Thu, 27 Feb 2003 14:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTB0TYq>; Thu, 27 Feb 2003 14:24:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15886 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266368AbTB0TYp>; Thu, 27 Feb 2003 14:24:45 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Invalid compilation without -fno-strict-aliasing
Date: Thu, 27 Feb 2003 19:30:03 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b3lovr$16j$1@penguin.transmeta.com>
References: <873cmbghai.fsf@student.uni-tuebingen.de> <200302262047.h1QKlm0P001784@eeyore.valparaiso.cl> <20030226205754.GA29466@nevyn.them.org> <20030226172213.O3910@devserv.devel.redhat.com>
X-Trace: palladium.transmeta.com 1046374488 10741 127.0.0.1 (27 Feb 2003 19:34:48 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Feb 2003 19:34:48 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030226172213.O3910@devserv.devel.redhat.com>,
Jakub Jelinek  <jakub@redhat.com> wrote:
>
>To fix that, __constant_memcpy would have to access the data through
>union,

Which is impossible, since memcpy _fundamentally_ cannot know what the
different types are..

> or you could as well forget about __constant_memcpy and use
>__builtin_memcpy where gcc will take care about the constant copying.

Which is impossible because (a) historically __builtin_memcpy does a bad
job and (b) it doesn't solve the generic case anyway, ie for other
non-memcpy things.

The fact is, for type-based alias analysis gcc needs a way to tell it
"this can alias", which it doesn't have.  Unions are _not_ useful,
_regardless_ of what silly language lawyers say, since they are not a
generic method.  Unions only work for trivial and largely uninteresting
cases, and it doesn't _matter_ what C99 says about the issue, since that
nasty thing called "real life" interferes.

Until we get some non-union way to say "this can alias", that
-fno-strict-alias has to stay because gcc is too broken to allow us
doing interesting stuff in-line without it. 

My personal opinion is (and was several years ago when this started
coming up) that a cast (any cast) should do it. But I don't are _what_
it is, as long as it is syntactically sane and isn't limited to special
cases like unions.

		Linus
