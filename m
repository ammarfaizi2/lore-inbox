Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVATUyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVATUyj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVATUyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:54:39 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:29140 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261907AbVATUy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:54:26 -0500
Message-ID: <41F01A50.1040109@cosmosbay.com>
Date: Thu, 20 Jan 2005 21:53:36 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
CC: Chris Bruner <cryst@golden.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Matt Domsch <Matt_Domsch@dell.com>
Subject: Something very strange on x86_64 2.6.X kernels
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org> <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de>
In-Reply-To: <20050120164829.GG450@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi

I have very strange coredumps happening on a big 64bits program.

Some background :
- This program is multi-threaded
- Machine is a dual Opteron 248 machine, 12GB ram.
- Kernel 2.6.6  (tried 2.6.10 too but problems too)
- The program uses hugetlb pages.
- The program uses prefetchnta
- The program uses about 8GB of ram.

After numerous differents core dumps of this program, and gdb debugging 
I found :

Every time the crash occurs when one thread is using some ram located at 
virtual address 0xffffe6xx

When examining the core image, the data saved on this page seems correct 
(ie countains coherent user data). But one register (%rbx) is usually 
corrupted and contains a small value (like 0x3c)

The last instruction using this register is :
	prefetchnta 0x18(,%rbx,4)


Examining linux sources, I found that 0xffffe000 is 'special' (ia 32 
vsyscall) and 0xffffe600 is about sigreturn subsection of this special area.

Is it possible some vm trick just kicks in and corrupts my true 64bits 
program ?

Thank you
Eric Dumazet
