Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWCHLYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWCHLYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWCHLYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:24:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5128 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932476AbWCHLY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:24:29 -0500
Date: Wed, 8 Mar 2006 12:24:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, zippel@linux-m68k.org,
       torvalds@osdl.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] m68k: fix cmpxchg compile errors if CONFIG_RMW_INSNS=n
Message-ID: <20060308112427.GD4006@stusta.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060303230149.GB9295@stusta.de> <Pine.LNX.4.64.0603031515321.22647@g5.osdl.org> <20060303155913.2e299736.akpm@osdl.org> <Pine.LNX.4.64.0603041457070.16802@scrub.home> <4409A05F.2090704@yahoo.com.au> <20060304122848.188430e8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304122848.188430e8.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 12:28:48PM -0800, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > Roman Zippel wrote:
> > > Hi,
> > > 
> > > On Fri, 3 Mar 2006, Andrew Morton wrote:
> > > 
> > > 
> > >>Yes, we now require cmpxchg of all architectures.
> > > 
> > > 
> > > Actually I'd prefer if we used atomic_cmpxchg() instead.
> > > The cmpxchg() emulation was never added for a good reason - to keep code 
> > > from assuming it can be used it for userspace synchronisation. Using an 
> > > atomic_t here would probably get at least some attention.
> > > 
> > 
> > Yes, I guess that's what Andrew meant. The reason we can require
> > atomic_cmpxchg of all architectures is because it is only guaranteed
> > to work on atomic_t.
> > 
> > Glad to hear it won't be a problem for you though.
> > 
> 
> Could someone with an m68k compiler please send the patch?

It's below.

cu
Adrian


<--  snip  -->


This patch provides a cmpxchg() if CONFIG_RMW_INSNS=n (code stolen from 
m68knommu).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-m68k/system.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- linux-2.6.16-rc5-mm3-m68k/include/asm-m68k/system.h.old	2006-03-08 12:10:48.000000000 +0100
+++ linux-2.6.16-rc5-mm3-m68k/include/asm-m68k/system.h	2006-03-08 12:17:47.000000000 +0100
@@ -192,6 +192,21 @@
 #define cmpxchg(ptr,o,n)\
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
+
+#else
+
+static inline unsigned long cmpxchg(volatile int *p, int old, int new)
+{
+	unsigned long flags;
+	int prev;
+
+	local_irq_save(flags);
+	if ((prev = *p) == old)
+		*p = new;
+	local_irq_restore(flags);
+	return(prev);
+}
+
 #endif
 
 #define arch_align_stack(x) (x)

