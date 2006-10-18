Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWJRKNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWJRKNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWJRKNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:13:45 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:48974 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932184AbWJRKNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:13:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ddPS/cCoJ65EStP3PTI6z+IOGFl/QiwPDRhwuSvVnKsWT8AJ7BmR7a+4h02N1x5xGYIJ83GYf4lKgFYgzaZQbC+yPJQuEdrNDXKi93eyihyDrpjO06zZa0DxF7GFUspzSN0+fc21BBZY83bj3UxjpQVEbyxnuYVkyfIXdpvxIVk=
Message-ID: <b0943d9e0610180313ob813549r8181504c50de8a52@mail.gmail.com>
Date: Wed, 18 Oct 2006 11:13:44 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 00/10] Kernel memory leak detector 0.11
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0610090718x185cc03cv20a117cf8f3c45e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061009124813.2695.8123.stgit@localhost.localdomain>
	 <6bffcb0e0610090718x185cc03cv20a117cf8f3c45e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 09/10/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> I have a new false positives :)
> http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.11/ml.txt

I eventually found some time to look at these reports. See below for
comments (I removed the duplicates):

unreferenced object 0xdff2213c (size 398):
  [<c0166bc1>] memleak_alloc
  [<c0164d15>] __kmalloc_track_caller
  [<c01548c1>] __kzalloc
  [<c024361b>] platform_device_alloc
  [<c03e9076>] add_pcspkr
  [<c03e48bd>] do_initcalls
  [<c03e496a>] do_basic_setup
  [<c0100421>] init
  [<c01039ab>] kernel_thread_helper
  [<ffffffff>]

Kmemleak is probably right in that this code will never be able to
free the platform device (the pointer was only stored on the stack).
However, this won't be needed and I'll mark it as not being a leak.

unreferenced object 0xf4f4eb68 (size 8):
  [<c0166bc1>] memleak_alloc
  [<c0164d15>] __kmalloc_track_caller
  [<c01548c1>] __kzalloc
  [<c0166479>] __percpu_alloc_mask
  [<fd954a1b>] snmp6_mib_init
  [<fd926017>] ip6t_hook
  [<fd9260f2>] __param_forward
  [<c013b5ad>] sys_init_module
  [<c0102dd5>] sysenter_past_esp
  [<ffffffff>]

This might be a real leak since the previous kmemleak versions were
ignoring all the percpu allocations. I'm a bit confused about the
calling chain between ip6t_hook and snmp6_mib_init. Maybe the network
people could shed some light on this.

unreferenced object 0xf4a17304 (size 1412):
  [<c0166bc1>] memleak_alloc
  [<c0164c2d>] __kmalloc
  [<fd95c587>] addrconf_sysctl_register
  [<fd926337>] __param_forward
  [<fd92619e>] __param_forward
  [<c013b5ad>] sys_init_module
  [<c0102dd5>] sysenter_past_esp
  [<ffffffff>]
unreferenced object 0xf48f75bc (size 8):
  [<c0166bc1>] memleak_alloc
  [<c0164d15>] __kmalloc_track_caller
  [<c0154915>] kstrdup
  [<fd95c5fa>] addrconf_sysctl_register
  [<fd926337>] __param_forward
  [<fd92619e>] __param_forward
  [<c013b5ad>] sys_init_module
  [<c0102dd5>] sysenter_past_esp
  [<ffffffff>]

I have the same problem with the stack trace here - can't find
__param_forward in the code and it also looks strange to have a
recursive call into this function.

I suspect you use the skge.c Ethernet driver. Is it possible to link
this into the kernel (not as a module) and maybe together with the
networking stuff? It might show a clearer stack trace.

unreferenced object 0xf44869e4 (size 160):
  [<c0166bc1>] memleak_alloc
  [<c0164a30>] kmem_cache_alloc
  [<c02a91a0>] __alloc_skb
  [<f9882439>] FillRxDescriptor
  [<f9882408>] FillRxRing
  [<f9881bdf>] SkGeOpen
  [<c02adcda>] dev_open
  [<c02af332>] dev_change_flags
  [<c02e27dd>] devinet_ioctl
  [<c02e4372>] inet_ioctl
  [<c02a5844>] sock_ioctl
  [<ffffffff>]
unreferenced object 0xf45101ec (size 1828):
  [<c0166bc1>] memleak_alloc
  [<c0164d15>] __kmalloc_track_caller
  [<c02a91cb>] __alloc_skb
  [<f9882439>] FillRxDescriptor
  [<f9882408>] FillRxRing
  [<f9881bdf>] SkGeOpen
  [<c02adcda>] dev_open
  [<c02af332>] dev_change_flags
  [<c02e27dd>] devinet_ioctl
  [<c02e4372>] inet_ioctl
  [<c02a5844>] sock_ioctl
  [<ffffffff>]

The above is probably not a leak but it looks more like badly written
code. It looks like the pointers to the sk_buff structures are stored
in memory allocated by pci_alloc_consistent. Kmemleak doesn't scan
this area as it is usually meant for DMA'ing data and not for holding
pointers kernel structures. I can mark it as not a leak.

Thanks.

-- 
Catalin
