Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbWBHQMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWBHQMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbWBHQMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:12:14 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:30844
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1161089AbWBHQMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:12:14 -0500
Message-Id: <43EA268A.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 08 Feb 2006 17:12:42 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <davej@redhat.com>, "Andreas Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_UNWIND_INFO
References: <43E0719F020000780000FAF6@emea1-mh.id2.novell.com> <20060201005324.2c19d78c.akpm@osdl.org>
In-Reply-To: <20060201005324.2c19d78c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartB391176A.3__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartB391176A.3__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached an updated patch, disallowing the option for all architectures that have been determined to potentially have
problems with the resulting relocations. Jan

>>> Andrew Morton <akpm@osdl.org> 01.02.06 09:53:24 >>>
"Jan Beulich" <jbeulich@novell.com> wrote:
>
> >>> Andrew Morton <akpm@osdl.org> 02/01/06 9:14 AM >>>
> >Andi Kleen <ak@suse.de> wrote:
> >>
> >> On Wednesday 01 February 2006 08:51, Andrew Morton wrote:
> >> > Andi Kleen <ak@suse.de> wrote:
> >> > >
> >> > > On Wednesday 01 February 2006 05:19, you wrote:
> >> > > > Hey Andi,
> >> > > >  What's the deal with this option ? It doesn't seem to be
> >> > > > referenced from any Kconfig, but it shows up in a bunch of places.
> >> > > > 
> >> > > > Your commit had the message..
> >> > > > 
> >> > > > 	As a follow-up to the introduction of CONFIG_UNWIND_INFO, this
> >> > > > 	separates the generation of frame unwind information for x86-64 from
> >> > > > 	that of full debug information.
> >> > > > 
> >> > > > But it appears that the 'introduction' didn't happen :-)
> >> > > 
> >> > > It was stuck in -mm* due to it being enabled in all cases broke
> >> > > ppc64. I guess it'll go in for 2.6.17, but Andrew and Jan should
> >> > > know details.
> >> > 
> >> > Didn't we decide that it was causing the stack to wrap around the 4G
> >> > boundary on powerpc compat tasks?  Something like that.
> >> 
> >> Wasn't that the large stack randomization patch?
> >
> >Oh, yeah, confused.
> >
> >CONFIG_UNWIND_INFO screwed up the module loader.  I think they fixed that -
> >I saw a patch floating about.
> 
> So, any chance to get this in, maybe even for 2.6.16?
> 

Dunno.  You tell me - does it break any other architectures?  I don't know.

If you can identify the problematic code in powerpc and then see if any
other architectures do anything similar then that would give some
confidence.

--=__PartB391176A.3__=
Content-Type: text/plain; name="linux-2.6.16-rc2-unwind-info.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.16-rc2-unwind-info.patch"

From: Jan Beulich <jbeulich@novell.com>

As a foundation for reliable stack unwinding, this adds a config option
(available to all architectures except IA64 and those where the module loader
might have problems with the resulting relocations) to enable the generation
of frame unwind information.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc2/Makefile 2.6.16-rc2-unwind-info/Makefile
--- /home/jbeulich/tmp/linux-2.6.16-rc2/Makefile	2006-02-06 11:01:33.000000000 +0100
+++ 2.6.16-rc2-unwind-info/Makefile	2006-02-06 11:12:17.000000000 +0100
@@ -518,6 +518,10 @@ else
 CFLAGS		+= -fomit-frame-pointer
 endif
 
+ifdef CONFIG_UNWIND_INFO
+CFLAGS		+= -fasynchronous-unwind-tables
+endif
+
 ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc2/lib/Kconfig.debug 2.6.16-rc2-unwind-info/lib/Kconfig.debug
--- /home/jbeulich/tmp/linux-2.6.16-rc2/lib/Kconfig.debug	2006-02-06 11:02:54.000000000 +0100
+++ 2.6.16-rc2-unwind-info/lib/Kconfig.debug	2006-02-08 14:14:23.000000000 +0100
@@ -195,6 +195,17 @@ config FRAME_POINTER
 	  some architectures or if you use external debuggers.
 	  If you don't debug the kernel, you can say N.
 
+config UNWIND_INFO
+	bool "Compile the kernel with frame unwind information"
+	depends on !IA64
+	depends on !MODULES || !(MIPS || PARISC || PPC || SUPERH || SPARC64 || V850)
+	default DEBUG_KERNEL
+	help
+	  If you say Y here the resulting kernel image will be slightly larger
+	  but not slower, and it will give very useful debugging information.
+	  If you don't debug the kernel, you can say N, but we may not be able
+	  to solve problems without frame unwind information or frame pointers.
+
 config FORCED_INLINING
 	bool "Force gcc to inline functions marked 'inline'"
 	depends on DEBUG_KERNEL

--=__PartB391176A.3__=--
