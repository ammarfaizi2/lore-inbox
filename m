Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbTBYEwx>; Mon, 24 Feb 2003 23:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTBYEwx>; Mon, 24 Feb 2003 23:52:53 -0500
Received: from dp.samba.org ([66.70.73.150]:30108 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267043AbTBYEww>;
	Mon, 24 Feb 2003 23:52:52 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com, torvalds@transmeta.com
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
In-reply-to: Your message of "Mon, 24 Feb 2003 11:35:03 -0800."
             <5.1.0.14.2.20030224112723.05a5e640@mail1.qualcomm.com> 
Date: Tue, 25 Feb 2003 16:02:18 +1100
Message-Id: <20030225050306.E53BC2C054@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5.1.0.14.2.20030224112723.05a5e640@mail1.qualcomm.com> you write:
> appropriate name for that function. But I can live with __try_module_get() :)
> I'll make new patch for net/socket.c as soon as yours goes in.

Linus, please apply.  This is the "module_dup" which Viro wanted, by
another name.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: __try_module_get
Author: Rusty Russell
Status: Compile tested on 2.5.63

D: Introduces __try_module_get for places where we know we already hold
D: a reference and ignoring the fact that the module is being "rmmod --wait"ed
D: is simpler.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22009-linux-2.5.63/include/linux/module.h .22009-linux-2.5.63.updated/include/linux/module.h
--- .22009-linux-2.5.63/include/linux/module.h	2003-02-25 10:11:08.000000000 +1100
+++ .22009-linux-2.5.63.updated/include/linux/module.h	2003-02-25 16:00:53.000000000 +1100
@@ -292,6 +292,16 @@ void symbol_put_addr(void *addr);
 #define local_dec(x) atomic_dec(x)
 #endif
 
+/* Sometimes we know we already have a refcount, and it's easier not
+   to handle the error case (which only happens with rmmod --wait). */
+static inline void __try_module_get(struct module *module)
+{
+	if (module) {
+		local_inc(&module->ref[get_cpu()].count);
+		put_cpu();
+	}
+}
+
 static inline int try_module_get(struct module *module)
 {
 	int ret = 1;
@@ -327,6 +337,9 @@ static inline int try_module_get(struct 
 static inline void module_put(struct module *module)
 {
 }
+static inline void __try_module_get(struct module *module)
+{
+}
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(p) do { } while(0)
 
@@ -381,6 +394,10 @@ static inline int module_text_address(un
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(x) do { } while(0)
 
+static inline void __try_module_get(struct module *module)
+{
+}
+
 static inline int try_module_get(struct module *module)
 {
 	return 1;
