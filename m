Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbTAOAp0>; Tue, 14 Jan 2003 19:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbTAOAp0>; Tue, 14 Jan 2003 19:45:26 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:63754 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265532AbTAOApZ>; Tue, 14 Jan 2003 19:45:25 -0500
Message-ID: <3E24A981.1EA03E8B@linux-m68k.org>
Date: Wed, 15 Jan 2003 01:21:21 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kronos@kronoz.cjb.net
CC: kuznet@ms2.inr.ac.ru, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
References: <20030103051033.1A2AA2C003@lists.samba.org> <200301132232.BAA09527@sex.inr.ac.ru> <20030114174911.GA796@dreamland.darkstar.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kronos wrote:

> The  idea  is  to  use   try_module_get()  before  using  any  interface
> registered by the module. Every module has  a state associated to it: if
> the module  has been  loaded but  it is  still in  its init  section its
> state  will be  MODULE_STATE_COMING  (and  try_module_get() will  fail);
> if  the  module is  in  process  of being  unloaded  its  state will  be
> MODULE_STATE_LIVE (and try_module_get() will  fail); otherwise the state
> will be MODULE_STATE_LIVE (and try_module_get() will success).

Rusty had to revert this to the old scheme, as e.g. scsi relied on it.
This means the kernel will oops, if someone gets a reference to a module
and its init function fails.
Above scheme is not without problems either, a failing try_module_get()
suddenly gets a double meaning. Now it also means that the module might
be ready soon, please try again later, what increases the complexity of
the whole module business. 
BTW what makes it currently even more complex is that there is also no
synchronization by the module-init-tools done anymore, a
try_module_get()/request_module()/try_module_get() sequence does give no
definitive answer anymore, whether a module is available or not. The
results will be spurious kmod failures.

> If we use try_module_get() before using the module and module_put() when
> we are done everything will work:
> 
> int create_foo(foo **new) {
>         if (try_module_get(foo->owner) == 0)
>                 /* Module is being unloaded, it's not safe to use it */
>                 return -ENOSYS;
> 
>         *new = foo->new_foo();
> }

It's not that simple, try_module_get() does not everything. It's the
responsibility of the caller to protect the owner pointer, so
try_module_get() itself is only usable within some locking. This means
your patch is still not safe, as the test is done too late.

bye, Roman

