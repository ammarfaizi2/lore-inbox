Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWCRVko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWCRVko (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 16:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWCRVko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 16:40:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750990AbWCRVkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 16:40:43 -0500
Date: Sat, 18 Mar 2006 13:40:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com,
       Dave Jones <davej@redhat.com>
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <200603181525.14127.kernel-stuff@comcast.net>
Message-ID: <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gaah. Looking at the assembly code to try to figure out where the oops 
happened, one thing is clear: "for_each_cpu_mask()" generates some truly 
horrible code. C code that looks simple ends up being tons of complex 
assembly language due to inline functions etc.

We've made it way too easy for people to write code that just absolutely 
_sucks_.

It's extra sad, because disassembling Parag's oops, it looks like he has 
limited NR_CPU's to 2 (appropriate for his setup), yet we literally do 
things like:

	<code+0>:    bsf    %eax,%eax
	<code+3>:    cmp    $0x3,%eax
	<code+6>:    mov    $0x2,%ebx
	<code+11>:   cmovl  %eax,%ebx
	<code+14>:   cmp    $0x1,%ebx
	<code+17>:   ja     0x80495fc
	<code+19>:   mov    %ebp,%esi
	<code+21>:   lea    0x0(%esi),%esi
	<code+27>:   mov    0x78448004(,%ebx,4),%eax
	<code+34>:   mov    $0x2,%edi
	<code+39>:   add    %esi,%eax
**	<code+41>:   mov    (%eax),%eax		** oops here **
	<code+43>:   mov    0x1c(%eax),%eax
	<code+46>:   mov    %edi,0x4(%esp)
	<code+50>:   movl   $0x7840d1bc,(%esp)
	<code+57>:   mov    %eax,0x???(,%ebx,4)

where 90% of that code seems to be just cruft from __next_cpu(): the 
"bsf", the comparisons against 3 (n+1), the $0x2 setup for calling 
find_next_bit()..

Anyway, I _think_ it's this one:

                for_each_online_cpu(j) {
                        dbs_info = &per_cpu(cpu_dbs_info, j);
                        requested_freq[j] = dbs_info->cur_policy->cur;
                }

where dbs_info->cur_policy seems to be NULL. Maybe. Exactly because 90% of 
the instructions come from that generic stuff around it, it's hard to be 
sure, and I don't have the same compiler version Parag does.

		Linus

On Sat, 18 Mar 2006, Parag Warudkar wrote:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000001c
>  printing eip:
> f834e6d0
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP
> Modules linked in: cpufreq_conservative oprofile ntfs snd_pcm_oss 
> snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device eth1394 
> ohci1394 i2c_i801 i2c_core hw_random ipw3945 ieee80211 ieee80211_crypt 
> firmware_class snd_hda_intel snd_hda_codec snd_pcm snd_timer snd 
> snd_page_alloc i915 drm cpufreq_ondemand speedstep_centrino b44
> CPU:    1
> EIP:    0060:[<f834e6d0>]    Not tainted VLI
> EFLAGS: 00010206   (2.6.16-rc6 #3)
> EIP is at dbs_check_cpu+0x220/0x400 [cpufreq_conservative]
> eax: 00000000   ebx: 00000001   ecx: 00000001   edx: 7840d1bc
> esi: 78445730   edi: 00000002   ebp: 78445730   esp: 7a1c1ef0
> ds: 007b   es: 007b   ss: 0068
> Process events/1 (pid: 9, threadinfo=7a1c0000 task=7a33fa90)
> Stack: <0>7840d1bc 00000002 00000001 7a2d3a80 00000000 f834f704 7a1aa1c0 
> 00000000
>        f834e938 00000000 00000202 7a1c0000 f834f700 78132869 00000000 00000000
>        18a60e00 7a1aa1d0 7a1aa1e8 f834e8b0 00000202 7a1c0000 7a1aa1d8 7a1aa1d0
> Call Trace:
>  [<f834e938>] do_dbs_timer+0x88/0xc0 [cpufreq_conservative]
>  [<78132869>] run_workqueue+0x79/0xf0
>  [<f834e8b0>] do_dbs_timer+0x0/0xc0 [cpufreq_conservative]
>  [<78132a38>] worker_thread+0x158/0x180
>  [<7811b0d0>] default_wake_function+0x0/0x20
>  [<7811b0d0>] default_wake_function+0x0/0x20
>  [<781328e0>] worker_thread+0x0/0x180
>  [<7813664c>] kthread+0xbc/0x100
>  [<78136590>] kthread+0x0/0x100
>  [<78101285>] kernel_thread_helper+0x5/0x10
> Code: 0f bc c0 83 f8 03 bb 02 00 00 00 0f 4c d8 83 fb 01 77 49 89 ee 8d b6 00 
> 00 00 00 8b 04 9d 04 80 44 78 bf 02 00 00 00 01 f0 8b 00 <8b> 40 1c 89 7c 24 
> 04 c7 04 24 bc d1 40 78 89 04 9d 48 fa 34 f8
> 
