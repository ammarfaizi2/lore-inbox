Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262675AbSI1BWi>; Fri, 27 Sep 2002 21:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262676AbSI1BWi>; Fri, 27 Sep 2002 21:22:38 -0400
Received: from packet.digeo.com ([12.110.80.53]:42384 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262675AbSI1BWd>;
	Fri, 27 Sep 2002 21:22:33 -0400
Message-ID: <3D950590.1F9FBDC6@digeo.com>
Date: Fri, 27 Sep 2002 18:27:44 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>,
       Thomas Molina <tmolina@cox.net>,
       lksctp-developers@lists.sourceforge.net
CC: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: (more) Sleeping function called from illegal context...
References: <20020927233044.GA14234@kroah.com> <3D94EEBF.D6328392@digeo.com> <3D94FB89.40400@easynet.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2002 01:27:44.0732 (UTC) FILETIME=[3EF359C0:01C2668E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luc Van Oostenryck wrote:
> 
> With CONFIG_PREEMPT=y on an SMP AMD (2CPU):
> 
> Sleeping function called from illegal context at slab.c:1374
> f79dbe2c c0117094 c0280b00 c02847cb 0000055e f7817b40 c01328fd c02847cb
>         0000055e f79da000 f7ede980 c03ecc58 f7817b40 c025af91 c18cf248 c0266b3e
>         00000024 000001d0 f79da000 00000286 00000001 bffffc9c c02f63e0 c0266e20
> Call Trace:
>   [<c0117094>]__might_sleep+0x54/0x58
>   [<c01328fd>]kmalloc+0x5d/0x1e0
>   [<c025af91>]fib_add_ifaddr+0x61/0x110
>   [<c0266b3e>]__sctp_get_local_addr_list+0x9e/0x140
>   [<c0266e20>]sctp_netdev_event+0x30/0x60
>   [<c01241ae>]notifier_call_chain+0x1e/0x40
>   [<c02566f5>]inet_insert_ifa+0x1b5/0x1c0
>   [<c02567b4>]inet_set_ifa+0xb4/0xc0
>   [<c0257091>]devinet_ioctl+0x511/0x740
>   [<c0259897>]inet_ioctl+0x157/0x1b0
>   [<c021e276>]sock_ioctl+0x56/0x90
>   [<c0150039>]sys_ioctl+0x289/0x2d8
>   [<c0107d11>]error_code+0x2d/0x38
>   [<c01072cf>]syscall_call+0x7/0xb
> 

sctp_v4_get_local_addr_list():

                /* XXX BUG: sleeping allocation with lock held -DaveM */
                addr = t_new(struct sockaddr_storage_list, GFP_KERNEL);

Is true.  We're holding dev_base_lock, inetdev_lock and in_dev->lock
here.
