Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSHBMaU>; Fri, 2 Aug 2002 08:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSHBMaU>; Fri, 2 Aug 2002 08:30:20 -0400
Received: from ns.suse.de ([213.95.15.193]:15621 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S312601AbSHBMaT>;
	Fri, 2 Aug 2002 08:30:19 -0400
Date: Fri, 2 Aug 2002 14:33:49 +0200
From: Dave Jones <davej@suse.de>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, trivial@rustcorp.com.au
Subject: Re: [PATCH] __devexit_p macro
Message-ID: <20020802143348.G25761@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Felipe W Damasio <felipewd@terra.com.br>,
	Linux-kernel <linux-kernel@vger.kernel.org>, trivial@rustcorp.com.au
References: <20020802092456.23a3c49a.felipewd@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020802092456.23a3c49a.felipewd@terra.com.br>; from felipewd@terra.com.br on Fri, Aug 02, 2002 at 09:24:56AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 09:24:56AM +0000, Felipe W Damasio wrote:
 > --- ./include/linux/init.h.orig	Fri Aug  2 09:15:44 2002
 > +++ ./include/linux/init.h	Fri Aug  2 09:06:39 2002
 > @@ -177,12 +177,16 @@
 >  #define __devinitdata
 >  #define __devexit
 >  #define __devexitdata
 > -#define __devexit_p(x)  &(x)
 >  #else
 >  #define __devinit __init
 >  #define __devinitdata __initdata
 >  #define __devexit __exit
 >  #define __devexitdata __exitdata
 > +#endif
 > +
 > +#ifdef MODULE || CONFIG_HOTPLUG
 > +#define __devexit_p(x)  &(x)
 > +#else
 >  #define __devexit_p(x)  0
 >  #endif

Instead of making this a maze of #if/else's, you can acheive
the same effect with the following patch that has been in my
tree for a few months.. (hand pasted, may not apply cleanly)



@@ -167,12 +167,18 @@ typedef void (*__cleanup_module_func_t)(
 #define device_initcall(fn)        module_init(fn)
 #define late_initcall(fn)      module_init(fn)

-#endif
+#endif /* !MODULE */

 /* Data marked not to be saved by software_suspend() */
 #define __nosavedata __attribute__ ((__section__ (".data.nosave")))

-#ifdef CONFIG_HOTPLUG
+/* Functions marked as __devexit may be discarded at kernel link time, depending
+   on config options.  Newer versions of binutils detect references from
+   retained sections to discarded sections and flag an error.  Pointers to
+   __devexit functions must use __devexit_p(function_name), the wrapper will
+   insert either the function_name or NULL, depending on the config options.
+ */
+#if defined(MODULE) || defined(CONFIG_HOTPLUG)
 #define __devinit
 #define __devinitdata
 #define __devexit

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
