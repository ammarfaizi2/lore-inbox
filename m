Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269006AbTBXCs6>; Sun, 23 Feb 2003 21:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269094AbTBXCs6>; Sun, 23 Feb 2003 21:48:58 -0500
Received: from dp.samba.org ([66.70.73.150]:48842 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269006AbTBXCsz>;
	Sun, 23 Feb 2003 21:48:55 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
In-reply-to: Your message of "Thu, 20 Feb 2003 17:17:52 -0800."
             <5.1.0.14.2.20030220165016.0d47c688@mail1.qualcomm.com> 
Date: Mon, 24 Feb 2003 12:01:01 +1100
Message-Id: <20030224025907.A238F2C091@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5.1.0.14.2.20030220165016.0d47c688@mail1.qualcomm.com> you write:
> At 04:30 PM 2/20/2003, Rusty Russell wrote:
> >Yes, but in practical terms it's probably going to fork a child with
> >that socket.
> But it will also be killed.

Once they track it down 8).

> >> >I think it can be argued both ways, honestly.
> >> Yep. And I'd argue in for of module_get() :)
> >
> >My only real insistence in this is that such an interface be called
> >__try_module_get(), because the "__" warn people that it's a "you'd
> >better know *exactly* what you are doing", even though the "try" is a
> >bit of a misnomer.
> Yeah, I think 'try' is definitely be a misnomer in this case.
> How about something like this ?

No, I definitely want the name __try_module_get.  Sure, it's a
misnomer in one sense, which will hopefully scare off people looking
for an easy way out.  OTOH, it accurately reflects "you should be
using try_module_get but you have special circumstances" more
eloquently than any comment ever would.  Especially since there are
only a handful of places where it is appropriate.

I think a CONFIG option for checking is overkill: better is to grep
each kernel for __try_module_get() being added and make sure the damn
thing doesn't spread 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: __try_module_get
Author: Rusty Russell
Status: Trivial
Depends: 

D: Introduces __try_module_get for places where we know we already hold
D: a reference and ignoring the fact that the module is being "rmmod --wait"ed
D: is simpler.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12219-linux-2.5.62-bk3/include/linux/module.h .12219-linux-2.5.62-bk3.updated/include/linux/module.h
--- .12219-linux-2.5.62-bk3/include/linux/module.h	2003-02-21 10:32:28.000000000 +1100
+++ .12219-linux-2.5.62-bk3.updated/include/linux/module.h	2003-02-24 11:46:13.000000000 +1100
@@ -292,17 +292,23 @@ void symbol_put_addr(void *addr);
 #define local_dec(x) atomic_dec(x)
 #endif
 
+/* Sometimes we know we already have a refcount, and it's easier not
+   to handle the error case (which only happens with rmmod --wait). */
+static inline void __try_module_get(struct module *module)
+{
+	local_inc(&module->ref[get_cpu()].count);
+	put_cpu();
+}
+
 static inline int try_module_get(struct module *module)
 {
 	int ret = 1;
 
 	if (module) {
-		unsigned int cpu = get_cpu();
 		if (likely(module_is_live(module)))
-			local_inc(&module->ref[cpu].count);
+			__try_module_get(module);
 		else
 			ret = 0;
-		put_cpu();
 	}
 	return ret;
 }
@@ -327,6 +332,9 @@ static inline int try_module_get(struct 
 static inline void module_put(struct module *module)
 {
 }
+static inline void __try_module_get(struct module *module)
+{
+}
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(p) do { } while(0)
 
@@ -381,6 +389,10 @@ static inline int module_text_address(un
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(x) do { } while(0)
 
+static inline void __try_module_get(struct module *module)
+{
+}
+
 static inline int try_module_get(struct module *module)
 {
 	return 1;
