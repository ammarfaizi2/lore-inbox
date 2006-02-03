Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWBCUhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWBCUhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWBCUhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:37:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751479AbWBCUhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:37:24 -0500
Date: Fri, 3 Feb 2006 12:36:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm5
Message-Id: <20060203123657.5c33dc5b.akpm@osdl.org>
In-Reply-To: <20060203201334.GA23182@ens-lyon.fr>
References: <20060203000704.3964a39f.akpm@osdl.org>
	<40f323d00602030217l77db3dd0o4f3f66eac74950f3@mail.gmail.com>
	<20060203201334.GA23182@ens-lyon.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benoit Boissinot <bboissin@gmail.com> wrote:
>
> On 2/3/06, Benoit Boissinot <bboissin@gmail.com> wrote:
> > On 2/3/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm5/
> > >
> > >
> > > - The ntp/time rework patches from John Stultz have been resurrected and fixed.
> > >
> > > - There's now a `hot-fixes' directory at the above URL.  Please look in
> > >   there for any updates which should be applied.
> >
> > It runs fine here, no problems. Even iptables works this time.
> 
> Actually it spoke too fast, I have the following oops with
> CONFIG_DEBUG_INITDATA=y (it does not oops without this config
> option).
> 
> I can send full dmesg and .config if needed (the bug is reproducable).
> 
> with gcc4.1 (I supposed buffered_rmqueue is inlined):
> 
> BUG: unable to handle kernel paging request at virtual address c0401000
>  printing eip:
> c013ea41
> *pde = 1ff0a163
> *pte = 00401000
> Oops: 0002 [#1]
> last sysfs file: /devices/pci0000:00/0000:00:1e.0/0000:02:03.0/rf_kill
> Modules linked in: aes ieee80211_crypt_ccmp radeon drm ipt_multiport xt_state xt_limit ipt_REJECT xt_tcpudp iptable_filter iptable_nat ip_nat ip_tables x_tables ip_conntrack_irc ip_conntrack_ftp ip_conntrack nfnetlink snd_seq snd_seq_device snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc speedstep_centrino cpufreq_stats freq_table cpufreq_conservative cpufreq_ondemand cpufreq_performance cpufreq_powersave fan button thermal processor battery ac uhci_hcd ehci_hcd usbcore tg3 ipw2200 ieee80211 ieee80211_crypt psmouse ide_cd cdrom
> CPU:    0
> EIP:    0060:[<c013ea41>]    Not tainted VLI
> EFLAGS: 00010287   (2.6.16-rc1-mm5-casaverde #15) 
> EIP is at get_page_from_freelist+0x2d1/0x330
> eax: 00000000   ebx: 00000000   ecx: 00000400   edx: 00000400
> esi: c1008020   edi: c0401000   ebp: da64eed8   esp: da64ee8c
> ds: 007b   es: 007b   ss: 0068
> Process hg (pid: 18179, threadinfo=da64e000 task=da437560)
> Stack: <0>00000002 00000044 c1008020 00000001 00000001 c03b8b60 00000000 c03b8b40 
>        00000002 00000000 000280d2 c03b900c 00000000 00000202 00000000 00000001 
>        c03b9008 da437560 000280d2 da64ef18 c013f1b5 00000044 00000000 00000000 
> Call Trace:
>  <c0103f05> show_stack_log_lvl+0xc5/0xf0   <c01040ba> show_registers+0x18a/0x210
>  <c010421f> die+0xdf/0x1f0   <c0114266> do_page_fault+0x276/0x5ec
>  <c010391f> error_code+0x4f/0x54   <c013f1b5> __alloc_pages+0x55/0x2c0
>  <c01461d4> __handle_mm_fault+0x3f4/0x730   <c01143b4> do_page_fault+0x3c4/0x5ec
>  <c010391f> error_code+0x4f/0x54  

Ahem, I don't think I actually tested that.

This would seem to be needed, but I don't think it'll fix that one.


From: Andrew Morton <akpm@osdl.org>

Don't touch page_state[not-possible-CPU].

And a couple of little optimisations.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/page_alloc.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -puN mm/page_alloc.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject-update2 mm/page_alloc.c
--- devel/mm/page_alloc.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject-update2	2006-02-03 12:26:33.000000000 -0800
+++ devel-akpm/mm/page_alloc.c	2006-02-03 12:34:34.000000000 -0800
@@ -1213,18 +1213,21 @@ static void __get_page_state(struct page
 {
 	int cpu = 0;
 
-	memset(ret, 0, sizeof(*ret));
+	memset(ret, 0, nr * sizeof(unsigned long));
 	cpus_and(*cpumask, *cpumask, cpu_online_map);
 
 	cpu = first_cpu(*cpumask);
 	while (cpu < NR_CPUS) {
 		unsigned long *in, *out, off;
 
+		if (!cpu_isset(cpu, *cpumask))
+			continue;
+
 		in = (unsigned long *)&per_cpu(page_states, cpu);
 
 		cpu = next_cpu(cpu, *cpumask);
 
-		if (cpu < NR_CPUS)
+		if (likely(cpu < NR_CPUS))
 			prefetch(&per_cpu(page_states, cpu));
 
 		out = (unsigned long *)ret;
@@ -1886,8 +1889,7 @@ static void setup_pagelist_highmark(stru
  * not check if the processor is online before following the pageset pointer.
  * Other parts of the kernel may not check if the zone is available.
  */
-static struct per_cpu_pageset
-	boot_pageset[NR_CPUS];
+static struct per_cpu_pageset boot_pageset[NR_CPUS];
 
 /*
  * Dynamically allocate memory for the
_

