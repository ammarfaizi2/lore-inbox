Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWA0KLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWA0KLU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWA0KLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:11:20 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:41359 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932461AbWA0KLT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:11:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q1HHuXKRtqBix91fbpU9/aCCO9+mbV/QdmKiND9kb+wGyQwRkVP1FM1POgQLZFlPxAsdu9lj68yj/f8BcR79xHYLMXcItv28bghP8pvcZdyfT9CdDsVf9AAL275NTM839mKKtxL2k1VsgOSeOimFiru5DLnM9LcRe18OlqwfuyU=
Message-ID: <6bffcb0e0601270211v787f91d2r@mail.gmail.com>
Date: Fri, 27 Jan 2006 11:11:17 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.16-rc1-mm3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43D927F6.9080807@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124232406.50abccd1.akpm@osdl.org>
	 <6bffcb0e0601250340x6ca48af0w@mail.gmail.com>
	 <43D7A047.3070004@yahoo.com.au>
	 <6bffcb0e0601261102j7e0a5d5av@mail.gmail.com>
	 <43D92754.4090007@yahoo.com.au> <43D927F6.9080807@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/01/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Nick Piggin wrote:
> Sorry, wrong patch.
>
> Note the warnings you are seeing should not result in memory
> corruption, but will result in the given hugepage leaking.
>
> --
> SUSE Labs, Novell Inc.
>
>
> Index: linux-2.6/include/linux/mm.h
> ===================================================================
> --- linux-2.6.orig/include/linux/mm.h
> +++ linux-2.6/include/linux/mm.h
> @@ -294,6 +294,8 @@ struct page {
>   */
>  static inline int put_page_testzero(struct page *page)
>  {
> +       if (unlikely(PageCompound(page)))
> +               page = (struct page *)page_private(page);
>         BUG_ON(atomic_read(&page->_count) == 0);
>         return atomic_dec_and_test(&page->_count);
>  }
>
>
>

Now I have got this:

BUG: unable to handle kernel paging request at virtual address eaa34b3c
 printing eip:
b0161cdd
*pde = 0048a067
*pte = 3aa34000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
last sysfs file: /devices/pci0000:00/0000:00:1d.1/usb3/idVendor
Modules linked in: snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer ide_cd cdrom intel_agp
agpgart snd i2c_i801 hw_random soundcore snd_page_alloc unix
CPU:    0
EIP:    0060:[<b0161cdd>]    Not tainted VLI
EFLAGS: 00010282   (2.6.16-rc1-mm3 #4)
EIP is at do_path_lookup+0x22b/0x259
eax: eaa34b20   ebx: eb328000   ecx: 00000000   edx: eb328f4c
esi: ffffff9c   edi: fffffffe   ebp: eb328f24   esp: eb328f0c
ds: 007b   es: 007b   ss: 0068
Process udevd (pid: 731, threadinfo=eb328000 task=eb30ca80)
Stack: <0>00000000 eb5cb000 b015fab1 eb5cb000 eb5cb000 00000000
eb328f40 b01621f3
       eb328f4c ffffff9c afbf6dec afbf6dec 00000100 eb328f9c b015bf69 eb328f4c
       eaa34b20 b23d5f28 00000000 eb329003 b015f8ce 00000000 00000001 00000000
Call Trace:
 [<b0103917>] show_stack_log_lvl+0xaa/0xb5
 [<b0103a54>] show_registers+0x132/0x19d
 [<b0103d91>] die+0x171/0x1fb
 [<b02ab110>] do_page_fault+0x3be/0x568
 [<b010343f>] error_code+0x4f/0x54
 [<b01621f3>] __user_walk_fd+0x2d/0x41
 [<b015bf69>] sys_readlinkat+0x26/0x93
 [<b015bfe9>] sys_readlink+0x13/0x15
 [<b01028bf>] sysenter_past_esp+0x54/0x75
Code: 00 83 c0 04 e8 9a 82 14 00 8b 03 c7 80 e4 01 00 00 00 00 00 00
8b 55 08 8b 45 ec e8 55 fa ff ff 89 c7 8b 55 08 8b 02 85 c0 74 24 <8b>
50 1c 85 d2 74 1d b8 00 f0 ff ff 21 e0 8b 00 83 b8 d4 04 00
 <6>ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 21

Here is dmesg:
http://www.stardust.webpages.pl/files/mm/2.6.16-rc1-mm3/mm-dmesg2

Here is config
http://www.stardust.webpages.pl/files/mm/2.6.16-rc1-mm3/mm-config

Regards,
Michal Piotrowski
