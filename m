Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319284AbSIFSWO>; Fri, 6 Sep 2002 14:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319308AbSIFSWO>; Fri, 6 Sep 2002 14:22:14 -0400
Received: from ns.suse.de ([213.95.15.193]:9480 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319284AbSIFSWN>;
	Fri, 6 Sep 2002 14:22:13 -0400
Date: Fri, 6 Sep 2002 20:26:46 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
Message-ID: <20020906202646.A2185@wotan.suse.de>
References: <3D78C9BD.5080905@us.ibm.com> <53430559.1031304588@[10.10.2.3]> <3D78E7A5.7050306@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D78E7A5.7050306@us.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> c0106e59 42693    1.89176     restore_all
> c01dfe68 42787    1.89592     sys_socketcall
> c01df39c 54185    2.40097     sys_bind
> c01de698 62740    2.78005     sockfd_lookup
> c01372c8 97886    4.3374      fput
> c022c110 125306   5.55239     __generic_copy_to_user
> c01373b0 181922   8.06109     fget
> c020958c 199054   8.82022     tcp_v4_get_port
> c0106e10 199934   8.85921     system_call
> c022c158 214014   9.48311     __generic_copy_from_user
> c0216ecc 257768   11.4219     inet_bind

The profile looks bogus. The NIC driver is nowhere in sight. Normally
its mmap IO for interrupts and device registers should show. I would
double check it (e.g. with normal profile) 

In case it is no bogus: 
Most of these are either atomic_inc/dec of reference counters or some
form of lock. The system_call could be the int 0x80 (using the SYSENTER
patches would help), which also does atomic operations implicitely.
restore_all is IRET, could also likely be speed up by using SYSEXIT.

If NAPI hurts here then it surely not because of eating CPU time.

-Andi
