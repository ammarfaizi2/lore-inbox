Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271069AbTGWBCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 21:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271070AbTGWBCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 21:02:55 -0400
Received: from aneto.able.es ([212.97.163.22]:5540 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271069AbTGWBCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 21:02:53 -0400
Date: Wed, 23 Jul 2003 03:17:56 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: Kernel 2.4 CPU Arch issues]
Message-ID: <20030723011756.GA16043@werewolf.able.es>
References: <3F1B25C2.8010403@jmu.edu> <1058745605.6299.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1058745605.6299.4.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Jul 21, 2003 at 02:00:05 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.21, Alan Cox wrote:
> On Llu, 2003-07-21 at 00:29, William M. Quarles wrote:
> > Well, you separated the Pentium and Pentium-MMX.  It's the exact same
> > difference between Pentium Pro and Pentium-II: MMX technology.  That's
> > the point.
> 
> This makes no difference to the kernel. Splitting PPro would only make
> sense for one reason. The Pentium Pro needs store barriers on
> spin_unlock and friends, the PII and later do not. However if this was
> done you'd also want to check for PPro boots with a PII kernel and panic
> which isn't currently done
> 

(sorry for the late answer, I have been out for a course...)

Is this done now ? Where is detected if you try to boot a P3-built kernel on a
PPro ?

AFAIK, P2 is more similar to a P3 than to a PPro in terms of architecture.
Some people say that P3=P2+SSE-50%cache.
As features like fxsr or cmov are detected independent of gcc flags
(/proc/cpuinfo...) I think this can affect on how gcc schedules instructions.
If I grep -r IUMIII * /usr/src/linux, I just get this:

/* Prefetch instructions for Pentium III and AMD Athlon */
#if defined(CONFIG_MPENTIUMIII) || defined (CONFIG_MPENTIUM4)

#define ARCH_HAS_PREFETCH
extern inline void prefetch(const void *x)
{
    __asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
}                                                                               

And in terms of CONFIG_ flags, the differences from 686 to PIII are:

-  bool 'PGE extensions (not for Cyrix/Transmeta)' CONFIG_X86_PGE
+  define_bool CONFIG_X86_PGE y
-  define_bool CONFIG_X86_PPRO_FENCE y

In short:
- P3 is separate from 686 just for the prefetch and for the PPRO_FENCE
- P2 can kill also the PPRO_FENCE

so you I can suppose the main reason to separate P3 is that you trust gcc
to generate better code if it knows its a P3. So same applies to P2, as
gcc explicitely says that i686 is a pentiumpro, but says nothing about
being also a P2:

info gcc:

`-mcpu=CPU-TYPE'
     ...
     While picking a specific CPU-TYPE will schedule things
     appropriately for that particular chip, the compiler will not
     generate any code that does not run on the i386 without the
     `-march=CPU-TYPE' option being used.  `i586' is equivalent to
     `pentium' and `i686' is equivalent to `pentiumpro'.  `k6' and
     `athlon' are the AMD chips as opposed to the Intel ones.

;)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre7-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.6mdk))
