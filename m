Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVCNKhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVCNKhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVCNKhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:37:43 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:42152 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262115AbVCNKhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:37:22 -0500
Message-ID: <4235695F.5070203@cosmosbay.com>
Date: Mon, 14 Mar 2005 11:37:19 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [BUG?] x86_64 : Can not read /dev/kmem ?
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz>	<4234A8DD.9080305@aknet.ru>	<Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>	<Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org>	<423518A7.9030704@aknet.ru> <m14qfey3iz.fsf@muc.de>
In-Reply-To: <m14qfey3iz.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 14 Mar 2005 11:37:14 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andi

I tried to read /dev/kmem on x86_64 (linux-2.6.11) and got no success.

read() or pread() returns EINVAL

I tried mmap() too : mmap() calls succeed, but as soon the user process 
dereference memory, we get :

tinfo: Corrupted page table at address 2aaaaaabf800
PGD 8a983067 PUD c7e5a067 PMD 91588067 PTE ffffffff8048a025
Bad pagetable: 000d [1] SMP
CPU 0
Modules linked in: ipt_REJECT
Pid: 10892, comm: tinfo Not tainted 2.6.11
RIP: 0033:[<0000000000100562>] [<0000000000100562>]
RSP: 002b:00007ffffffff790  EFLAGS: 00010217
RAX: 00002aaaaaabf000 RBX: 00002aaaaabbe000 RCX: 00002aaaaac8fc0c
RDX: 0000000000000001 RSI: 0000000000001000 RDI: 0000000000000000
RBP: 00007ffffffff7f8 R08: 0000000000000003 R09: ffffffff8048a000
R10: 0000000000000001 R11: 0000000000000206 R12: 00000000001005b0
R13: 0000000000000001 R14: 00002aaaaadfdfe8 R15: 0000000000100530
FS:  00002aaaaabcb970(0000) GS:ffffffff804866c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaaabf800 CR3: 0000000090368000 CR4: 00000000000006e0
Process tinfo (pid: 10892, threadinfo ffff8100901b0000, task 
ffff8100c7d976c0)

RIP [<0000000000100562>] RSP <00007ffffffff790>



Thank you

Eric Dumazet
----------------------------------------------------------------
# cat tinfo.c

#define _XOPEN_SOURCE 500
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>

struct tcp_hashinfo {
         struct tcp_ehash_bucket *__tcp_ehash;
         struct tcp_bind_hashbucket *__tcp_bhash;

         int __tcp_bhash_size;
         int __tcp_ehash_size;

} tcp_hashinfo;

#define TCPINFO_ADDR 0xffffffff8048a000 /* tcp_hashinfo */

int main()
{
int fd = open("/dev/kmem", O_RDONLY) ;


if (pread(fd, &tcp_hashinfo, sizeof(tcp_hashinfo), TCPINFO_ADDR) == -1) {
         lseek(fd, TCPINFO_ADDR, 0) ;
         if (read(fd, &tcp_hashinfo, sizeof(tcp_hashinfo)) == -1) {
                 perror("Can not read /dev/kmem ?") ;
                 return 1 ;
                 }
         }
printf("ehash=%p esize=%d bhash=%p bsize=%d\n",
         tcp_hashinfo.__tcp_ehash,
         tcp_hashinfo.__tcp_ehash_size,
         tcp_hashinfo.__tcp_bhash,
         tcp_hashinfo.__tcp_bhash_size) ;
return 0 ;
}
