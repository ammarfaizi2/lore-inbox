Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319083AbSIJJJ4>; Tue, 10 Sep 2002 05:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319084AbSIJJJ4>; Tue, 10 Sep 2002 05:09:56 -0400
Received: from dsl-213-023-021-153.arcor-ip.net ([213.23.21.153]:21705 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319083AbSIJJJz>;
	Tue, 10 Sep 2002 05:09:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: Question about pseudo filesystems
Date: Tue, 10 Sep 2002 11:15:54 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
References: <20020907192736.A22492@kushida.apsleyroad.org> <E17oUnq-0006tg-00@starship> <20020910014459.B5875@kushida.apsleyroad.org>
In-Reply-To: <20020910014459.B5875@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oh7j-00079w-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 02:44, Jamie Lokier wrote:
> Typically, your module's resources are protected by a lock or so.
> cleanup_module() could take this lock, check any private reference
> counts, and (because it has the lock) decide whether to proceed with
> unregistering the module's resources.

Actually, there did turn out to be a problem with the code I showed
yesterday, resulting from the fact that cleanup_module wants to be able to 
sleep.  Because of this, there is no good way for module.c to protect 
module->count from try_inc_mod_count, not without changing the spinlock in 
try_inc_mod_count into a semaphore, which isn't nice either, because 
try_inc_mod_count is taken under at least one other spinlock in super.c.

There's a simple solution though: examine the module->count under the same 
spinlock as try_inc_mod_count, which is what sys_delete_module does.  We just 
encapsulate that check in a handy wrapper and define it as part of the 
try_inc_mod_count interface.  At this point the thing is generalized to the 
point where the module count isn't used at all by module.c, so the same 
interface will also accomodate the still-under-construction magic wait for 
quiescent state(), needed for modules that don't fit the mod_count model.

The nice thing is, hardly any work is required to accomplish this, though 
it's hard to look at module.c for more than a few seconds without seeing more 
things that want cleaning up.

-- 
Daniel
