Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319433AbSILEsQ>; Thu, 12 Sep 2002 00:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319434AbSILEsQ>; Thu, 12 Sep 2002 00:48:16 -0400
Received: from dp.samba.org ([66.70.73.150]:57235 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319433AbSILEsP>;
	Thu, 12 Sep 2002 00:48:15 -0400
Date: Thu, 12 Sep 2002 14:52:44 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Cc: lk@tantalophile.demon.co.uk, oliver@neukum.name, zippel@linux-m68k.org,
       viro@math.psu.edu, kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface
Message-Id: <20020912145244.4cc6fb98.rusty@rustcorp.com.au>
In-Reply-To: <E17pKxR-0007by-00@starship>
References: <20020912031345.760A32C061@lists.samba.org>
	<E17pKxR-0007by-00@starship>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002 05:47:57 +0200
Daniel Phillips <phillips@arcor.de> wrote:

> On Thursday 12 September 2002 05:13, Rusty Russell wrote:
> > B) We do not handle the "half init problem" where a module fails to load, eg.
> > 	a = register_xxx();
> > 	b = register_yyy();
> > 	if (!b) {
> > 		unregister_xxx(a);
> > 		return -EBARF;
> > 	}
> >   Someone can start using "a", and we are in trouble when we remove
> >   the failed module.
> 
> No we are not.  The module remains in the 'stopped' state
> throughout the entire initialization process, as it should and
> does, in my model.

Um, so register_xxx interfaces all use try_inc_mod_count (ie. a
struct module *  extra arg to register_xxx)?  Or those entry points
are not protected by try_inc_mod_count, so it must bump the refcnt, so
you need to sleep in load until the module becomes unused again.

You have the same issue in the "wait for schedule" case on unload,
where someone jumps in while you are unregistering.  My implementation
decided to ignore this problem (ie. potentially wait forever with the
module half-loaded) but it is an issue.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
