Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317279AbSGIAZT>; Mon, 8 Jul 2002 20:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSGIAZS>; Mon, 8 Jul 2002 20:25:18 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:24594 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317279AbSGIAZQ>;
	Mon, 8 Jul 2002 20:25:16 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal 
In-reply-to: Your message of "Mon, 08 Jul 2002 21:07:13 -0300."
             <20020708210713.R2295@almesberger.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jul 2002 10:27:46 +1000
Message-ID: <22226.1026174466@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002 21:07:13 -0300, 
Werner Almesberger <wa@almesberger.net> wrote:
>What troubles me most in this discussion is that nobody seems to
>think of how these issues affect non-modules.
>
>Entry-after-removal is an anomaly in the subsystem making that call.
>Fixing it for modules is fine as long as only modules will ever
>un-register, but what do you do if non-module code ever wants to
>un-register too ? (E.g. think hot-plugging or software devices.)

The only difference between module and non-module is whether the code
and data areas are freed or left in the kernel for the next user.  All
other processing should be the same for hotplug.  This is why
CONFIG_HOTPLUG retains the __exit code in the kernel instead of
discarding it at link time.

>Besides, a common pattern for those "hold this down, kick that, then
>slowly count to ten, and now it's safe to release" solutions seems
>to be that it takes roughly ten times as long to find the race
>condition buried deep within them, than it took for the respective
>predecessor.

I don't like 'wait for n seconds then release' methods, as you say they
just hide the problem.  Neither Rusty nor I are suggesting that
approach.  Rusty's idea is

  Check use count.
  Unregister.
  Ensure that all code that had a reference to the module has either
  dropped that reference or bumped the use count.
  Check use count again, it may have been bumped above.
  If use count is still 0, there are no stale references left.  It is
  now safe to unload, call the module unallocate routine then free its
  area.
  If use count != 0, either schedule for removal when the count goes to
  0 or reregister.  I prefer reregister, Rusty prefers delayed removal.

Ensuring that all code has either dropped stale references or bumped
the use count means that all processes that were not sleeping when
rmmod was started must proceed to a sync point.  It is (and always has
been) illegal to sleep while using module code/data (note: using, not
referencing).

