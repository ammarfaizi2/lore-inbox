Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVE3VZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVE3VZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVE3VZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:25:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:32393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261786AbVE3VSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 17:18:18 -0400
Date: Mon, 30 May 2005 14:17:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Hand <Steven.Hand@cl.cam.ac.uk>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net, Steven.Hand@cl.cam.ac.uk
Subject: Re: Bug in 2.6.11.11 - udp_poll(), fragments + CONFIG_HIGHMEM
Message-Id: <20050530141714.44879df5.akpm@osdl.org>
In-Reply-To: <E1DclTK-0002qE-00@mta1.cl.cam.ac.uk>
References: <E1DclTK-0002qE-00@mta1.cl.cam.ac.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Hand <Steven.Hand@cl.cam.ac.uk> wrote:
>
> Summary: with CONFIG_HIGHMEM set, net/ipv4/udp.c::udp_poll() 
>           fails when rx'ing an skb with fragments. 
> 
>           Present in [at least] 2.6.11.*, 2.6.10 
> 
> 
>  Details: 
> 
>  User space code polling on a blocking socket fd receives an
>  skb with fragments -- this is very unlikely in the common 
>  case but can happen with encapsulation etc; however its pretty
>  much guaranteed to happen under Xen 2.x when communicating 
>  between dom0 and domU. 
> 
> 
>  Example backtrace from console: 
> 
>   kernel: Badness in local_bh_enable at kernel/softirq.c:140
>   kernel:  [local_bh_enable+130/144] local_bh_enable+0x82/0x90
>   kernel:  [skb_checksum+317/704] skb_checksum+0x13d/0x2c0
>   kernel:  [udp_poll+154/352] udp_poll+0x9a/0x160
>   kernel:  [sock_poll+41/64] sock_poll+0x29/0x40
>   kernel:  [do_pollfd+149/160] do_pollfd+0x95/0xa0
>   kernel:  [do_poll+106/208] do_poll+0x6a/0xd0
>   kernel:  [sys_poll+353/576] sys_poll+0x161/0x240
>   kernel:  [sys_gettimeofday+60/144] sys_gettimeofday+0x3c/0x90
>   kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
>   kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> 

Yes, that still seems to be there:

  udp_poll
  ->spin_lock_irq()
  ->udp_checksum_complete
    ->__udp_checksum_complete
      ->skb_checksum
        ->kmap_skb_frag
          ->local_bh_disable

That local_bh_disable() in kmap_skb_frag() looks weird and might be
unnecessary.  Does anyone know what it's there for?  Replace it with
local_irq_save()?

