Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbTCTQLk>; Thu, 20 Mar 2003 11:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261575AbTCTQLk>; Thu, 20 Mar 2003 11:11:40 -0500
Received: from navigator.sw.com.sg ([213.247.162.11]:45463 "EHLO
	navigator.sw.com.sg") by vger.kernel.org with ESMTP
	id <S261568AbTCTQLI>; Thu, 20 Mar 2003 11:11:08 -0500
From: Vladimir Serov <vserov@infratel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Message-ID: <3E79EAA8.4000907@infratel.com>
Date: Thu, 20 Mar 2003 19:22:00 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
References: <20030318155731.1f60a55a.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello Trond, hello all,

I'm suffering from the long present bug in the nfs client.
This bug cause programs reading from NFS volume to stuck in D state forever.
This bug revealed only when client talks to NFS server with 3COM 3C905 
NIC's ( well I'v triggered it with Intel eepro card too, but you have to 
wait) and never with cheap slower cards like RTLxxxx, NE2000 clones. It 
happens infrequently but inevitably. It happens more frequentlly on 
2.4.17 kernel then on 2.4.21-pre5, when compiled by gcc 3.2.1 then gcc 
2.95.3. Trond's NFS patches doesn't help on both kernels. It's not due 
to packets loss (ok, it happens some times but rarely), it happens on 
both 10 and 100 Mbps. This happens only on my StrongARM board (similar 
to Brutus) with SMC's LAN91C111 ethernet chip. I 've not able to 
reproduce this on PC, but i've head about very similar case:  
http://www.uwsg.iu.edu/hypermail/linux/kernel/0206.0/0066.html
It triggered simply by 'ls -lR /home>/dev/null&' and takes ~ half a 
minute to happend.
If i insert a few printk's in the interrupt handler for NIC, it's gone !!!
IMHO this is due to the race in the nfs client.

Look at some logs from my system:

sh-2.03# mount
rootfs on / type rootfs (rw)
/dev/mtdblock4 on / type jffs2 (rw)
none on /proc type proc (rw)
none on /tmp type tmpfs (rw)
none on /dev/pts type devpts (rw)
infracvs:/group on /group type nfs 
(rw,v2,rsize=4096,wsize=4096,soft,intr,udp,lock,addr=infracvs)
serov:/home on /home type nfs 
(rw,v3,rsize=4096,wsize=4096,soft,intr,udp,lock,addr=serov)

sh-2.03# ps
  PID  Uid     Stat Command
    1 root     S    init
    2 root     S    [keventd]
    3 root     S    [ksoftirqd_CPU0]
    4 root     S    [kswapd]
    5 root     S    [bdflush]
    6 root     S    [kupdated]
    7 root     S    [mtdblockd]
    8 root     S    [jffs2_gcd_mtd4]
  102 root     S    dhcpcd
  111 bin      S    portmap
  113 root     S    [rpciod]
  114 root     S    [lockd]
  124 root     S    klogd
  138 root     S    /usr/sbin/inetd
  143 root     S    /www/sbin/sshd -f /www/etc/sshd_config
  152 root     S    init
  153 root     S    sh -login -i
  158 root     D    ls -lR /home
  159 root     D    ls -lR /home
  179 root     D    ls -lR /home
  183 root     R    ps

Part of output from Magic SysRq t with decoded symbols:

ls            D C001EB8C  3216   165    153                     (NOTLB)
Function entered at [<c001e990>] from [<c0109b14>]
                      schedule          __rpc_execute

I've used /proc/sys/sunrpc/rpc_debug and /proc/sys/sunrpc/nfs_debug to 
get some info, it was nothing interesting in it exept the fact that rpc 
request wich was constantly reused after 'ls' stuck is appeared inthe 
following message in the --rqstp- column.
sh-2.03# echo 1 > /proc/sys/sunrpc/rpc_debug
sh-2.03# dmesg -c -s 66666
-pid- proc flgs status -client- -prog- --rqstp- -timeout -rpcwait 
-action- --exit--
20429 0001 0000 000000 c0eda960 100003 c8f89218 00000000  <NULL>  
c0105d5c        0
10052 0001 0000 000000 c0eda960 100003 c8f8918c 00000000  <NULL>  
c0105d5c        0
06851 0001 0000 000000 c0eda960 100003 c8f89100 00000000  <NULL>  
c0105d5c        0
00673 0004 0000 000000 c0eda960 100003 c8f89074 00000000  <NULL>  
c0105d5c        0
00368 0000 0081 -00110 c0eda960 100003        0 00003000 nfs_flushd 
c006e290 c006e3c8
00002 0000 0081 -00110 c0e310a0 100003        0 00003000 nfs_flushd 
c006e290 c006e3c8

c006e290 t nfs_flushd
c006e3c8 t nfs_flushd_exit
c0105d5c t call_status


