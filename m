Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbTANRlu>; Tue, 14 Jan 2003 12:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbTANRlu>; Tue, 14 Jan 2003 12:41:50 -0500
Received: from mail-2.tiscali.it ([195.130.225.148]:16486 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S264856AbTANRls>;
	Tue, 14 Jan 2003 12:41:48 -0500
Date: Tue, 14 Jan 2003 18:49:11 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: kuznet@ms2.inr.ac.ru
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030114174911.GA796@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20030103051033.1A2AA2C003@lists.samba.org> <200301132232.BAA09527@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301132232.BAA09527@sex.inr.ac.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Tue, Jan 14, 2003 at 01:32:56AM +0300, Alexey N. Kuznetsov ha scritto: 
> Which does not matter at all, because the hole
> 
> void cleanup_module(void)
> {
> <an instance is cloned here>
>         unregister_qdisc(&cbq_qdisc_ops);
> }
> 
> remained in any case, be it under some preemptive, nonprepemtive lock or
> not under a lock at all.

Hmm, this can't happen now. The try_module_get() will fail if the module
is going away and so qdisc_create won't create a new qdisc.

> BTW, Rusty, a question... I do not understand, what is purpose of this
> "new" module stuff at all?

The  idea  is  to  use   try_module_get()  before  using  any  interface
registered by the module. Every module has  a state associated to it: if
the module  has been  loaded but  it is  still in  its init  section its
state  will be  MODULE_STATE_COMING  (and  try_module_get() will  fail);
if  the  module is  in  process  of being  unloaded  its  state will  be
MODULE_STATE_LIVE (and try_module_get() will  fail); otherwise the state
will be MODULE_STATE_LIVE (and try_module_get() will success).

If we use try_module_get() before using the module and module_put() when
we are done everything will work:

int create_foo(foo **new) {
        if (try_module_get(foo->owner) == 0)
                /* Module is being unloaded, it's not safe to use it */
                return -ENOSYS;

        *new = foo->new_foo();
}

void destroy_foo(foo *foo) {
        foo->finalize();

        module_put(foo->owner);
}


This is  what I've  done for the  packet scheduler:  try_module_get() is
called *before*  cloning the qdisc  and if it  fails the qdisc  won't be
cloned. module_put()  is called  in qdisc_destroy(),  after ->destroy(),
when we are sure that nobody will ever use a reference to the qdisc.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Non capisco tutta questa eccitazione per il Multitasking: 
io sono anni che leggo in bagno.
