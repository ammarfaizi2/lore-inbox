Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319258AbSIFRc4>; Fri, 6 Sep 2002 13:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319296AbSIFRcz>; Fri, 6 Sep 2002 13:32:55 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:3019 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319258AbSIFRcx>;
	Fri, 6 Sep 2002 13:32:53 -0400
Message-ID: <3D78E7A5.7050306@us.ibm.com>
Date: Fri, 06 Sep 2002 10:36:37 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020822
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <3D78C9BD.5080905@us.ibm.com> <53430559.1031304588@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>Something strange happens to the clients when NAPI is enabled on 
>>the Specweb clients.  Somehow the start using a lot more CPU.  
>>The increased idle time on the server is because the _clients_ are 
>>CPU maxed.  I have some preliminary oprofile data for the clients, 
>>but it appears that this is another case of Specweb code just 
>>really sucking.
> 
> Hmmm ... if you change something on the server, and all the clients
> go wild, I'm suspicious of whatever you did to the server.

Me too :)  All that was changed was adding the new e1000 driver.  NAPI was 
disabled.

 > You need
> to have a lot more data before leaping to the conclusion that it's
> because the specweb client code is crap.

I'll let the profile speak for itself...

oprofile summary:op_time -d

1          0.0000 0.0000 /bin/sleep
2          0.0001 0.0000 /lib/ld-2.2.5.so.dpkg-new (deleted)
2          0.0001 0.0000 /lib/libpthread-0.9.so
2          0.0001 0.0000 /usr/bin/expr
3          0.0001 0.0000 /sbin/init
4          0.0001 0.0000 /lib/libproc.so.2.0.7
12         0.0004 0.0000 /lib/libc-2.2.5.so.dpkg-new (deleted)
17         0.0005 0.0000 /usr/lib/libcrypto.so.0.9.6.dpkg-new (deleted)
20         0.0006 0.0000 /bin/bash
30         0.0010 0.0000 /usr/sbin/sshd
151        0.0048 0.0000 /usr/bin/vmstat
169        0.0054 0.0000 /lib/ld-2.2.5.so
300        0.0095 0.0000 /lib/modules/2.4.18+O1/oprofile/oprofile.o
1115       0.0354 0.0000 /usr/local/bin/oprofiled
3738       0.1186 0.0000 /lib/libnss_files-2.2.5.so
58181      1.8458 0.0000 /lib/modules/2.4.18+O1/kernel/drivers/net/acenic.o
249186     7.9056 0.0000 /home/dave/specweb99/build/client
582281    18.4733 0.0000 /lib/libc-2.2.5.so
2256792   71.5986 0.0000 /usr/src/linux/vmlinux

top of oprofile from the client:
08051b3c 2260     0.948938    check_for_timeliness
08051cfc 2716     1.14041     ascii_cat
08050f24 4547     1.90921     HTTPGetReply
0804f138 4682     1.9659      workload_op
08050890 6111     2.56591     HTTPDoConnect
08049a30 7330     3.07775     SHMmalloc
08052244 7433     3.121       HTParse
08052628 8482     3.56146     HTSACopy
08051d88 10288    4.31977     get_some_line
08052150 13070    5.48788     scan
08051a10 65314    27.4243     assign_port_number
0804bd30 83789    35.1817     LOG
#define LOG(x) do {} while(0)
Voila! 35% more CPU!

Top of Kernel profile:
c022c850 33085    1.46602     number
c0106e59 42693    1.89176     restore_all
c01dfe68 42787    1.89592     sys_socketcall
c01df39c 54185    2.40097     sys_bind
c01de698 62740    2.78005     sockfd_lookup
c01372c8 97886    4.3374      fput
c022c110 125306   5.55239     __generic_copy_to_user
c01373b0 181922   8.06109     fget
c020958c 199054   8.82022     tcp_v4_get_port
c0106e10 199934   8.85921     system_call
c022c158 214014   9.48311     __generic_copy_from_user
c0216ecc 257768   11.4219     inet_bind

"oprofpp -k -dl -i /lib/libc-2.2.5.so"
just gives:
vma      samples %-age symbol name  linenr info                 image name
00000000 582281  100   (no symbol)  (no location information) 
/lib/libc-2.2.5.so

I've never really tried to profile anything but the kernel before.  Any ideas?

> Troy - I think your UP clients weren't anywhere near maxed out on 
> CPU power, right? Can you take a peek at the clients under NAPI load?

Make sure you wait a minute or two.  The client tends to ramp up.

"vmstat 2" after the client has told the master that it is running:
  U   S   I
----------
  4  15  81
  5  17  79
  7  16  77
  7  17  76
  7  21  72
11  25  64
  3  16  82
  2  14  84
  7  23  70
16  50  34
24  75   0
27  73   0
28  72   0
24  76   0
...

> Dave - did you ever try running 4 specweb clients bound to each of
> the 4 CPUs in an attempt to make the clients scale better? I'm 
> suspicious that you're maxing out 4 4-way machines, and Troy's
> 16 UPs are cruising along just fine.

No, but I'm not sure it will do any good.  They don't run often enough and 
I have the feeling that there are very few cache locality benefits to be had.

-- 
Dave Hansen
haveblue@us.ibm.com

