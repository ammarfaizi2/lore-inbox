Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSIIINN>; Mon, 9 Sep 2002 04:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSIIINN>; Mon, 9 Sep 2002 04:13:13 -0400
Received: from dp.samba.org ([66.70.73.150]:15024 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S314278AbSIIINK>;
	Mon, 9 Sep 2002 04:13:10 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: pavel@suse.cz, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
In-reply-to: Your message of "Sun, 08 Sep 2002 23:13:04 MST."
             <20020908.231304.30400540.davem@redhat.com> 
Date: Mon, 09 Sep 2002 18:17:22 +1000
Message-Id: <20020909081754.EC8382C09D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020908.231304.30400540.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Mon, 09 Sep 2002 13:45:02 +1000
> 
>    	/* FIXME: Initializer required so gcc 2.96 doesn't put in BSS */
>    	DEFINE_PER_CPU(int, xxx) = 0;
>    
>    everywhere, which can be deleted later
> 
> Why everywhere?  If you do it in the macro, then when you want
> to delete the initializer remove the macro arg.  Then you cover
> both in-kernel and cases in external sources because the build
> will break for them so they'll know to fixup their macro invocation.

So, you break everyone's compile later *and* you have to figure out
which initializers were required, and which ones were bogus.
*Planning* to break an interface is just stupid.

> See spinlock_t's declaration for older GCC versions, that is how we
> traditionally deal with compiler bugs like this, explicitly so that it
> is impossible to "miss" something and get it wrong.

Yeah, but you can still leave a spinlock uninitialized, and it'll
work.

I'm not making an interface harder to use because of one of 17
architectures refuses to fix a bug in their toolchain.  Just not
happening, sorry.

I want *you* to feel the pain, not spread it around by leaving turds
throughout the code long after the bug is forgotten:

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.33-cset-1.621/Makefile working-2.5.33-cset-1.621-catch-percpu/Makefile
--- working-2.5.33-cset-1.621/Makefile	2002-09-09 13:31:44.000000000 +1000
+++ working-2.5.33-cset-1.621-catch-percpu/Makefile	2002-09-09 18:06:51.000000000 +1000
@@ -282,6 +282,8 @@ cmd_link_vmlinux = $(LD) $(LDFLAGS) $(LD
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
+#	Final awk script makes sure per-cpu vars are in per-cpu section, as
+#	old gcc (eg egcs 2.92.11) ignores section attribute if uninitialized.
 
 define rule_link_vmlinux
 	set -e
@@ -292,6 +294,7 @@ define rule_link_vmlinux
 	$(call cmd,link_vmlinux)
 	echo 'cmd_$@ := $(cmd_link_vmlinux)' > $(@D)/.$(@F).cmd
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
+	awk '/ __per_cpu_start$/ { IN_PER_CPU=1 } / __per_cpu_end$/ { IN_PER_CPU=0 } /__per_cpu$/ { if (!IN_PER_CPU) { print $3 " not in per-cpu section" > "/dev/stderr"; FOUND=1; } } END { exit FOUND; }' < System.map
 endef
 
 vmlinux: $(vmlinux-objs) FORCE

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
