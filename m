Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWCKPJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWCKPJw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 10:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWCKPJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 10:09:52 -0500
Received: from mail.deathmatch.net ([216.200.85.210]:60336 "EHLO
	mail.deathmatch.net") by vger.kernel.org with ESMTP
	id S1751134AbWCKPJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 10:09:51 -0500
Date: Sat, 11 Mar 2006 10:09:08 -0500
From: Bob Copeland <me@bobcopeland.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: paulus@samba.org, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
Message-ID: <20060311150908.GA4872@hash.localnet>
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com> <1142011340.3220.4.camel@amdx2.microgate.com> <b6c5339f0603101048l1c362582xc4d2570bc9d569b@mail.gmail.com> <1142018709.26063.5.camel@amdx2.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142018709.26063.5.camel@amdx2.microgate.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 01:25:09PM -0600, Paul Fulghum wrote:
> The i_sem to i_mutex change started in the 2.6.16 series.
> Running against 2.6.15 would be interesting. Being able
> to repeat every time is a plus. I'm not that familiar
> with the sysfs stuff, but the slab poisoning is pretty
> damning. The dentry was released and then accessed.
> 
> I looked at cdc_acm for disconnect and close and
> did not see any problems (such as trying to call
> tty_unregister_device twice for a device).

Well, back to at least 2.6.15-rc7 I get a similar oops so this looks old 
and unrelated to the mutex changes.  I don't believe it triggers without 
CONFIG_DEBUG_SLAB.  Also won't oops without something (ppp) using the 
device at the time of disconnect.

Unable to handle kernel paging request at virtual address 6b6b6bdb
 printing eip:
c0176da6
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: ppp_deflate zlib_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc cdc_acm i915 binfmt_misc parport_pc lp parport video thermal processor fan button battery ac af_packet nls_iso8859_1 nls_cp437 vfat fat dm_mod fuse usb_storage ide_cd sr_mod scsi_mod cdrom i810 drm eth1394 pcmcia crc32 ipw2100 tg3 ieee80211 ieee80211_crypt joydev 8250_pci 8250 serial_core evdev snd_intel8x0 snd_intel8x0m yenta_socket rsrc_nonstatic pcmcia_core ohci1394 ieee1394 snd_ac97_codec snd_ac97_bus ehci_hcd uhci_hcd intel_agp agpgart usbcore unix
CPU:    0
EIP:    0060:[<c0176da6>]    Not tainted VLI
EFLAGS: 00210202   (2.6.15-rc7) 
EIP is at sysfs_hash_and_remove+0x2a/0x100
eax: 00200246   ebx: 6b6b6b6b   ecx: 00000063   edx: cdea3c1c
esi: cefe68d4   edi: cf608c60   ebp: cf608ccc   esp: ce1fbe50
ds: 007b   es: 007b   ss: 0068
Process pppd (pid: 4128, threadinfo=ce1fa000 task=cef61540)
Stack: c0288916 00000063 6b6b6b6b c64182d0 cefe68d4 cf608c60 cf608ccc c01e9f5f 
       ced938a0 cefe68d4 cedb611c c02a0f11 c64182d0 00000000 c64182d0 ce970e40 
       00000000 00000000 c01e9fbf c64182d0 ccf14d68 d03e246e c64182d0 0a600000 
Call Trace:
 [<c01e9f5f>] class_device_del+0x94/0xe9
 [<c01e9fbf>] class_device_unregister+0xb/0x16
 [<d03e246e>] acm_tty_unregister+0x16/0x54 [cdc_acm]
 [<d03e2533>] acm_tty_close+0x87/0x96 [cdc_acm]
 [<c01d7f15>] release_dev+0x1b1/0x5dc
 [<c011d8a6>] __group_send_sig_info+0x5d/0x69
 [<c011eb1a>] sys_kill+0x4e/0x55
 [<c01d8774>] tty_release+0x9/0xd
 [<c0146efb>] __fput+0x9f/0x12c
 [<c0145b6b>] filp_close+0x4e/0x57
 [<c0145bca>] sys_close+0x56/0x63
 [<c0102ad5>] syscall_call+0x7/0xb
Code: c3 55 57 56 53 51 8b 44 24 18 8b 40 50 89 04 24 8b 44 24 18 8b 58 08 85 db 0f 84 dc 00 00 00 6a 63 68 16 89 28 c0 e8 32 d0 f9 ff <ff> 4b 70 0f 88 cd 00 00 00 8b 44 24 08 8b 68 0c 58 5a 83 ed 04 

-- 
Bob Copeland %% www.bobcopeland.com 
