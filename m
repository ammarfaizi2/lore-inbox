Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTB0NKf>; Thu, 27 Feb 2003 08:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTB0NKf>; Thu, 27 Feb 2003 08:10:35 -0500
Received: from almesberger.net ([63.105.73.239]:11527 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S264919AbTB0NKd>; Thu, 27 Feb 2003 08:10:33 -0500
Date: Thu, 27 Feb 2003 10:20:32 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Message-ID: <20030227102032.K2092@almesberger.net>
References: <20030218050349.44B092C04E@lists.samba.org> <20030218042042.R2092@almesberger.net> <Pine.LNX.4.44.0302181252570.1336-100000@serv> <20030218111215.T2092@almesberger.net> <20030218142257.A10210@almesberger.net> <Pine.LNX.4.44.0302191454520.1336-100000@serv> <20030219231710.Y2092@almesberger.net> <Pine.LNX.4.44.0302212202020.1336-100000@serv> <20030226202647.H2092@almesberger.net> <Pine.LNX.4.44.0302271321190.1336-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302271321190.1336-100000@serv>; from zippel@linux-m68k.org on Thu, Feb 27, 2003 at 01:34:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> There are several module interfaces:
> - module user interface
> - module load interface
> - module driver interface

Hmm, the "load interface" would be the system calls, while
the "driver interface" would be initialization and cleanup
functions in the module ?

We've already established that most things called from the
latter isn't actually module specific.

> These are quite independent and so far we were talking about the last one, 
> so I'm a bit confused about your request to talk about the first.

I'm not so sure about them being independent. E.g. if we
just had a blocking single-phase cleanup, users would always
see success, but resources may be tied up indefinitely, which
would break uses like

rmmod foo
insmod foo.o

On the other hand, with a non-blocking two-phase cleanup, users
would still always see success, but only "anonymous" resources
(memory, etc.) would be tied up.

Last but not least, a non-blocking single-phase cleanup would
expose all failures to the user, and require some retry strategy.

Furthermore, use counts can have several meanings:
 - indicate when it's convenient for the module to be removed
 - indicate when it's possible for the module to be removed
 - indicate what consequences the user may experience if
   trying to remove now (e.g. blocking)

The "old" module count was a bit of a mixture of the first two.
The "new" count is clearer.

Oh, lest I be misunderstood: I'm not saying that we should
redesign everything, and screw compatibility. I just want to
bring the hidden assumptions that have piled up over the life
of the module system out in the open.

Then, of course, there are still plenty of opportunities to
plot any massive breakage ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
