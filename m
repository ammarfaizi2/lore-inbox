Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317327AbSGDD6A>; Wed, 3 Jul 2002 23:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317328AbSGDD6A>; Wed, 3 Jul 2002 23:58:00 -0400
Received: from rj.sgi.com ([192.82.208.96]:64958 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317327AbSGDD56>;
	Wed, 3 Jul 2002 23:57:58 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal 
In-reply-to: Your message of "Wed, 03 Jul 2002 18:53:55 MST."
             <3D23AAB3.1AF2F897@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jul 2002 14:00:21 +1000
Message-ID: <12188.1025755221@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jul 2002 18:53:55 -0700, 
Andrew Morton <akpm@zip.com.au> wrote:
>Keith Owens wrote:
>> Rusty and I agree that if (and it's a big if) we want to support module
>> unloading safely then this is the only sane way to do it.
>
>Dumb question: what's wrong with the current code as-is?  I don't think
>I've ever seen a module removal bug report which wasn't attributable to
>some straightforward driver-failed-to-clean-something-up bug.
>
>What problem are you trying to solve here?

Uncounted references to module code and/or data.

  To be race safe, the reference count must be bumped before calling
  any function that might be in a module.  With the current unload
  method, MOD_INC_USE_COUNT inside the module is too late.

  Al Viro closed some of these races by adding the owner field and
  using try_inc_mod_count.  That assumes that every bit of code that
  dereferences a function pointer will handle the module locking.

Code to externally bump the use count must itself be race safe.

  drivers/char/busmouse.c::busmouse_open() has
    if (mse->ops->owner && !try_inc_mod_count(mse->ops->owner))
  This is safe because it first does
    down(&mouse_sem)
  which locks mse and its operations.  At least I assume it is safe, I
  hope that mse operations cannot be deregistered without mouse_sem.

  Although this appears to be safe, it is not obvious that it is safe,
  you have to trace the interaction between mouse_sem, the module
  unload_lock, the MOD_DELETED flag for the module and the individual
  module clean up routines to be sure that there are no races.

  OTOH, HiSax_mod_inc_use_count appears to be unsafe.  It has no
  locking of its own before calling try_inc_mod_count().  AFAICT this
  race exists :-

    HiSax_command() -> HiSax_mod_inc_use_count()
        mod = cs->hw.hisax_d_if->owner;
	// race here
	if (mod)
	  try_inc_mod_count(mod);

  Without any (obvious) locking to prevent hisax unregistration on
  another cpu, mod can be deleted in the middle of that code.  To add
  insult to injury, HiSax_mod_inc_use_count does not check if it locked
  the module or not, it blindly assumes it worked and continues to use
  the module structures!

  I cannot be sure if get_mtd_device() (calls try_inc_mod_count) is
  safe or not.  There is no locking around calls to get_mtd_device()
  which makes it look unsafe.  OTOH it is invoked from mtdblock_open()
  via mtd_fops.open, which may mean that a higher routine is locking
  the module down.  But it is not obvious that the code is safe.

  If get_mtd_device() is being protected by a higher routine such as
  get_fops() then the module use count is already non-zero and
  try_inc_mod_count will always succeed.  In that case,
  try_inc_mod_count is overkill, an unconditional __MOD_INC_USE_COUNT
  will do the job just as well.  In either case, there is a question
  mark over this code.

  Similar comments for net/core/dev.c::dev_open().  No obvious locks to
  protect the parameters passed to try_inc_mod_count, they may or may
  not be protected by a lock in a higher routine.  try_inc_mod_count
  may or may not be overkill here.

The main objections to the existing reference counting model are :-

* Complex and fragile.  The interactions between try_inc_mod_count,
  some other lock that protects the parameters to try_inc_mod_count and
  the module clean up routines are not obvious.  Every module writer
  has to get the interaction exactly right.

* Difficult to audit.  Is get_mtd_device() safe or not?  If it is safe,
  why is it safe and is try_inc_mod_count overkill?

* Easy to omit.  The comments above only apply to the code that is
  using try_inc_mod_count.  How much code exists that should be doing
  module locking but is not?

* All the external locking is scattered around the kernel, anywhere
  that might call a function in a module.

* The external locking is extra cpu overhead (and storage, but to a
  lesser extent) all the time.  Just to cope with a relatively rare
  unload event.

Given those objections, Rusty is looking at alternative methods,
ranging from no unload at all to an unload method that moves all the
complexity into module.c instead of spreading it around the kernel.

