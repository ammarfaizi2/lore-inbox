Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262814AbSJRCug>; Thu, 17 Oct 2002 22:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbSJRCug>; Thu, 17 Oct 2002 22:50:36 -0400
Received: from dp.samba.org ([66.70.73.150]:42118 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262814AbSJRCuc>;
	Thu, 17 Oct 2002 22:50:32 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Daniel Phillips <phillips@arcor.de>, S@samba.org,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: your mail 
In-reply-to: Your message of "Thu, 17 Oct 2002 09:56:08 EST."
             <Pine.LNX.4.44.0210170930410.6301-100000@chaos.physics.uiowa.edu> 
Date: Fri, 18 Oct 2002 12:47:56 +1000
Message-Id: <20021018025633.1D4C72C0BF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0210170930410.6301-100000@chaos.physics.uiowa.edu> yo
u write:
> Since I made the mistake of getting involved into this discussion lately,

My condolences. 8)

> I wonder if this new method is going to be mandatory (the only one
> available) or optional. I think there's two different kind of users, for
> one modules which use an API which provides its own infrastructure for
> dealing with modules via ->owner, on the other hand things like netfilter
> (that's probably where you are coming from) where calls into a module,
> which need protection are really frequent.

Mandatory for interfaces where the function can sleep (or be preempted).

> Note that for the vast majority of modules, dealing with unload races is 
> as simple as setting ->owner, for example filesystems, network drivers.

Yes.  We do not have complete coverage though, this policy would
extend it.

> I see that your approach makes frequent calls into the module cheaper, but
> I'm not totally convinced that the current safe interfaces need to change
> just to accomodate rare cases like netfilter (there's most likely some
> more cases like it, but the majority of modules is not).

They're not changing.  The current users doing try_inc_mod_count() are
fine.  It's the ones not doing it which are problematic.

> Anyway, I may see further problems, but let me check first: Is your count
> supposed to only count users which are currently executing in the module's
> .text, or is it also to count references to data allocated in the module?
> (I.e. when I register_netdev(), does that keep a reference to the module
> even after the code has left the module's .text?)

It's to protect entry to the function, but of course, some interfaces
(eg. filesystems) lend themselves very neatly to batching this at
mount/unmount time.  Data is already protected by the usual means.

At risk of boring you, here's the document from the documentation
patch.  Suggestions welcome.

+Writing Modules and the Interfaces To Be Used By Them: A Gentle Guide.
+Copyright 2002, Rusty Russell IBM Corportation
+
+Modules are running parts of the kernel which can be added, and
+sometimes removed, while the kernel is operational.
+
+There are several delicate issues involved in this procedure which
+indicate special care should be taken.
+
+There are three cases you need to be careful:
+
+1) Any code which creates an interface for callbacks (ie. almost any
+   function called register_*)
+	=> See Rule #1
+
+2) Any modules which use (old) interfaces which do not obey Rule #1
+	=> See Rule #2
+
+Rule #1: Module-safe Interfaces.  Any interface which allows
+	registration of callbacks, must also allow registration of a
+	"struct module *owner", either in the structure or as a
+	function parameter, and it must use them to protect the
+	callbacks.  See "MAKING INTERFACES SAFE".
+
+Exception #1: As an optimization, you may skip this protection if you
+	   *know* that the callbacks are non-preemtible and never
+	   sleep (eg. registration of interrupt handlers).
+
+
+Rule #2: Modules using unsafe interfaces.  If your module is using any
+	interface which does not obey rule number 1, that means your
+	module functions may be called from the rest of the kernel
+	without the caller first doing a successful try_module_get().
+
+	You must not register a "module_cleanup" handler, and your module
+	cannot be unloaded except by force.  You must be especially
+	careful in this case with initialization: see "INITIALIZING
+	MODULES WHICH USE UNSAFE INTERFACES".
+
+MAKING INTERFACES SAFE
+
+A caller must always call "try_module_get()" on a function pointers's
+owner before calling through that function pointer.  If
+"try_module_get()" returns 0 (false), the function pointer must *not*
+be called, and the caller should pretend that registration does not
+exist: this means the (module) owner is closing down and doesn't want
+any more calls, or in the process of starting up and isn't ready yet.
+
+For many interfaces, this can be optimized by assuming that a
+structure containing function pointers has the same owner, and knowing
+that one function is always called before the others, such as the
+filesystem code which knows a mount must succeed before any other
+methods can be accessed.
+
+You must call "module_put()" on the owner sometime after you have
+called the function(s).
+
+If you cannot make your interface module-safe in this way, you can at
+least split registration into a "reserve" stage and an "activate"
+stage, so that modules can use the interface, even if they cannot
+(easily) unload.
+
+
+INITIALIZING MODULES WHICH USE UNSAFE INTERFACES
+
+Safe interfaces will never enter your module before module_init() has
+successfully finished, but unsafe interfaces may.  The rule is simple:
+your init_module() function *must* succeed (by returning 0) if it has
+successfully used any unsafe interfaces.
+
+So, if you are only using ONE unsafe interface, simply use that
+interface last.  Otherwise you will have to use printk() to report
+failure and leave the module initialized (but possibly useless).
+
+
+
+If you have questions about how to apply this document to your own
+modules, please ask rusty@rustcorp.com.au or linux-kernel@vger.kernel.org.
+
+Thankyou,
+Rusty.

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
