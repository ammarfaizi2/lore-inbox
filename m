Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUDSU6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUDSU6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUDSU6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:58:03 -0400
Received: from terminus.zytor.com ([63.209.29.3]:30928 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261879AbUDSU54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:57:56 -0400
Message-ID: <40843D3C.8090409@zytor.com>
Date: Mon, 19 Apr 2004 13:57:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Bjoern Schmidt <lucky21@uni-paderborn.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] in 2.6.5 at msr.c and cpuid.c
References: <40842288.3090501@uni-paderborn.de>
In-Reply-To: <40842288.3090501@uni-paderborn.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is pretty interesting... whomever changed cpuid.c/msr.c to the new
cpu_online() macro missed the fact that cpu_online() doesn't handle
out-of-range numbers (on SMP it'll return garbage, on UP it will BUG);
it still doesn't change the fact that it shouldn't have been there in
the first place...

Bjoern Schmidt wrote:
> 
> Apr 18 15:05:51 kilobyte kernel: ------------[ cut here ]------------
> Apr 18 15:05:51 kilobyte kernel: kernel BUG at arch/i386/kernel/msr.c:244!
> Apr 18 15:05:51 kilobyte kernel: invalid operand: 0000 [#1]
> Apr 18 15:05:51 kilobyte kernel: PREEMPT
> Apr 18 15:05:51 kilobyte kernel: CPU:    0
> Apr 18 15:05:51 kilobyte kernel: EIP:    0060:[<c0115482>]    Not tainted
> Apr 18 15:05:51 kilobyte kernel: EFLAGS: 00010202   (2.6.5)
> Apr 18 15:05:51 kilobyte kernel: EIP is at msr_open+0x32/0x40
> Apr 18 15:05:51 kilobyte kernel: eax: c035fae0   ebx: c7d64000   ecx:
> c9dfbc9c   edx: 00000001
> Apr 18 15:05:51 kilobyte kernel: esi: c9dfbc60   edi: 00000000   ebp:
> c0115450   esp: c7d65f18
> Apr 18 15:05:51 kilobyte kernel: ds: 007b   es: 007b   ss: 0068
> Apr 18 15:05:51 kilobyte kernel: Process smbd (pid: 17921,
> threadinfo=c7d64000 task=c8a8a6c0)
> Apr 18 15:05:51 kilobyte kernel: Stack: c01595a2 c3866ad4 c326c0c0
> c7d65f28 00000001 c326c0c0 c3866ad4 00000001
> Apr 18 15:05:51 kilobyte kernel: c9fec1e0 c014f680 c3866ad4 c326c0c0
> 404c88d7 00008000 00008000 c4d40000
> Apr 18 15:05:51 kilobyte kernel: c7d64000 c014f528 c269a160 c9fec1e0
> 00008000 c7d65f70 c269a160 c9fec1e0
> Apr 18 15:05:51 kilobyte kernel: Call Trace:
> Apr 18 15:05:51 kilobyte kernel: [<c01595a2>] chrdev_open+0xf2/0x220
> Apr 18 15:05:51 kilobyte kernel: [<c014f680>] dentry_open+0x150/0x210
> Apr 18 15:05:51 kilobyte kernel: [<c014f528>] filp_open+0x68/0x70
> Apr 18 15:05:51 kilobyte kernel: [<c014f9cb>] sys_open+0x5b/0x90
> Apr 18 15:05:51 kilobyte kernel: [<c0107319>] sysenter_past_esp+0x52/0x71
> Apr 18 15:05:51 kilobyte kernel:
> Apr 18 15:05:51 kilobyte kernel: Code: 0f 0b f4 00 4a 32 32 c0 eb e6 90
> 90 90 90 55 b8 00 e0 ff ff

