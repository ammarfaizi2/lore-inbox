Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136466AbRD3HPr>; Mon, 30 Apr 2001 03:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136467AbRD3HPg>; Mon, 30 Apr 2001 03:15:36 -0400
Received: from elin.scali.no ([195.139.250.10]:14609 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S136466AbRD3HPc>;
	Mon, 30 Apr 2001 03:15:32 -0400
Message-ID: <3AED12A4.FA869E84@scali.no>
Date: Mon, 30 Apr 2001 02:22:12 -0500
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17-16enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "nfs@lists.sourceforge.net" <nfs@lists.sourceforge.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Kernel crash using NFSv3 on 2.4.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have compiled a stock 2.4.4 kernel and applied SGI's kdb patch v1.8. Most of
the time this runs just fine, but one time when I tried to copy a file from a
NFS server I got a kernel fault. Luckily it jumped right into the debugger and
I could to some batcktracing (quite useful!) :

Unable to handle kernel paging request at virtual address 414478b1
 printing eip:
c012c826
*pde = 00000000

Entering kdb (current=0xca07a000, pid 971) on processor 0 Oops: Oops
due to oops @ 0xc012c826
eax = 0x20000000 ebx = 0xc15e4800 ecx = 0x00000000 edx = 0xc1447899
esi = 0x00000000 edi = 0xc14477a0 esp = 0xca07ba98 eip = 0xc012c826
ebp = 0xca07baa4 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010046
xds = 0xc1440018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xca07ba64
[0]kdb> bt
    EBP       EIP         Function(args)
0xca07baa4 0xc012c826 kmem_cache_alloc_batch+0x46 (0xc14477a0, 0x7, 0xcb965260)
                               kernel .text 0xc0100000 0xc012c7e0 0xc012c864
0xca07bad0 0xc012ca8e kmalloc+0x82 (0x13c, 0x7, 0xca4ca040, 0x0)
                               kernel .text 0xc0100000 0xc012ca0c 0xc012cb1c
0xca07baf4 0xc01fd254 alloc_skb+0x104 (0x100, 0x7)
                               kernel .text 0xc0100000 0xc01fd150 0xc01fd31c
0xca07bb14 0xc01fc85c sock_alloc_send_skb+0x68 (0xca4ca040, 0xe7, 0x40,
0xca07bb44)
                               kernel .text 0xc0100000 0xc01fc7f4 0xc01fc8f8
0xca07bb48 0xc020ff58 ip_build_xmit+0xe8 (0xca4ca040, 0xc022834c, 0xca07bbac,
0xc8, 0xca07bbc4)
                               kernel .text 0xc0100000 0xc020fe70 0xc02101cc
0xca07bbd0 0xc022879c udp_sendmsg+0x344 (0xca4ca040, 0xca07bcc0, 0xac)
                               kernel .text 0xc0100000 0xc0228458 0xc0228824
0xca07bbe8 0xc022e494 inet_sendmsg+0x40 (0xca1a2d08, 0xca07bcc0, 0xac,
0xca07bc18, 0xc0000000)
                               kernel .text 0xc0100000 0xc022e454 0xc022e49c
0xca07bc2c 0xc01fa27e sock_sendmsg+0x7a (0xca1a2d08, 0xca07bcc0, 0xac)
                               kernel .text 0xc0100000 0xc01fa204 0xc01fa2a0
0xca07bcdc 0xd089c9e4 [sunrpc]do_xprt_transmit+0x158 (0xca07bd70)
                               sunrpc .text 0xd089a060 0xd089c88c 0xd089ccc0
0xca07bcf4 0xd089c87f [sunrpc]xprt_transmit+0xa3 (0xca07bd70)
                               sunrpc .text 0xd089a060 0xd089c7dc 0xd089c88c
0xca07bd08 0xd089aa43 [sunrpc]call_transmit+0x43 (0xca07bd70)
[0]more>   
                               sunrpc .text 0xd089a060 0xd089aa00 0xd089aa6c
0xca07bd38 0xd089e1de [sunrpc]__rpc_execute+0xa6 (0xca07bd70, 0x0)
                               sunrpc .text 0xd089a060 0xd089e138 0xd089e3ec
0xca07bd4c 0xd089e448 [sunrpc]rpc_execute_Rsmp_cbcaa361+0x5c (0xca07bd70,
0xca07be2c)
                               sunrpc .text 0xd089a060 0xd089e3ec 0xd089e464
0xca07bdf8 0xd089a493 [sunrpc]rpc_call_sync_Rsmp_1a543287+0x73 (0xcb6f09a0,
0xca07be34, 0x0, 0xca07a000)
                               sunrpc .text 0xd089a060 0xd089a420 0xd089a4c0
0xca07beb0 0xd09524e4 [nfs]nfs3_proc_access+0x108 (0xca1fc600, 0x1, 0x0)
                               nfs .text 0xd0948060 0xd09523dc 0xd0952534
0xca07bed8 0xd094f739 [nfs]nfs_permission+0x8d (0xca1fc600, 0x1)
                               nfs .text 0xd0948060 0xd094f6ac 0xd094f7b0
0xca07bef4 0xc01407db permission+0x4b (0xca1fc600, 0x1)
                               kernel .text 0xc0100000 0xc0140790 0xc0140828
0xca07bf28 0xc0141488 path_walk+0x898 (0xcfdb401b, 0xca07bf7c)
                               kernel .text 0xc0100000 0xc0140bf0 0xc01414b0
0xca07bf58 0xc0141ba6 open_namei+0x8a (0xcfdb4000, 0x8001, 0x0, 0xca07bf7c)
                               kernel .text 0xc0100000 0xc0141b1c 0xc0142100
0xca07bf98 0xc0134fda filp_open+0x3a (0xcfdb4000, 0x8000, 0x0)
                               kernel .text 0xc0100000 0xc0134fa0 0xc0134ffc
0xca07bfbc 0xc01352fe sys_open+0x42 (0xbffffc18, 0x8000, 0x0, 0x2, 0xbffffc55)
                               kernel .text 0xc0100000 0xc01352bc 0xc01353bc
           0xc0106ea7 system_call+0x33
                               kernel .text 0xc0100000 0xc0106e74 0xc0106eac
[0]more>

-- 
 Steffen Persvold                        Systems Engineer
 Email  : mailto:sp@scali.com            Scali AS (http://www.scali.com)
 Norway : Tel  : (+47) 2262 8950         Olaf Helsets vei 6
          Fax  : (+47) 2262 8951         N-0621 Oslo, Norway

 USA    : Tel  : (+1) 713 706 0544       10500 Richmond Avenue, Suite 190
                                         Houston, Texas 77042, USA
