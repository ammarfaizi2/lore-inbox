Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTHZEqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 00:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbTHZEqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 00:46:13 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:50925 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S262610AbTHZEqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 00:46:08 -0400
Date: Mon, 25 Aug 2003 22:14:12 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Marcel Sebek <sebek64@post.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] less /proc/net/igmp
In-Reply-To: <20030825163206.GA1340@penguin.penguin>
Message-ID: <Pine.LNX.4.44.0308252204270.31393-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,
	 I don't have the kernel, I didn't try it also, but I have faced 
a similar problem sometimes back so I feel that it might be the same 
problem. I have posted a similar question sometimes back on this list.
If you do an strace of both 'cat' and 'less' you will see that 'cat' does 
not maintain the offset into the file in the application. It just believes 
that subsequent reads will give data after the point it has read, 'less'( 
as well as brother 'more') 
on the other hand does an lseek(fd, last_read_return_value, SEEK_SET) 
after every read, then it issues a read call. 
Now if you see proc_file_read() in the kernel source, you will see that to 
support proc files which are more than PAGE_SIZE long, they have a hack 
that it allows the caller to interpret the offset not as byte offsets but 
as anything, mostly number of records read ..
I feel ur /proc/net/igmp file is more than a PAGE_SIZE long, because that 
is when this problem is more likely to happen, but it can happen otherwise 
also if things are not handled properly.
The problem is probably in  the proc_read function of /proc/net/igmp

Thanx
tomar




 On Mon, 25 Aug 2003, Marcel Sebek wrote:

> This Oops appears on 2.5.74+ kernels (including 2.6.0-test4) when
> I'm trying to read /proc/net/igmp with 'less', 'cat' displays
> the file content without oops:
> 
> LILO boot: linux init=/bin/bash
>  ...
> [snip]
>  ...
> bash# mount /proc
> bash# cat /proc/net/igmp
> Idx	Device    : Count Querier	Group    Users Timer	Reporter
> bash# less /proc/net/igmp
> Idx	Device    : Count Querier	Group    Users Timer	Reporter
> bash# ifup -a
> bash# cat /proc/net/igmp
> Idx	Device    : Count Querier	Group    Users Timer	Reporter
> 1	lo        :     0      V2
> 				010000E0     1 0:FFFA22F0
> 0
> bash# less /proc/net/igmp
> Unable to handle kernel paging request at virtual address 08051be0
>  printing eip:
> 08051be0
> *pde = 0fb66067
> *pfe = 00000000
> Oops: 0004 [#1]
> CPU:    0
> EIP:    0073:[<08051be0>]    Not tainted
> EFLAGS: 00010246
> EIP is at 0x8051be0
> eax: 0805fb68   ebx: 00000001   ecx: 00000000   edx: 00000019
> esi: 08060649   edi: 08057543   ebp: bffffd8c   esp: bfffda50
> ds: 007b   es: 007b   ss: 007b
> Process less (pid 20, threadinfo = cfab6000 task = c13560cd)
>  <0>Kernel panic: Fatal exception in interrupt
> In interrupt handler - not syncing
> 
> 
> EIP points to the begin of the function clr_linenum() in
> less-374/linenum.c:78 (instruction 'push %ebp').
> 
> Kernel is compiled by gcc-2.95.4 (20011002) from Debian woody.
> Less is from woody and also from the original sources.
> 
> 
> 

