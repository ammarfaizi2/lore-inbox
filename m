Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319345AbSIFTOu>; Fri, 6 Sep 2002 15:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319343AbSIFTOu>; Fri, 6 Sep 2002 15:14:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39400 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319341AbSIFTOs>; Fri, 6 Sep 2002 15:14:48 -0400
Message-ID: <1031339954.3d78ffb257d22@imap.linux.ibm.com>
Date: Fri,  6 Sep 2002 12:19:14 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <3D78C9BD.5080905@us.ibm.com> <53430559.1031304588@[10.10.2.3]> <3D78E7A5.7050306@us.ibm.com> <20020906202646.A2185@wotan.suse.de>
In-Reply-To: <20020906202646.A2185@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.47.18.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andi Kleen <ak@suse.de>:

> > c0106e59 42693    1.89176     restore_all
> > c01dfe68 42787    1.89592     sys_socketcall
> > c01df39c 54185    2.40097     sys_bind
> > c01de698 62740    2.78005     sockfd_lookup
> > c01372c8 97886    4.3374      fput
> > c022c110 125306   5.55239     __generic_copy_to_user
> > c01373b0 181922   8.06109     fget
> > c020958c 199054   8.82022     tcp_v4_get_port
> > c0106e10 199934   8.85921     system_call
> > c022c158 214014   9.48311     __generic_copy_from_user
> > c0216ecc 257768   11.4219     inet_bind
> 
> The profile looks bogus. The NIC driver is nowhere in sight.
> Normally its mmap IO for interrupts and device registers 
> should show. I would double check it (e.g. with normal profile)
Separately compiled acenic..

I'm surprised by this profile a bit too - on the client side,
since the requests are small, and the client is receiving
all those files, I would have thought that __generic_copy_to_user
would have been way higher than *from_user.

inet_bind() and tcp_v4_get_port() are up there because
we have to grab the socket lock, the tcp_portalloc_lock,
then the head chain lock and traverse the hash table
which has now many hundred entries. Also, because
of the varied length of the connections, the clients
get freed not in the same order they are allocated
a port, hence the fragmentation of the port space..
Tthere is some cacheline thrashing hurting the NUMA 
more than other systems here too..

If you just wanted to speed things up, you could get the
clients to specify ports instead of letting the kernel
cycle through for a free port..:)

thanks,
Nivedita

> In case it is no bogus: 
> Most of these are either atomic_inc/dec of reference counters or
> some form of lock. The system_call could be the int 0x80 (using the
> SYSENTER patches would help), which also does atomic operations
> implicitely. restore_all is IRET, could also likely be speed up by
> using SYSEXIT.
> 
> If NAPI hurts here then it surely not because of eating CPU time.
> 
> -Andi
> 
> 




