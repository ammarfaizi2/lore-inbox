Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbSJNCTB>; Sun, 13 Oct 2002 22:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbSJNCTB>; Sun, 13 Oct 2002 22:19:01 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35332 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261800AbSJNCTA>;
	Sun, 13 Oct 2002 22:19:00 -0400
Date: Sun, 13 Oct 2002 19:25:15 -0700
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 [0/4]
Message-ID: <20021014022515.GB1768@kroah.com>
References: <Pine.LNX.4.44.0210131514240.1775-100000@home.transmeta.com> <1924305625.1034535736@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1924305625.1034535736@[10.10.2.3]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 07:02:18PM -0700, Martin J. Bligh wrote:
> 
> PS. This distros want Summit to autodetect for their install kernels,
> which is what the x86_summit switch is for.

Why?  Can't summit boot just fine on a i386 UP kernel?  Then they can
look at the chipset id and determine that they should install a
summit-built kernel, right?

> diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/Config.help subarch-1/arch/i386/Config.help
> --- virgin/arch/i386/Config.help	Fri Oct 11 21:21:31 2002
> +++ subarch-1/arch/i386/Config.help	Sun Oct 13 18:40:30 2002
> @@ -73,6 +73,12 @@ CONFIG_X86_CYCLONE
>    If you are suffering from time skew using a multi-CEC system, say YES.
>    Otherwise it is safe to say NO.
>  
> +CONFIG_X86_SUMMIT

Can this just be CONFIG_SUMMIT?  I think most of these fixes need to be
around for the ia64 version too :(

> /home/fletch/.diff.exclude virgin/arch/i386/Makefile subarch-1/arch/i386/Makefile
> --- virgin/arch/i386/Makefile	Fri Oct 11 21:21:39 2002
> +++ subarch-1/arch/i386/Makefile	Sun Oct 13 17:54:32 2002
> @@ -46,7 +46,11 @@ CFLAGS += $(cflags-y)
>  ifdef CONFIG_VISWS
>  MACHINE	:= mach-visws
>  else
> -MACHINE	:= mach-generic
> + ifdef CONFIG_X86_SUMMIT
> +  MACHINE	:= mach-summit
> + else
> +  MACHINE	:= mach-generic
> + endif
>  endif

As we're going to end up with a mess of a ifdef nest over time with new
archs added, how about something like this (completly untested):


--- 1.12/arch/i386/Makefile	Fri Oct 11 14:22:55 2002
+++ edited/Makefile	Sun Oct 13 19:26:18 2002
@@ -43,10 +43,14 @@
 
 CFLAGS += $(cflags-y)
 
-ifdef CONFIG_VISWS
-MACHINE	:= mach-visws
-else
-MACHINE	:= mach-generic
+MACHINE	= mach-generic
+
+ifeq ($(CONFIG_VISWS),y)
+MACHINE	= mach-visws
+endif
+
+ifeq ($(CONFIG_SUMMIT),y)
+MACHINE	= mach-summit
 endif
 
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o


Can make handle reassigning a variable?

Other than that, looks like a good start to me (oh your email client is
wrapping lines of the patch...)

thanks,

greg k-h
