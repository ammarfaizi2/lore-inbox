Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSHPCG0>; Thu, 15 Aug 2002 22:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSHPCG0>; Thu, 15 Aug 2002 22:06:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:61613 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317947AbSHPCGY>; Thu, 15 Aug 2002 22:06:24 -0400
Message-ID: <3D5C5F05.7080004@us.ibm.com>
Date: Thu, 15 Aug 2002 19:10:13 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 kmap_atomic copy_*_user benefits
References: <20020815232126.GR15685@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> With and without kmap_atomic() -based copy_*_user() patches from akpm.
> Taken on a 16x/16GB box.

Have you seen any instability with these things applied?  I seem to be 
getting a fair amount of these BUG()s.  But, I imagine that it could 
be a race uncovered because of the serialization that highmem locks 
caused.


kernel BUG at softirq.c:229!
invalid operand: 0000
CPU:    4
EIP:    0060:[<8011c8dd>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 80374f54   ecx: 8037e194   edx: ffffffff
esi: 00000000   edi: f7fba000   ebp: 80357560   esp: f7fbbf38
ds: 0068   es: 0068   ss: 0068
Stack: 00000001 80353960 fffffffe 00000080 8011c62a 80353960 00000000 
8033b800
        00000000 f7fbbf78 00000046 801092e1 f7fba000 80105334 00000000 
802de388
        00000000 80107d28 f7fba000 00000300 f7fba000 80105334 00000000 
00000000
Call Trace: [<8011c62a>] [<801092e1>] [<80105334>] [<80107d28>] 
[<80105334>]
    [<8010535d>] [<801053b3>] [<801180fd>]
Code: 0f 0b e5 00 13 74 27 80 8b 43 10 50 8b 43 0c ff d0 83 c4 04


 >>EIP; 8011c8dd <tasklet_hi_action+5d/c4>   <=====

 >>ebx; 80374f54 <bh_task_vec+14/280>
 >>ecx; 8037e194 <tv1+14/804>
 >>ebp; 80357560 <__bss_start+0/0>

Trace; 8011c62a <do_softirq+5a/ac>
Trace; 801092e1 <do_IRQ+f1/100>
Trace; 80105334 <poll_idle+0/48>
Trace; 80107d28 <common_interrupt+18/20>
Trace; 80105334 <poll_idle+0/48>
Trace; 8010535d <poll_idle+29/48>
Trace; 801053b3 <cpu_idle+37/48>
Trace; 801180fd <printk+125/140>

Code;  8011c8dd <tasklet_hi_action+5d/c4>
00000000 <_EIP>:
Code;  8011c8dd <tasklet_hi_action+5d/c4>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  8011c8df <tasklet_hi_action+5f/c4>
    2:   e5 00                     in     $0x0,%eax
Code;  8011c8e1 <tasklet_hi_action+61/c4>
    4:   13 74 27 80               adc    0xffffff80(%edi,1),%esi
Code;  8011c8e5 <tasklet_hi_action+65/c4>
    8:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  8011c8e8 <tasklet_hi_action+68/c4>
    b:   50                        push   %eax
Code;  8011c8e9 <tasklet_hi_action+69/c4>
    c:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  8011c8ec <tasklet_hi_action+6c/c4>
    f:   ff d0                     call   *%eax
Code;  8011c8ee <tasklet_hi_action+6e/c4>
   11:   83 c4 04                  add    $0x4,%esp


-- 
Dave Hansen
haveblue@us.ibm.com

