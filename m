Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSLHXPU>; Sun, 8 Dec 2002 18:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSLHXPU>; Sun, 8 Dec 2002 18:15:20 -0500
Received: from mail.aurema.com ([203.31.96.1]:14089 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id <S261839AbSLHXPT>;
	Sun, 8 Dec 2002 18:15:19 -0500
Date: Mon, 9 Dec 2002 10:22:56 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Rusty Trivial Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Re: setrlimit incorrectly allows hard limits to exceed soft limits
Message-ID: <20021209102256.C12270@aurema.com>
References: <20021206035756.2CD1A2C28C@lists.samba.org> <Pine.LNX.4.50L.0212061106050.22252-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50L.0212061106050.22252-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Dec 06, 2002 at 11:07:00AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 11:07:00AM -0200, Rik van Riel wrote:
> On Fri, 6 Dec 2002, Rusty Trivial Russell wrote:
> 
> > > Just try "ulimit -H -m 10000" for memory limits that were not
> > > previously set.  You end up with (hard limit = 10000) < (soft limit =
> > > unlimited).
> 
> > +       if (new_rlim.rlim_cur > new_rlim.rlim_max)
> > +               return -EINVAL;
> 
> Wouldn't it be better to simply take the soft limit down
> to min(new_rlim.rlim_cur, new_rlim.rlim_max) ?

Another way to do it would be to adjust the max limit up to the soft
limit only if the process had CAP_SYS_RESOURCE, just like in the
function svr4_ulimit in abi/svr4/ulimit.c.

In both cases, however, changing it will mean changing a limit on
behalf of the process.  But IMHO wouldn't most applications would
expect rlimits modified with setrlimit successfully to be set to the
rlimits that they specified as the argument?  Any child processes they
spawn would expect the same set of modified rlimits to be inherited as
well.  If we fix an incorrect pair of rlimits on their behalf, they
would then see different rlimit values with getrlimit later.

In light of that wouldn't it be better just to return an error and
insist that broken applications get fixed?  Unless of course there are
just too many broken apps out there : ) 

--
		Kingsley
