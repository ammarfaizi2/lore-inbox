Return-Path: <linux-kernel-owner+w=401wt.eu-S965252AbXAJXxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbXAJXxm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbXAJXxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:53:42 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:21595 "HELO
	smtp107.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965252AbXAJXxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:53:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=zUabKkPUHVDQX2SgamfEjfuFBqtofl87VcOQNkbxIviRFvXovOuhpcfHB7kuWpIINpgY9gD3Qw3FYfU+VLuDCUqZoNy6S6jZ5pjB2G35hIm4r6LeL5E+/CAuqcbr7S4UCsIFXl1Atwgr/oZvx3z7xPmN/cVL5AM8xNQYqAPMCXY=  ;
X-YMail-OSG: IyrD1JUVM1mpvym6Lg9.7JbCfsHw0qTLqvTJ009yl4N7iKvNo.Y_r6Z8C7vcse9W8MxhMKs1jhNg2TpF0r7GcJ7z4mXJox8DneSmMEbBg7xv9SPz3J.rI1zexvj_s6IKq_cmZXSyGv8M64Y-
Message-ID: <45A57C69.6090305@yahoo.com.au>
Date: Thu, 11 Jan 2007 10:53:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: page_mapcount(page) went negative
References: <20061204204024.2401148d.akpm@osdl.org> <20061205160250.GB9076@kernelslacker.org> <20061212174909.GD2140@redhat.com> <458776A5.3060007@yahoo.com.au> <20070107173612.GC6111@redhat.com>
In-Reply-To: <20070107173612.GC6111@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Dec 19, 2006 at 04:20:37PM +1100, Nick Piggin wrote:

>  > IMO the pattern is much too consistent to be able to attribute
>  > them all to hardware problems. And considering it takes so long
>  > for these things to appear, can we get something like the attached
>  > patch upstream at least until we manage to stamp them out? Any
>  > other debugging info we can add?
> 
> I finally got another trace out of a 2.6.19.1 with this debug patch..
> I'm starting to wonder if this is hardware related.
> That box makes me suspicious as its motherboard has a bunch
> of bulging capacitors on it. I had three of these, the previous
> two died like so: http://www.flickr.com/photos/kernelslacker/251807263/in/set-72157594298237090/
> This board hasn't started 'oozing' yet, but I think it may be on
> the cards.
> 
> iirc, the previous oopses were around the same time of morning,
> whilst cron.daily was hammering the hell out of the disk.
> Either there's a subtle bug, or this board just can't take the pressure.

The reason why I'm inclined to think there might be a kernel bug is that this
bug seems to trigger a disproportionately high number of times if you consider
the frequency of reports vs frequency of reports of bad page state or bad
pte bugs, for example.

> Jan  7 04:24:35 firewall kernel: Eeek! page_mapcount(page) went negative! (-1)
> Jan  7 04:24:35 firewall kernel:   page->flags = 414

referenced|dirty|reserved

> Jan  7 04:24:35 firewall kernel:   page->count = 1
> Jan  7 04:24:35 firewall kernel:   page->mapping = 00000000

OK, so it is !PageAnon. Seems like the file was truncated?! Then it shouldn't
be mapped at all? OTOH the truncate could easily have skipped such a page:
truncate doesn't rely on mapcount like invalidate.

Hmm, it could be invalidated or vmtruncate_range()d, if you've hit the nopage
vs invalidate race. But would that cause the mapcount to skew? I don't see
how...

> Jan  7 04:24:35 firewall kernel:   vma->vm_ops->nopage = filemap_nopage+0x0/0x33e

filemap_nopage. Then PG_reserved should not be getting set, AFAIKS.

Might pte corruption have caused us to get completely the wrong page here?



> Jan  7 04:24:35 firewall kernel: ------------[ cut here ]------------
> Jan  7 04:24:35 firewall kernel: kernel BUG at mm/rmap.c:581!
> Jan  7 04:24:35 firewall kernel: invalid opcode: 0000 [#1]
> Jan  7 04:24:35 firewall kernel: SMP 
> Jan  7 04:24:35 firewall kernel: last sysfs file: /class/net/lo/type
> Jan  7 04:24:35 firewall kernel: Modules linked in: tun ipt_MASQUERADE iptable_nat ip_nat ipt_LOG xt_limit ipv6 ip_conntrack_netbios_ns ipt_REJECT xt_state i
> p_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables video sbs i2c_ec button battery asus_acpi ac parport_pc lp parport sr_mod sg pcspkr i2c_via
> pro ide_cd i2c_core 3c59x via_rhine cdrom mii via_ircc irda crc_ccitt serio_raw dm_snapshot dm_zero dm_mirror dm_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
> Jan  7 04:24:35 firewall kernel: CPU:    0
> Jan  7 04:24:35 firewall kernel: EIP:    0060:[<c046d995>]    Not tainted VLI
> Jan  7 04:24:35 firewall kernel: EFLAGS: 00010286   (2.6.19-1.2886.fc6debug #1)
> Jan  7 04:24:35 firewall kernel: EIP is at page_remove_rmap+0x8b/0xac
> Jan  7 04:24:35 firewall kernel: eax: 00000034   ebx: c1000000   ecx: c042818c   edx: da0b3550
> Jan  7 04:24:35 firewall kernel: esi: daecd0c0   edi: 00000020   ebp: cd386140   esp: ce2f4dc4
> Jan  7 04:24:35 firewall kernel: ds: 007b   es: 007b   ss: 0068
> Jan  7 04:24:35 firewall kernel: Process zcat (pid: 22721, ti=ce2f4000 task=da0b3550 task.ti=ce2f4000)
> Jan  7 04:24:35 firewall kernel: Stack: c066b7b6 00000000 c1000000 08050000 c0467c63 c06c7f10 00000046 00000000 
> Jan  7 04:24:35 firewall kernel:        daecd0c0 ce2f4e44 003f7ffd 00000000 00000001 08055000 cf354080 dde93520 
> Jan  7 04:24:35 firewall kernel:        c1401e80 00000000 fffffff9 dde9358c cf354080 08055000 00000000 ce2f4e44 
> Jan  7 04:24:35 firewall kernel: Call Trace:
> Jan  7 04:24:35 firewall kernel:  [<c0467c63>] unmap_vmas+0x2a6/0x536
> Jan  7 04:24:35 firewall kernel:  [<c046aaa8>] exit_mmap+0x77/0x105
> Jan  7 04:24:35 firewall kernel:  [<c0425471>] mmput+0x37/0x80
> Jan  7 04:24:35 firewall kernel:  [<c042a4b5>] do_exit+0x21c/0x7a3
> Jan  7 04:24:35 firewall kernel:  [<c042aac9>] sys_exit_group+0x0/0xd
> Jan  7 04:24:35 firewall kernel:  [<c043383d>] get_signal_to_deliver+0x38b/0x3b3
> Jan  7 04:24:35 firewall kernel:  [<c0403677>] do_notify_resume+0x83/0x6c6
> Jan  7 04:24:35 firewall kernel:  [<c0404159>] work_notifysig+0x13/0x1a
> Jan  7 04:24:35 firewall kernel:  [<0804a84e>] 0x804a84e
> Jan  7 04:24:35 firewall kernel:  =======================
> Jan  7 04:24:35 firewall kernel: Code: 4c a4 fb ff 8b 43 10 c7 04 24 b6 b7 66 c0 89 44 24 04 e8 39 a4 fb ff 8b 46 40 85 c0 74 0d 8b 50 08 b8 cf b7 66 c0 e8 d
> 8 a9 fd ff <0f> 0b 45 02 4b b7 66 c0 8b 53 10 89 d8 59 5b 5b 5e 83 f2 01 83 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
