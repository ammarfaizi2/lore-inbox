Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266348AbUBERjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266192AbUBERgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:36:55 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:9175 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S265363AbUBERgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:36:08 -0500
Date: Thu, 5 Feb 2004 18:36:06 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Netlink BUG() on AMD64
Message-ID: <20040205183604.N26559@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, world!\n

I have got kernel BUG() while running the "ip rule list" command
on my dual AMD64 box with 2.6.2 kernel. I have a blacklist of IP
addresses, and I have one IP rule for each of this addresses:

ip rule add pref 500 from x.y.z.a dev $UPLINK_DEV blackhole

I have about 200 such rules (with different x.y.z.a IPv4 addresses,
but all with the same preference of 500 and same $UPLINK_DEV - currently
eth3). I have measured that when I add less than 60 such rules, I do not
get BUG() during "ip rule list" command. When I add 60 or more,
I get overflow in skb_put(). So the kernel is definitely overflowing
something.

The kernel messages:

skput:over: ffffffff802bb833:3804 put:-36 dev:<NULL>----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at skbuff:88
invalid operand: 0000 [1]
CPU 0
Pid: 2778, comm: ip Not tainted
RIP: 0010:[<ffffffff80270f72>] <ffffffff80270f72>{skb_over_panic+50}
RSP: 0018:000001003e187a18  EFLAGS: 00010216
RAX: 0000000000000037 RBX: 000001003e92b580 RCX: 0000000000000001
RDX: 0000000000000002 RSI: 000001003ff8abf0 RDI: 0000000000000001
RBP: 00000100417a49c0 R08: 0000000000000001 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000000 R12: 000001003e308edc
R13: 00000000402280ce R14: 0000000000000ada R15: 000000000000003c
FS:  0000002a9555cc60(0000) GS:ffffffff80416d40(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000349ca96390 CR3: 0000000000101000 CR4: 00000000000006a0
Process ip (pid: 2778, stackpage=1003f01d140)
Stack: 0000000000000ada ffffffff802bb83b 0000000000000246 0000000080271022
       000001003e168bc0 000001003e92b580 ffffffff802bb580 000001003ffaeb40
       000001003e168bc0 000001003e168b40
Call Trace:<ffffffff802bb83b>{inet_dump_rules+699} <ffffffff802bb580>{inet_dump_rules+0}
       <ffffffff80282e37>{netlink_dump+135} <ffffffff802bb580>{inet_dump_rules+0}
       <ffffffff8027dbf0>{rtnetlink_done+0} <ffffffff802830e9>{netlink_dump_start+281}
       <ffffffff8027dd50>{rtnetlink_rcv+336} <ffffffff8016af75>{bh_lru_install+229}
       <ffffffff801af379>{__journal_file_buffer+377} <ffffffff80282c86>{netlink_data_ready+22}
       <ffffffff802823e9>{netlink_unicast+793} <ffffffff8012dc20>{default_wake_function+0}
       <ffffffff8012dc20>{default_wake_function+0} <ffffffff80282a4c>{netlink_sendmsg+684}
       <ffffffff8026d8d5>{sock_sendmsg+133} <ffffffff8014f111>{__alloc_pages+161}
       <ffffffff8014b6a7>{find_get_page+23} <ffffffff8014c5c9>{filemap_nopage+345}
       <ffffffff8015a76d>{do_no_page+925} <ffffffff8026d690>{sockfd_lookup+32}
       <ffffffff8026d337>{move_addr_to_kernel+39} <ffffffff8026ebc3>{sys_sendto+195}
       <ffffffff8026ea07>{sys_getsockname+135} <ffffffff8026d651>{sock_map_fd+353}
       <ffffffff80281be0>{netlink_create+160} <ffffffff8010ec04>{system_call+124}
        
 
Code: 0f 0b ff ed 34 80 ff ff ff ff 58 00 48 83 c4 08 c3 66 66 66
RIP <ffffffff80270f72>{skb_over_panic+50} RSP <000001003e187a18>
  
-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
