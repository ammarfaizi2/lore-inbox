Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751401AbWFEUME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWFEUME (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWFEUMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:12:03 -0400
Received: from xenotime.net ([66.160.160.81]:42463 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751401AbWFEUMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:12:01 -0400
Date: Mon, 5 Jun 2006 13:14:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Dave Jones <davej@redhat.com>
Cc: mingo@elte.hu, mbligh@google.com, akpm@osdl.org, apw@shadowen.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-Id: <20060605131447.4f46bbaf.rdunlap@xenotime.net>
In-Reply-To: <20060605200554.GB6143@redhat.com>
References: <44845C27.3000006@google.com>
	<20060605194422.GB14709@elte.hu>
	<20060605130039.db1ac80c.rdunlap@xenotime.net>
	<20060605200554.GB6143@redhat.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 16:05:54 -0400 Dave Jones wrote:

> On Mon, Jun 05, 2006 at 01:00:39PM -0700, Randy.Dunlap wrote:
>  > On Mon, 5 Jun 2006 21:44:22 +0200 Ingo Molnar wrote:
>  > 
>  > > 
>  > > * Martin Bligh <mbligh@google.com> wrote:
>  > > 
>  > > > panic on NUMA-Q during LTP. Was fine in -mm2.
>  > > > 
>  > > > BUG: unable to handle kernel paging request at virtual address 22222232
>  > > 
>  > > > EIP is at check_deadlock+0x19/0xe1
>  > > > eax: 00000001   ebx: e4453030   ecx: 00000000   edx: e4008000
>  > > > esi: 22222222   edi: 00000001   ebp: 22222222   esp: e47ebec0
>  > > 
>  > > again these 0x22222222 entries on the stack. What on earth does this? 
>  > > Andy got a similar crash on x86_64, with a 0x2222222222222222 entry ...
>  > > 
>  > > nothing of our magic values are 0x22 or 0x222222222.
>  > 
>  > kernel/mutex-debug.c:
>  > void debug_mutex_free_waiter(struct mutex_waiter *waiter)
>  > {
>  > 	DEBUG_WARN_ON(!list_empty(&waiter->list));
>  > 	memset(waiter, 0x22, sizeof(*waiter));
>  > }
> 
> Documentation/magic-number.txt sounds so promising, but we scatter definitions
> of numbers all over the place. (No mention of the slab poison values,
> or similar numbers there for eg, and various pointers to _other_ lists
> of magic numbers).

I have a few more that I can add to include/linux/poison.h, like this one
above (only in -mm at present).

./include/linux/libata.h:#define ATA_TAG_POISON		0xfafbfcfdU

./arch/ppc/8260_io/fcc_enet.c:1918:	memset((char *)(&(immap->im_dprambase[(mem_addr+64)])), 0x88, 32);
./drivers/usb/mon/mon_text.c:429:	memset(mem, 0xe5, sizeof(struct mon_event_text));

./kernel/mutex-debug.c:384:	memset(waiter, 0x11, sizeof(*waiter));
./kernel/mutex-debug.c:400:	memset(waiter, 0x22, sizeof(*waiter));

./security/keys/key.c:985:			memset(&key->payload, 0xbd, sizeof(key->payload));

./drivers/char/ftape/lowlevel/ftape-ctl.c:738:		memset(ft_buffer[i]->address, 0xAA, FT_BUFF_SIZE);

./drivers/block/sx8.c:/* 0xf is just arbitrary, non-zero noise; this is sorta like poisoning */


---
~Randy
