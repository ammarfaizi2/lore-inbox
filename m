Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266033AbSIRLFb>; Wed, 18 Sep 2002 07:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266047AbSIRLFb>; Wed, 18 Sep 2002 07:05:31 -0400
Received: from employees.nextframe.net ([212.169.100.200]:48110 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S266033AbSIRLFa>; Wed, 18 Sep 2002 07:05:30 -0400
Date: Wed, 18 Sep 2002 13:14:14 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS 2.4.19] Unable to handle kernel paging request at virtual address 7ec64585
Message-ID: <20020918131414.G762@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <20020917133338.B762@sexything>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020917133338.B762@sexything>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again, 

now have a look at this - happens on the same box as the
oops I reported yesterday. EIP still in iput(), but this time we were
obviosuly working with swap instead of memory . This time
it`s kswapd, and after the oops kswapd is :

[13:19][admin@sql:~]$ ps -ewo user,pid,priority,stat,command,wchan | grep kswapd
root         4   9 Z    [kswapd <defunct do_exit

This is not cool guys - no one else seing this ? 2.4.18 was running just fine
on this box. I`m going back to 2.4.18 now and I`ll see if this keeps happening ... if
it does it might be hardware related (even though that does not seem very likely) - as I
said, the box has been running just fine with 2.4.18 for a long time.

Sep 17 19:03:44 sql kernel: Unable to handle kernel paging request at virtual address e5881af5
Sep 17 19:03:44 sql kernel: c0141edc
Sep 17 19:03:44 sql kernel: *pde = 00000000
Sep 17 19:03:44 sql kernel: Oops: 0000
Sep 17 19:03:44 sql kernel: CPU:    0
Sep 17 19:03:44 sql kernel: EIP:    0010:[<c0141edc>]    Not tainted
Sep 17 19:03:44 sql kernel: EFLAGS: 00010282
Sep 17 19:03:44 sql kernel: eax: 00000000   ebx: c574c600   ecx: c5f4c610   edx: c5f4c610
Sep 17 19:03:44 sql kernel: esi: e5881ad5   edi: 00000000   ebp: 00000448   esp: c12f5f4c
Sep 17 19:03:44 sql kernel: ds: 0018   es: 0018   ss: 0018
Sep 17 19:03:44 sql kernel: Process kswapd (pid: 4, stackpage=c12f5000)
Sep 17 19:03:44 sql kernel: Stack: c3598638 c3598620 c574c600 c01400b6 c574c600 00000019 000001d0 0000001c
Sep 17 19:03:44 sql kernel:        00000005 c014037b 000004ac c0129f40 00000005 000001d0 00000005 000001d0
Sep 17 19:03:44 sql kernel:        c02794f4 00000000 c02794f4 c0129f8f 0000001c c02794f4 00000001 c12f4000
Sep 17 19:03:44 sql kernel: Call Trace:    [<c01400b6>] [<c014037b>] [<c0129f40>] [<c0129f8f>] [<c012a023>]
Sep 17 19:03:44 sql kernel:   [<c012a07e>] [<c012a18d>] [<c0106ec8>]
Sep 17 19:03:44 sql kernel: Code: 8b 7e 20 85 ff 74 0d 8b 47 10 85 c0 74 06 53 ff d0 83 c4 04

>>EIP; c0141edc <iput+2c/19c>   <=====

>>ebx; c574c600 <END_OF_CODE+545618c/????>
>>ecx; c5f4c610 <END_OF_CODE+5c5619c/????>
>>edx; c5f4c610 <END_OF_CODE+5c5619c/????>
>>esi; e5881ad5 <END_OF_CODE+2558b661/????>
>>ebp; 00000448 Before first symbol
>>esp; c12f5f4c <END_OF_CODE+fffad8/????>

Trace; c01400b6 <prune_dcache+c6/138>
Trace; c014037b <shrink_dcache_memory+1b/34>
Trace; c0129f40 <shrink_caches+68/80>
Trace; c0129f8f <try_to_free_pages+37/58>
Trace; c012a023 <kswapd_balance_pgdat+43/8c>
Trace; c012a07e <kswapd_balance+12/28>
Trace; c012a18d <kswapd+99/bc>
Trace; c0106ec8 <kernel_thread+28/38>

Code;  c0141edc <iput+2c/19c>
00000000 <_EIP>:
Code;  c0141edc <iput+2c/19c>   <=====
   0:   8b 7e 20                  mov    0x20(%esi),%edi   <=====
Code;  c0141edf <iput+2f/19c>
   3:   85 ff                     test   %edi,%edi
Code;  c0141ee1 <iput+31/19c>
   5:   74 0d                     je     14 <_EIP+0x14> c0141ef0 <iput+40/19c>
Code;  c0141ee3 <iput+33/19c>
   7:   8b 47 10                  mov    0x10(%edi),%eax
Code;  c0141ee6 <iput+36/19c>
   a:   85 c0                     test   %eax,%eax
Code;  c0141ee8 <iput+38/19c>
   c:   74 06                     je     14 <_EIP+0x14> c0141ef0 <iput+40/19c>
Code;  c0141eea <iput+3a/19c>
   e:   53                        push   %ebx
Code;  c0141eeb <iput+3b/19c>
   f:   ff d0                     call   *%eax
Code;  c0141eed <iput+3d/19c>
  11:   83 c4 04                  add    $0x4,%esp


== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
