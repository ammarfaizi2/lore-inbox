Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319404AbSILBjX>; Wed, 11 Sep 2002 21:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319405AbSILBip>; Wed, 11 Sep 2002 21:38:45 -0400
Received: from dp.samba.org ([66.70.73.150]:39648 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319404AbSILBim>;
	Wed, 11 Sep 2002 21:38:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Cc: Oliver Neukum <oliver@neukum.name>, Roman Zippel <zippel@linux-m68k.org>,
       Alexander Viro <viro@math.psu.edu>, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface 
In-reply-to: Your message of "Wed, 11 Sep 2002 23:47:45 +0200."
             <E17pFKr-0007V7-00@starship> 
Date: Thu, 12 Sep 2002 11:42:45 +1000
Message-Id: <20020912014331.961472C12A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17pFKr-0007V7-00@starship> you write:
> On Wednesday 11 September 2002 23:26, Jamie Lokier wrote:
> > Daniel Phillips wrote:
> > > Really, that's not so, there are limits.  30 seconds?  Whatever.  
> > > Remember, during this time the service provided by the module is
> > > unavailable, so this is denial-of-service land.  You could of
> > > course put in extra code to abort the unload process on demand,
> > > but, hmm, it probably wouldn't work ;-)
> > 
> > If you're going to do it right, you should fix that denial-of-service by
> > waiting until the module has finished unloading and then demand-loading
> > the module again.
> 
> That doesn't make the DoS go away, it just makes it a little
> harder to trigger.  Anyway, one thing we could do if the rest
> of the module mechanism is up to it, is know that somebody is
> trying to reactivate a module that has just returned from
> module_cleanup(), and immediately reactivate it instead of
> freeing it, hoping to save some disk activity - if this turns
> out to be a real problem, that is.  The null solution is likely
> the winner here.

Ah, yes, four-point module interface: init, start, stop, destroy.
Then you can call stop, realize the module is not at zero refcnt (you
lost a race), then call start again.  Similar thing if someone
requests a stopped module.

Now you're going to have to change request_module() so the kernel can
realize that you're requesting a module which already exists
(request_module()'s effect currently depends on /etc/modules.conf of
course).

Now, of course, your module interface is starting to look really
complex, too.  Because you want to solve the "half-loaded" problem, so
you really want "init" to reserve resources, and "start" to register
them (ie. start can't fail).  So every register_xxx interface needs to
be split into reserve_xxx and use_xxx.

We can do all this, of course.  I have an awful lot of patches.  But
I'm not really happy with any of them.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
