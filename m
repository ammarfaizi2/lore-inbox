Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTICSjd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTICSgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:36:07 -0400
Received: from web10904.mail.yahoo.com ([216.136.131.40]:15201 "HELO
	web10904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264290AbTICSep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:34:45 -0400
Message-ID: <20030903183443.44079.qmail@web10904.mail.yahoo.com>
Date: Wed, 3 Sep 2003 11:34:43 -0700 (PDT)
From: Ned Ren <nedren@yahoo.com>
Subject: Need advice: Strange Oops, corrupted call stack??
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

We have modified the netfilter code a bit, but I feel quite suspicious of the oops dumps we are
getting. There are sometimes function calls repeated several times, when I look into those
functions there's no recursive calls. Also if look at crash 3, the function call shouldn't lead to
get_unique_tuple from netif_rx, does this mean the stack is corrupted?

I've traced the crash down to src_cmp() in net/ipv4/netfilter/ip_nat_core.c (called from
find_appropriate_src()). Looks like the i->conntrack pointer is bad (it should be in edx), but the
weird thing is it's 0x04000401 everytime!

static inline int
src_cmp(const struct ip_nat_hash *i,
	const struct ip_conntrack_tuple *tuple,
	const struct ip_nat_multi_range *mr)
{
	return (i->conntrack->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.protonum
		== tuple->dst.protonum  ...


Could someone give me some advice on this please?

Thank you very much for your time!!!



Crash 1:
======================================
Unable to handle kernel paging request at virtual address 04000425

Oops: 0000

EIP:0010:[<c01fb8c2>] at find_appropriate_src+0x42/a0 EFLAGS: 00010246

eax:e0810006  ebx:dcf651a4  ecx:00000001  edx:04000401  esi:d5e15b98

edi:00000000  ebp:00000b93  esp:d5e15ae0  ds:0018  es:0018  ss:0018

Process vss_ftp (pid: 5005, stackpage=d5e15000)

Stack: 

       e09847d8 d5e15b98 00000004 d5e15bf8 c01fbedc d5e15b98 e09847d8 c02b38a0 

       00000000 00000000 33323130 37363534 42413938 46454443 4a494847 4e4d4c4b 

       5251504f 00001400 00000000 00000001 00000001 00000001 5763c9df c01f1478 

Call Trace: [<c01fbedc>] get_unique_tuple+0x19c/210 (0xd5e15af0)

[<c01f1478>] invert_tuple+0x38/40 (0xd5e15b3c)

[<c01fbf9e>] ip_nat_setup_info+0x4e/3a0 (0xd5e15b50)

[<c01fb77e>] ip_nat_used_tuple+0x1e/30 (0xd5e15b68)

[<c01b4cae>] dev_queue_xmit+0x18e/2a0 (0xd5e15bb8)

[<c01f1478>] invert_tuple+0x38/40 (0xd5e15bec)

[<c01f26ae>] invert_tuplepr+0x1e/30 (0xd5e15bf8)

[<c01fbfcc>] ip_nat_setup_info+0x7c/3a0 (0xd5e15c0c)

[<c01fb490>] ipt_snat_target+0x20/30 (0xd5e15c28)

[<c01f8be5>] ipt_do_table+0x285/310 (0xd5e15c44)

[<c01fb5b9>] ip_nat_rule_find+0x29/b0 (0xd5e15ca0)

[<c0200006>] unix_stream_data_wait+0xc6/f0 (0xd5e15cbc)

[<c01fb62e>] ip_nat_rule_find+0x9e/b0 (0xd5e15cd8)

[<c01fafea>] ip_nat_fn+0x10a/200 (0xd5e15ce4)

[<c01cc7b0>] ip_finish_output2+0x0/e0 (0xd5e15d18)

[<c01bad38>] nf_iterate+0x58/90 (0xd5e15d1c)

[<c01cc7b0>] ip_finish_output2+0x0/e0 (0xd5e15d30)

[<c01bb035>] nf_hook_slow+0x65/150 (0xd5e15d44)

[<c01cc7b0>] ip_finish_output2+0x0/e0 (0xd5e15d60)

[<c01cb43e>] ip_output+0x5e/70 (0xd5e15d7c)

[<c01cc7b0>] ip_finish_output2+0x0/e0 (0xd5e15d94)

[<c01cc955>] ip_queue_xmit2+0xc5/22c (0xd5e15d9c)

[<c01bb075>] nf_hook_slow+0xa5/150 (0xd5e15db4)

[<c01cb5de>] ip_queue_xmit+0x18e/2c0 (0xd5e15dd0)

[<c01cc890>] ip_queue_xmit2+0x0/22c (0xd5e15de8)

[<c01dee82>] tcp_v4_send_check+0x32/c0 (0xd5e15df8)

[<c01da1b3>] tcp_transmit_skb+0x2b3/450 (0xd5e15e24)

[<c01dc15d>] tcp_connect+0x22d/280 (0xd5e15e48)

[<c01de6e4>] tcp_v4_connect+0x254/390 (0xd5e15e60)

[<c01b522f>] netif_receive_skb+0xef/180 (0xd5e15e80)

[<c013285f>] page_remove_rmap+0x5f/70 (0xd5e15eb4)

[<c01eb806>] inet_stream_connect+0xf6/230 (0xd5e15ec8)

[<c01ae8c6>] sys_connect+0x56/80 (0xd5e15ee8)

[<c011e06c>] sys_rt_sigaction+0x6c/a0 (0xd5e15f60)

[<c01af19b>] sys_socketcall+0x8b/1b0 (0xd5e15f8c)

[<c0110910>] do_page_fault+0x0/3f9 (0xd5e15fb0)

[<c0108d14>] error_code+0x34/40 (0xd5e15fb8)

[<c0108c03>] system_call+0x33/40 (0xd5e15fc0)

Code: 66 39 42 24 74 1c 85 ff 75 07 a1 54 ee 31 c0 eb dd 31 c0 85 




Crash 2
======================================
Oops: 0000
EIP:0010:[<c01ef0f2>] at find_appropriate_src+0x42/a0 EFLAGS: 00010246
eax:e0820006  ebx:d69169a4  ecx:00000001  edx:04000401  esi:c33abc1c
edi:00000000  ebp:00001e9b  esp:c33abb64  ds:0018  es:0018  ss:0018
Process vss_smtp_k (pid: 27037, stackpage=c33ab000)
Stack: 
       c33abcbc c33abc1c 00000004 c33abc7c c01ef70c c33abc1c c33abcbc c02a1660 
       0407070a 0000578b 00000000 c33a0006 00000003 c01ef5d4 c33abcec c01ef61a 
       c33abca8 c20fb620 c02a1660 00000000 0000578b 00000000 00000000 c01e4c78 
Call Trace: [<c01ef70c>] get_unique_tuple+0x19c/210 (0xc33abb74)
[<c01ef5d4>] get_unique_tuple+0x64/210 (0xc33abb98)
[<c01ef61a>] get_unique_tuple+0xaa/210 (0xc33abba0)
[<c01e4c78>] invert_tuple+0x38/40 (0xc33abbc0)
[<c01ef7ce>] ip_nat_setup_info+0x4e/3a0 (0xc33abbd4)
[<c01e4c78>] invert_tuple+0x38/40 (0xc33abbec)
[<c01e5ebe>] invert_tuplepr+0x1e/30 (0xc33abbf8)
[<c01ef7fc>] ip_nat_setup_info+0x7c/3a0 (0xc33abc0c)
[<c01f0006>] icmp_reply_translation+0x6/1b0 (0xc33abc30)
[<c01ec288>] ipt_do_table+0x108/310 (0xc33abc40)
[<c01eee5e>] ip_nat_rule_find+0x9e/b0 (0xc33abcac)
[<c01eee5e>] ip_nat_rule_find+0x9e/b0 (0xc33abcd8)
[<c01ee81a>] ip_nat_fn+0x10a/200 (0xc33abce4)
[<c01bffa0>] ip_finish_output2+0x0/e0 (0xc33abd18)
[<c01ae538>] nf_iterate+0x58/90 (0xc33abd1c)
[<c01bffa0>] ip_finish_output2+0x0/e0 (0xc33abd30)
[<c01ae835>] nf_hook_slow+0x65/150 (0xc33abd44)
[<c01bffa0>] ip_finish_output2+0x0/e0 (0xc33abd60)
[<c01bec2e>] ip_output+0x5e/70 (0xc33abd7c)
[<c01bffa0>] ip_finish_output2+0x0/e0 (0xc33abd94)
[<c01c0145>] ip_queue_xmit2+0xc5/22c (0xc33abd9c)
[<c01ae875>] nf_hook_slow+0xa5/150 (0xc33abdb4)
[<c01bedce>] ip_queue_xmit+0x18e/2c0 (0xc33abdd0)
[<c01c0080>] ip_queue_xmit2+0x0/22c (0xc33abde8)
[<c01d2672>] tcp_v4_send_check+0x32/c0 (0xc33abdf8)
[<c01cd9a3>] tcp_transmit_skb+0x2b3/450 (0xc33abe24)
[<c01cf94d>] tcp_connect+0x22d/280 (0xc33abe48)
[<c01d1ed4>] tcp_v4_connect+0x254/390 (0xc33abe60)
[<c012b60f>] kmem_cache_alloc+0xf/20 (0xc33abe78)
[<c01d1297>] tcp_bucket_create+0x17/50 (0xc33abe84)
[<c01df006>] inet_stream_connect+0xf6/230 (0xc33abec8)
[<c01a20c6>] sys_connect+0x56/80 (0xc33abee8)
[<c01a129f>] sock_map_file+0x9f/100 (0xc33abf28)
[<c01de5c5>] inet_setsockopt+0x25/30 (0xc33abf40)
[<c01a2483>] sys_setsockopt+0x43/80 (0xc33abf58)
[<c01a2492>] sys_setsockopt+0x52/80 (0xc33abf6c)
[<c01a299b>] sys_socketcall+0x8b/1b0 (0xc33abf8c)
[<c0108c03>] system_call+0x33/40 (0xc33abfc0)
Code: 66 39 42 24 74 1c 85 ff 75 07 a1 14 ce 30 c0 eb dd 31 c0 85 

Crash 3
==============================================================
Unable to handle kernel paging request at virtual address 04000425
Oops: 0000
EIP:0010:[<c01fb8c2>] at find_appropriate_src+0x42/a0 EFLAGS: 00010246
eax:e0810006  ebx:c543bf24  ecx:00000001  edx:04000401  esi:ccbebc1c
edi:00000000  ebp:000005cf  esp:ccbebb64  ds:0018  es:0018  ss:0018
Process vss_smtp_k (pid: 2904, stackpage=ccbeb000)
Stack:
       ccbebcbc ccbebc1c 00000004 ccbebc7c c01fbedc ccbebc1c ccbebcbc c02b38c0
       00000020 00000246 d00d7e00 c01b4eb8 00000004 c78cb010 00000001 00000004
       e0933f7d df831800 00000001 00000000 00000001 0000003f df814050 c01f1478
Call Trace: [<c01fbedc>] get_unique_tuple+0x19c/210 (0xccbebb74)
[<c01b4eb8>] netif_rx+0x88/1c0 (0xccbebb90)
[<e0933f7d>] speedo_rx+0xed/360 (0xccbebba4)
[<c01f1478>] invert_tuple+0x38/40 (0xccbebbc0)
[<c01fbf9e>] ip_nat_setup_info+0x4e/3b0 (0xccbebbd4)
[<c0109f21>] do_IRQ+0xb1/e0 (0xccbebc14)
[<c0200006>] unix_stream_data_wait+0xb6/f0 (0xccbebc30)
[<c01f8a68>] ipt_do_table+0x108/310 (0xccbebc40)
[<c01fb62e>] ip_nat_rule_find+0x9e/b0 (0xccbebcac)
[<c01fb62e>] ip_nat_rule_find+0x9e/b0 (0xccbebcd8)
[<c01fafea>] ip_nat_fn+0x10a/200 (0xccbebce4)
[<c01cc7b0>] ip_finish_output2+0x0/e0 (0xccbebd18)
[<c01bad38>] nf_iterate+0x58/90 (0xccbebd1c)
[<c01cc7b0>] ip_finish_output2+0x0/e0 (0xccbebd30)
[<c01bb035>] nf_hook_slow+0x65/150 (0xccbebd44)
[<c01cc7b0>] ip_finish_output2+0x0/e0 (0xccbebd60)
[<c01cb43e>] ip_output+0x5e/70 (0xccbebd7c)
[<c01cc7b0>] ip_finish_output2+0x0/e0 (0xccbebd94)
[<c01cc955>] ip_queue_xmit2+0xc5/22c (0xccbebd9c)
[<c01bb075>] nf_hook_slow+0xa5/150 (0xccbebdb4)
[<c01cb5de>] ip_queue_xmit+0x18e/2c0 (0xccbebdd0)
[<c01cc890>] ip_queue_xmit2+0x0/22c (0xccbebde8)
[<c01dee82>] tcp_v4_send_check+0x32/c0 (0xccbebdf8)
[<c01da1b3>] tcp_transmit_skb+0x2b3/450 (0xccbebe24)
[<c01dc15d>] tcp_connect+0x22d/280 (0xccbebe48)
[<c01de6e4>] tcp_v4_connect+0x254/390 (0xccbebe60)
[<c012b39f>] kmem_cache_alloc+0xf/20 (0xccbebe78)
[<c01ddaa7>] tcp_bucket_create+0x17/50 (0xccbebe84)
[<c01eb806>] inet_stream_connect+0xf6/230 (0xccbebec8)
[<c01ae8c6>] sys_connect+0x56/80 (0xccbebee8)
[<c01c8cd0>] ip_rcv_finish+0x0/1f0 (0xccbebf28)
[<c01eadc5>] inet_setsockopt+0x25/30 (0xccbebf40)
[<c01aec83>] sys_setsockopt+0x43/80 (0xccbebf58)
[<c01aec92>] sys_setsockopt+0x52/80 (0xccbebf6c)
[<c01af19b>] sys_socketcall+0x8b/1b0 (0xccbebf8c)
[<c0108c03>] system_call+0x33/40 (0xccbebfc0)
Code: 66 39 42 24 74 1c 85 ff 75 07 a1 54 ee 31 c0 eb dd 31 c0 85

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
