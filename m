Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161175AbWI1VXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161175AbWI1VXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWI1VXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:23:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21961 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161008AbWI1VXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:23:18 -0400
Date: Thu, 28 Sep 2006 14:23:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-1.2689.fc6PAE: oops in ext3_clear_inode+0x52/0x8b
Message-Id: <20060928142313.8848cec9.akpm@osdl.org>
In-Reply-To: <451C33B2.5000007@goop.org>
References: <451C33B2.5000007@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 13:42:26 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> I just filed this in the Redhat bugzilla, since its from the FC6 distro 
> kernel.  But since its fairly close to current kernel.org kernels, I 
> thought it might be relevent.
> 
> The bug is https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208488
> 
> Unfortunately this isn't a very useful report since it was a once-off, 
> and there's a P-tainting module in there.  But if anyone sees anything 
> else like this, it's interesting.
> 
> The oops is:
> 
> BUG: unable to handle kernel paging request at virtual address 756e6547

756e6547 -> uneG.   Matches "GenuineIntel".

That'll get written into a temporary page by the /proc/cpuinfo handler, so
it might just be a use-uninitialised.

>  printing eip:
> f898bf73
> *pde = 0014c7c0
> Oops: 0002 [#1]
> SMP 
> last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> Modules linked in: ath_pci(U) usb_storage loop wlan_wep(U) snd_hda_codec nfsd exportfs lockd nfs_acl tun ppp_deflate zlib_deflate ppp_async crc_ccitt ppp_generic slhc airprime usbserial hci_usb cpufreq_powersave i915 drm cpufreq_conservative ipv6 autofs4 hidp rfcomm l2cap bluetooth sunrpc ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables vfat fat dm_mirror dm_mod video sbs ibm_acpi i2c_ec dock button battery asus_acpi ac parport_pc lp parport snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq wlan_scan_sta(U) snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm ath_rate_sample(U) mmc_block snd_timer snd sg ohci1394 i2c_i801 wlan(U) ieee1394 sdhci soundcore pcspkr i2c_core snd_page_alloc serio_raw e1000 mmc_core ath_hal(U) ahci libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
> CPU:    0
> EIP:    0060:[<f898bf73>]    Tainted: P      VLI
> EFLAGS: 00013206   (2.6.18-1.2689.fc6PAE #1) 
> EIP is at ext3_clear_inode+0x52/0x8b [ext3]
> eax: c07dda80   ebx: c07dd994   ecx: 00000000   edx: 756e6547
> esi: c07dda80   edi: 00000000   ebp: f3f0cda0   esp: f3f0cd94
> ds: 007b   es: 007b   ss: 0068
> Process Xorg (pid: 2862, ti=f3f0c000 task=f3cf4030 task.ti=f3f0c000)
> Stack: c07dda80 c07ddc9c 0000001f f3f0cdb0 c04881e5 c07dda80 c07dda88 f3f0cdc8 
>        c04884ba f3f0cdd8 c0bf3db0 00000000 00000080 f3f0cdec c04886c6 00000080 
>        00000080 c07dddb8 f32d1428 0000620c f7ff62fc 000000a9 f3f0ce1c c045ba2d 
> Call Trace:
>  [<c04881e5>] clear_inode+0xd8/0x129
>  [<c04884ba>] dispose_list+0x3c/0xc1
>  [<c04886c6>] shrink_icache_memory+0x187/0x1af
>  [<c045ba2d>] shrink_slab+0xd0/0x137
>  [<c045c285>] try_to_free_pages+0x159/0x218
>  [<c045860d>] __alloc_pages+0x199/0x287
>  [<c045f3b8>] __handle_mm_fault+0x1b2/0xb84
>  [<c0614a5a>] do_page_fault+0x2b1/0x5ba
>  [<c0404be9>] error_code+0x39/0x40

It's relatively common for that big inode LRU walk to wander off in the
wrong direction and to start operating on random memory.

IOW: don't know.  Something scribbled on memory somewhere.
