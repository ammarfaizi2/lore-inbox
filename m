Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSJHQiK>; Tue, 8 Oct 2002 12:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbSJHQiK>; Tue, 8 Oct 2002 12:38:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:36002 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261486AbSJHQiJ>; Tue, 8 Oct 2002 12:38:09 -0400
Message-ID: <3DA30B28.8070504@us.ibm.com>
Date: Tue, 08 Oct 2002 09:43:20 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.40-mm2
References: <Pine.LNX.4.44.0210081303090.29540-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> On Sun, 6 Oct 2002, Dave Hansen wrote:
> 
>>cc'ing Ingo, because I think this might be related to the timer bh
>>removal.
> 
> could you try the attached patch against 2.5.41, does it help? It fixes
> the bugs found so far plus makes del_timer_sync() a bit more robust by
> re-checking timer pending-ness before exiting. There is one type of code
> that might have relied on this kind of behavior of the old timer code.

Hehe.  That'll teach me to be optimistic.  This is unprocessed, but 
the EIP in tvec_bases should tell the whole story.  Something _nasty_ 
is going on.

addr2line on the run_timer_tasklet call: kernel/timer.c:359
This is with the patch that Ingo sent me about 6 hours ago.  Andrew, 
should I still test the one that you sent me this morning?

CPU:    7
EIP:    0060:[<80382bd2>]    Not tainted
EFLAGS: 00010a02
EIP is at tvec_bases+0x7152/0x20400
eax: e4a2d9a0   ebx: 80382bd0   ecx: 80382bd8   edx: 80382fd0
esi: 80382bc8   edi: 80382b60   ebp: 00000001   esp: f4d71db0
ds: 0068   es: 0068   ss: 0068
Process httpd (pid: 2554, threadinfo=f4d70000 task=f4d727c0)
Stack: 8012038b 80382bd8 8b093288 00000000 f4d70000 8011d1e5 00000000 
00000001
        8037b960 fffffffa 000000e0 80360264 80360264 8011ceea 8037b960 
f4d70000
        00000001 00000001 e4bf0930 00000246 80257ed0 e4bf07c0 f4d71eec 
f4d71eb8
Call Trace:
  [<8012038b>] run_timer_tasklet+0xcf/0x118
  [<8011d1e5>] tasklet_hi_action+0x85/0xe0
  [<8011ceea>] do_softirq+0x5a/0xac
  [<80257ed0>] tcp_sendmsg+0x10b8/0x11f4
  [<80273726>] inet_sendmsg+0x42/0x48
  [<8023bf0e>] sock_sendmsg+0x72/0x94
  [<8023c220>] sock_readv_writev+0x94/0xa0
  [<8023c29b>] sock_writev+0x37/0x40
  [<8013f94a>] do_readv_writev+0x186/0x278
  [<8023c07c>] sock_write+0x0/0xb0
  [<8013f4d7>] vfs_read+0xb7/0x128
  [<8013fb02>] sys_writev+0x5a/0x6c
  [<801070b3>] syscall_call+0x7/0xb

Code: 38 80 d0 2b 38 80 d8 2b 38 80 00 00 00 00 e0 2b 38 80 e0 2b
  <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


-- 
Dave Hansen
haveblue@us.ibm.com

