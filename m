Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319423AbSILD0Q>; Wed, 11 Sep 2002 23:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319424AbSILD0Q>; Wed, 11 Sep 2002 23:26:16 -0400
Received: from dsl-213-023-021-043.arcor-ip.net ([213.23.21.43]:36995 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319423AbSILD0Q>;
	Wed, 11 Sep 2002 23:26:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] Raceless module interface
Date: Thu, 12 Sep 2002 05:32:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Neukum <oliver@neukum.name>, Roman Zippel <zippel@linux-m68k.org>,
       Alexander Viro <viro@math.psu.edu>, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
References: <E17pFKr-0007V7-00@starship> <20020912014331.961472C12A@lists.samba.org> <20020912030933.A13608@kushida.apsleyroad.org>
In-Reply-To: <20020912030933.A13608@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pKiX-0007bp-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2002 04:09, Jamie Lokier wrote:
>    1. Just before a module's cleanup_module() function is called, mark
>       the module as "unloading".  This should force
>       try_inc_mod_use_count() to fail, causing its caller to behave like
>       the associated resource (e.g. filesystem) isn't actually
>       registered, and to call request_module().

My proposal produces the same effect using a slightly different
arrangement: module_cleanup() is called, and the first thing it
does is bail out with an error if there are users, or puts the
module into the inactive state (count=-1).  This forces
try_inc_mod_use_count to fail, as you say.

>    2. request_module() should simply ignore modules marked as
>       "unloading".  It should proceed to call "insmod" etc.
> 
>    3. sys_create_module() or sys_init_module() should block if there is
>       a module of the same name currently in the "unloading" state.
>       They should block until that module's cleanup_module() returns.

OK, this is a really good example of why replacing the lock_kernel
with a dedicated module_sem is good: if we do that, the right thing
happens.  Insmod will block on the module_sem until the module is
completely unloaded and removed from the list.  By the time it gets
the semaphore, everything will be in a pristine state.

The BKL on the other hand will happily relinquish control if the
cleanup sleeps, messing things up nicely.

>    4. At this point, the new instance of the module will initialise,
>       request_module() calls will return and the callers which called
>       try_inc_mod_use_count() in step 1 will continue with the resource
>       they needed.

Yes, I don't see a problem.  The problems start when you try to
shortcut this cycle.  Given that a shortcut is hardly going to save
much at all, due to caching, I'd call it a waste of effort.

-- 
Daniel
