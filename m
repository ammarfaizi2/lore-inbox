Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315617AbSEIFXI>; Thu, 9 May 2002 01:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315618AbSEIFXH>; Thu, 9 May 2002 01:23:07 -0400
Received: from relay1.pair.com ([209.68.1.20]:43781 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S315617AbSEIFXG>;
	Thu, 9 May 2002 01:23:06 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CDA0876.218285C7@kegel.com>
Date: Wed, 08 May 2002 22:26:14 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ken Brownfield <ken@irridia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "khttpd-users@lists.alt.org" <khttpd-users@alt.org>
Subject: Re: khttpd newbie problem
In-Reply-To: <3CD402D2.E3A94CA2@kegel.com> <20020505005439.GA12430@krispykreme> <3CD4C93D.E543B188@kegel.com> <20020508222119.A12672@asooo.flowerfire.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Brownfield wrote:
> khttpd is very much production quality on IA32, and has been since
> 2.4.0-test1. 

It oopses readily on start/stop -- see 
http://marc.theaimsgroup.com/?l=linux-kernel&m=102068445316516&w=2
in which DecodeHeader is called with no buffer allocated.
Happened quite frequently during my tests.  Since my patch I
can't get it to oops on x86, but it's still oopsing on ppc405.
So perhaps now it's production quality... but it still needs
a bit too much babying on stop.  (It'd be fairly easy to fix
the unreliable way it senses the stop command.)

> TUX2 is not, however, since under load it enters a 99% CPU
> busy loop.

I checked the tux list and found the post you're taling about:
http://marc.theaimsgroup.com/?l=tux-list&m=101420257421009&w=2
Hmm.  Well, at least it doesn't oops :-)  Thanks for the warning.

> | I'm on an embedded system, so if tux is much larger, I'll
> | be annoyed; but the system does have 64 MB, so it's not *that*
> | cramped.  And working is much better than crashing.
> 
> khttpd is extremely dependent on alignment and data sizes -- the
> filename extension handling is deeply unfunny* for example.  khttpd most
> likely has a problem with PPC (endian, etc).  Are you applying any other
> patches that could conflict?

We're running fairly vanilla linuxppc_2_4_devel.  It worked
quite well with 2.4.2 from Montavista, but developed
stability problems when we moved to 2.4.17 (and now 2.4.19-pre8).

I'm trying to put together a minimal test case that shows the crash.
Here's the script I run that does it reliably:
#!/bin/msh
echo 1 > /proc/sys/net/khttpd/threads
echo `pwd` > /proc/sys/net/khttpd/documentroot
echo 80 > /proc/sys/net/khttpd/serverport
echo 8000 > /proc/sys/net/khttpd/maxconnect
while /bin/true; do
    echo 1 > /proc/sys/net/khttpd/start
    ./foo_load duration=7
    echo 1 > /proc/sys/net/khttpd/stop
    sleep 1
done

where foo_load is a hacked version of http_load (I think)
which is fetching a single 128KB file over and over.
I tried reproducing this with acme.com's http_load, 
without success so far.

In the 'aw, for what it's worth' category, here are some
of the oopses I've seen on the ppc with 2.4.19-pre8 from the
linuxppc_2_4_devel tree plus the bare minimum patches needed
to run on our board. 

With sleep of 1 second, I usually see the crash in foo_load:

>>???; c00b0c3c <tcp_v4_search_req+48/c8>   <=====
Trace; c0084488 <kfree_skbmem+20/94>
Trace; c00b21a4 <tcp_v4_hnd_req+38/1e0>
Trace; c00b250c <tcp_v4_do_rcv+b8/16c>
Trace; c00b2a6c <tcp_v4_rcv+4ac/778>
Trace; c00973c0 <ip_local_deliver+f0/1ac>
Trace; c0097840 <ip_rcv+3c4/470>
Trace; c0088f48 <net_rx_action+204/334>
Trace; c00199b4 <do_softirq+88/100>
Trace; c00887ec <dev_queue_xmit+248/334>
Trace; c009a168 <ip_output+110/174>
Trace; c009a5c0 <ip_queue_xmit+3f4/56c>
Trace; c00ab298 <tcp_transmit_skb+528/614>
Trace; c00adce4 <tcp_connect+458/518>
Trace; c00b0b28 <tcp_v4_connect+340/40c>
Trace; c00bf2d8 <inet_stream_connect+120/2b8>
Trace; c00818e8 <sys_connect+68/8c>
Trace; c0082378 <sys_socketcall+f0/1e0>
Trace; c00060dc <ret_from_syscall_1+0/b4>

Here a backtrace with sleep=2 seconds, inside khttpd:

>>???; c002ea5c <kmem_cache_alloc+b4/170>   <=====
Trace; 00000300 Before first symbol
Trace; c0083c3c <alloc_skb+110/204>
Trace; c009f00c <tcp_sendmsg+1f8/122c>
Trace; c00befd8 <inet_sendmsg+5c/70>
Trace; c008058c <sock_sendmsg+9c/cc>
Trace; c800e520 <END_OF_CODE+7eedd10/???
Trace; c800dcf4 <END_OF_CODE+7eed4e4/???
Trace; c800d268 <END_OF_CODE+7eeca58/???
Trace; c00088f8 <kernel_thread+2c/38>

A backtrace with sleep=3 seconds, in foo_load:

>>???; c0049448 <poll_freewait+28/70>   <=====
Trace; c0031614 <__free_pages+38/48>
Trace; c004a230 <sys_poll+340/360>
Trace; c00060dc <ret_from_syscall_1+0/b4>

A backtrace with sleep=3 seconds, in khttpd:
>>???; c002ebf8 <kmalloc+e0/1b0>   <=====
Trace; c0bdad18 <END_OF_CODE+aba508/???
Trace; c0083c58 <alloc_skb+12c/204>
Trace; c00ad8fc <tcp_send_ack+2c/11c>
Trace; c00ae638 <tcp_delack_timer+1c4/230>
Trace; c001e52c <timer_bh+2c8/420>
Trace; c0019eb4 <bh_action+3c/84>
Trace; c0019d74 <tasklet_hi_action+a0/e0>
Trace; c00199b4 <do_softirq+88/100>
Trace; c0007c48 <timer_interrupt+244/25c>
Trace; c0006310 <ret_from_intercept+0/8>
Trace; c0034c50 <shmem_getpage+a0/118>
Trace; c0035488 <do_shmem_file_read+94/14c>
Trace; c00355a0 <shmem_file_read+60/98>
Trace; c800dcd8 <END_OF_CODE+7eed4c8/???
Trace; c800d268 <END_OF_CODE+7eeca58/???
Trace; c00088f8 <kernel_thread+2c/38>

Yukky.  Makes me want to go work with user-mode web servers instead.

- Dan
