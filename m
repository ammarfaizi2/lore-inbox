Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUCNQuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 11:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbUCNQuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 11:50:05 -0500
Received: from mail2.scram.de ([195.226.127.112]:12811 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id S261433AbUCNQt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 11:49:59 -0500
Date: Sun, 14 Mar 2004 17:49:50 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@localhost
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com
Subject: [bug 2.6.4] llc2 oops
Message-ID: <Pine.LNX.4.58.0403141732350.25924@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

looks like llc_ui_bind forgets to set llc->dev. The combination:
  bind (fd, &sllc, sizeof (sllc));
  connect(fd, &dllc, sizeof(dllc));
produces the following oops for me:

Unable to handle kernel paging request at virtual address 00000000000000c8
llc-linux(18496): Oops 0
pc = [<fffffffc00576194>]  ra = [<fffffffc00582df0>]  ps = 0000    Not
tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = fffffffc00582cba  t1 = fffffffc00582cba
t2 = 0000000004030201  t3 = 0000000000582c00  t4 = 0000000004030201
t5 = 0000060504030201  t6 = fffffc001389fe19  t7 = fffffc001389c000
s0 = fffffc002bfc0e00  s1 = ffffffffffffffc8  s2 = fffffc001389fe88
s3 = ffffffffffffffdb  s4 = fffffc001f56e8c0  s5 = fffffc0025a1e9c0
s6 = 000000011ffffba0
a0 = fffffc002bfc0e00  a1 = 00000000000000c8  a2 = fffffc001389fe90
a3 = 0000000000582cba  a4 = ffffffffffffffff  a5 = 0000000000000000
t8 = fffffc001389fe1d  t9 = 00000023d3f41186  t10= 0000060504030201
t11= fffffc001389fe94  pv = fffffffc0057e360  at = fffffc001f56e8c0
gp = fffffffc00594068  sp = fffffc001389fde8
Trace:fffffc00011607ba fffffc000115d940 fffffc0001012c9c
Code: b27e0030  2c3e0034  2c5e0031  48b20d45  2cd20005  487204c3
<2c910000> 44650403


>>RA;  fffffffc00582df0 <[llc2]llc_ui_connect+170/220>

>>PC;  fffffffc00576194 <[llc2]llc_establish_connectio+84/440>   <=====

Trace; fffffc00011607ba <release_sock+1a/f0>
Trace; fffffc000115d940 <sys_connect+a0/e0>
Trace; fffffc0001012c9c <strace+4c/c0>

Code;  fffffffc0057617c <[llc2]llc_establish_connectio+6c/440>
0000000000000000 <_PC>:
Code;  fffffffc0057617c <[llc2]llc_establish_connectio+6c/440>
   0:   30 00 7e b2       stl  a3,48(sp)
Code;  fffffffc00576180 <[llc2]llc_establish_connectio+70/440>
   4:   34 00 3e 2c       ldq_u        t0,52(sp)
Code;  fffffffc00576184 <[llc2]llc_establish_connectio+74/440>
   8:   31 00 5e 2c       ldq_u        t1,49(sp)
Code;  fffffffc00576188 <[llc2]llc_establish_connectio+78/440>
   c:   45 0d b2 48       extlh        t4,a2,t4
Code;  fffffffc0057618c <[llc2]llc_establish_connectio+7c/440>
  10:   05 00 d2 2c       ldq_u        t5,5(a2)
Code;  fffffffc00576190 <[llc2]llc_establish_connectio+80/440>
  14:   c3 04 72 48       extll        t2,a2,t2
Code;  fffffffc00576194 <[llc2]llc_establish_connectio+84/440>   <=====
  18:   00 00 91 2c       ldq_u        t3,0(a1)   <=====
Code;  fffffffc00576198 <[llc2]llc_establish_connectio+88/440>
  1c:   03 04 65 44       or   t2,t4,t2

Without the bind(), things get a bit further. I receive an EAGAIN and in
dmesg:

schedule_timeout: wrong timeout value ffffffffffffffff from
fffffffc005831d4

So, apparently, llc_ui_wait_for_conn() and llc_ui_wait_for_disc() are
buggy, as well...

--jochen
