Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbTBMXQW>; Thu, 13 Feb 2003 18:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268317AbTBMXQW>; Thu, 13 Feb 2003 18:16:22 -0500
Received: from almesberger.net ([63.105.73.239]:13835 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261615AbTBMXQV>; Thu, 13 Feb 2003 18:16:21 -0500
Date: Thu, 13 Feb 2003 20:25:58 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jeff Dike <jdike@karaya.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Oleg Drokin <green@namesys.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.60
Message-ID: <20030213202558.A2791@almesberger.net>
References: <m17kc5yl3o.fsf@frodo.biederman.org> <200302121149.GAA01822@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302121149.GAA01822@ccure.karaya.com>; from jdike@karaya.com on Wed, Feb 12, 2003 at 06:49:49AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
>> Or it can use the linker to play games with symbol names to move the
>> kernel off into it's own separate name space.
> 
> Maybe, I'm not expert enough with the linker to do that.

The basic trick is that  -Wl,--wrap,foo  renames the symbol "foo"
to "__real_foo", and resolves any reference to "foo" to "__wrap_foo".
So you can write wrappers that look like this:

whatever __wrap_foo(...)
{
    /* do stuff */
    blah = __real_foo(...);
    /* do more stuff */
}

While this sounds pretty cool, it comes with a few gotchas:

 - doesn't work for symbols that get resolved at compile time
   (static, maybe also anything in the same compilation unit)
 - when doing incremental linking, you need the -Wl,--wrap there,
   too
 - changing the set of -Wl,--wrap options means that you have to
   rebuild from a make clean afterwards (okay, not such a nightmare
   anymore, thanks to ccache)

I've used this pretty extensively in umlsim. It's okay if you
really want to avoid touching the source underneath. But you
spend a lot of time tracking down the occasional symbol that is
affected by one of the gotchas above ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
