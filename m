Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWAJCgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWAJCgm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 21:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWAJCgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 21:36:42 -0500
Received: from mx1.suse.de ([195.135.220.2]:47591 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750737AbWAJCgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 21:36:42 -0500
From: Andi Kleen <ak@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Athlon 64 X2 cpuinfo oddities
Date: Tue, 10 Jan 2006 03:36:31 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com> <p73r77gx36u.fsf@verdi.suse.de> <9a8748490601091812x24aefae3oc0c6750c5321c3ab@mail.gmail.com>
In-Reply-To: <9a8748490601091812x24aefae3oc0c6750c5321c3ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100336.31677.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 03:12, Jesper Juhl wrote:
> On 10 Jan 2006 02:49:13 +0100, Andi Kleen <ak@suse.de> wrote:
> > Jesper Juhl <jesper.juhl@gmail.com> writes:
> > >
> > > Well, first of all you'll notice that the second core shows a
> > > "physical id" of 127 while the first core shows an id of 0.  Shouldn't
> > > the second core be id 1, just like the "core id" fields are 0 & 1?
> >
> > In theory it could be an uninitialized phys_proc_id (0xff >> 1),
> > but it could be also the BIOS just setting the local APIC of CPU 1
> > to 0xff for some reason.
> >
> > If you add a printk("PHYSCPU %d %x\n", smp_processor_id(), phys_proc_id[smp_processor_id()])
> > at the end of arch/x86_64/kernel/setup.c:early_identify_cpu() what does
> > dmesg | grep PHYSCPU output?
> >
> Not a thing since I'm using arch/i386 here (32bit distribution
> (Slackware), just building a 32bit kernel optimized for K8).

Ah - how legacy.

> But, I stuck that printk into identify_cpu() in
> arch/i386/kernel/cpu/common.c instead, and this is what I get :
> $ dmesg | grep PHYSCPU
> [   30.323965] PHYSCPU 0 0
> [   30.402588] PHYSCPU 1 7f

Hmm it looks like the phys_proc_id initialization is at the wrong
place in 32bit. early_cpu_detect is only called on the BP, not
on the AP. early_intel_workaround is also there incorrectly.
Might be a mismerge - it should be one function below.

The appended patch should help, but it's untested.
 
> 
> > >
> > > Second thing I find slightly odd is the lack of "sse3" in the "flags" list.
> > > I was under the impression that all AMD Athlon 64 X2 CPU's featured SSE3?
> > > Is it a case of:
> > >  a) Me being wrong, not all Athlon 64 X2's feature SSE3?
> > >  b) The CPU actually featuring SSE3 but Linux not taking advantage of it?
> > >  c) The CPU features SSE3 and it's being utilized, but /proc/cpuinfo
> > > doesn't show that fact?
> > >  d) Something else?
> >
> > It's called pni (prescott new instructions) for historical reasons. We added
> > the bit too early before Intel's marketing department could make up its
> > mind fully, so Linux is stuck with the old codename.
> >
> Does anything actually parse the /proc/cpuinfo flags field? are we
> really stuck with it?

Do you really want to find out by a report from a rightfully annoyed user?
I considered at some point to print sse3 in addition to pni, but then
it seemed like too much bloat for only a cosmetical issue. Maybe if it 
becomes a popular FAQ, but it isn't that far yet.

(I can just see the headlines for such a patch -
"Linux 2.6.20 finally adding SSE3 support")

-Andi

i386: Move phys_proc_id/early intel workaround to correct function.

early_cpu_detect only runs on the BP, but this code needs to run
on all CPUs.

Looks like a mismerge somewhere.  Also add a warning comment.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/cpu/common.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/common.c
+++ linux/arch/i386/kernel/cpu/common.c
@@ -204,7 +204,10 @@ static int __devinit have_cpuid_p(void)
 
 /* Do minimum CPU detection early.
    Fields really needed: vendor, cpuid_level, family, model, mask, cache alignment.
-   The others are not touched to avoid unwanted side effects. */
+   The others are not touched to avoid unwanted side effects. 
+
+   WARNING: this function is only called on the BP.  Don't add code here
+   that is supposed to run on all CPUs. */
 static void __init early_cpu_detect(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
@@ -236,12 +239,6 @@ static void __init early_cpu_detect(void
 		if (cap0 & (1<<19))
 			c->x86_cache_alignment = ((misc >> 8) & 0xff) * 8;
 	}
-
-	early_intel_workaround(c);
-
-#ifdef CONFIG_X86_HT
-	phys_proc_id[smp_processor_id()] = (cpuid_ebx(1) >> 24) & 0xff;
-#endif
 }
 
 void __devinit generic_identify(struct cpuinfo_x86 * c)
@@ -289,6 +286,12 @@ void __devinit generic_identify(struct c
 				get_model_name(c); /* Default name */
 		}
 	}
+
+	early_intel_workaround(c);
+
+#ifdef CONFIG_X86_HT
+	phys_proc_id[smp_processor_id()] = (cpuid_ebx(1) >> 24) & 0xff;
+#endif
 }
 
 static void __devinit squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
