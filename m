Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTEYRo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 13:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbTEYRo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 13:44:59 -0400
Received: from web9606.mail.yahoo.com ([216.136.129.185]:18596 "HELO
	web9606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263676AbTEYRo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 13:44:56 -0400
Message-ID: <20030525175806.8879.qmail@web9606.mail.yahoo.com>
Date: Sun, 25 May 2003 10:58:06 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Swapoff w/regular file causes Oops
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Doing some more testing and found that calling swapoff &
passing it a regular file causes a kernel Oops. It should
simply return with EINVAL in errno. I'm using a Red Hat
2.4.20-13.9 kernel and opened RH bugzilla#91603 to document
it. 

The reason I'm contacting the lkml is that there may be
other distributions affected or 2.5 kernel may have this
issue, too. I found the problem using the following
program:

#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>
#include <errno.h>
                                                           
                    
int main(void)
{
    int ret;
                                                           
                    
    if (geteuid() != 0) {
        puts("Must be super/root for this test!");
        return 1;
    }
                                                           
                    
    if (creat("./abcd", S_IRWXU) == 0) {
        printf("Unable to setup abcd");
        return 1;
    }
                                                           
                    
    ret = swapoff("./abcd");
    if (ret == -1 && errno != EINVAL) {
        printf("%d returned instead of EINVAL.\n", errno);
        return 1;
    }
    unlink("./abcd");
    return 0;
}

What I get in my logs is this:
May 25 12:59:58 dds kernel:  <1>Unable to handle kernel
NULL pointer dereference at virtual address 0000026e
May 25 12:59:58 dds kernel:  printing eip:
May 25 12:59:58 dds kernel: c0149985
May 25 12:59:58 dds kernel: *pde = 00000000
May 25 12:59:58 dds kernel: Oops: 0002
May 25 12:59:58 dds kernel: parport_pc lp parport 3c59x
ipv6 ipt_LOG ipt_state iptable_nat ip_conntrack
iptable_filter ip_tables ide-scsi scsi_mod ide-cd cdrom
loop lvm-mod keybdev mouse
May 25 12:59:58 dds kernel: CPU:    0
May 25 12:59:58 dds kernel: EIP:    0060:[<c0149985>]   
Not tainted
May 25 12:59:58 dds kernel: EFLAGS: 00010202
May 25 12:59:58 dds kernel:
May 25 12:59:58 dds kernel: EIP is at path_release [kernel]
0x15 (2.4.20-13.9)
May 25 12:59:58 dds kernel: eax: c1ac6f84   ebx: c2e5ff90  
ecx: ffffffff   edx: 00000246
May 25 12:59:58 dds kernel: esi: 00000002   edi: ffffffea  
ebp: c0c3cbe0   esp: c2e5ff84
May 25 12:59:58 dds kernel: ds: 0068   es: 0068   ss: 0068
May 25 12:59:58 dds kernel: Process sigtest (pid: 1900, 
stackpage=c2e5f000)
May 25 12:59:58 dds kernel: Stack: c037ae88 c013a831
c2e5ff90 c1ac6f84 00000246 00000003 c013f2f0 c1ac6f84
May 25 12:59:58 dds kernel:        cf814000 c2e5e000
00000004 c2e5e000 40012820 bffff624 bffff5c8 c0109103
May 25 12:59:58 dds kernel:        080484e8 000001c0
4014e9a0 40012820 bffff624 bffff5c8 00000073 0000002b
May 25 12:59:58 dds kernel: Call Trace:   [<c013a831>]
sys_swapoff [kernel] 0x191 (0xc2e5ff88))
May 25 12:59:58 dds kernel: [<c013f2f0>] sys_open [kernel]
0x70 (0xc2e5ff9c))
May 25 12:59:58 dds kernel: [<c0109103>] system_call
[kernel] 0x33 (0xc2e5ffc0))
May 25 12:59:58 dds kernel:
May 25 12:59:58 dds kernel:
May 25 12:59:58 dds kernel: Code: ff 4a 28 0f 94 c0 84 c0
75 02 5b c3 89 54 24 08 5b e9 65 c3

CPU is K6-2, fs is ext3 on ide. OS is RH9.

If any more info is needed, let me know. Please try the
program first, though. Hopefully, my machine isn't the only
one doing this.

-Steve Grubb

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
