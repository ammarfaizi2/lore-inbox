Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbTE3W7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTE3W7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:59:17 -0400
Received: from web41501.mail.yahoo.com ([66.218.93.84]:163 "HELO
	web41501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264028AbTE3W7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:59:11 -0400
Message-ID: <20030530231231.64427.qmail@web41501.mail.yahoo.com>
Date: Fri, 30 May 2003 16:12:31 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Cute kernel trick, or communistic ploy?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Output of program to simulate a /proc file in a stopped kernel,
using the same kernel function(s) used to generate the actual file
when the kernel is up:

(gdb) source ./proc-uptime
$3 = (void *) 0xa1aec000
$4 = (void *) 0xa1da48d4
$5 = (void *) 0xa1da4384
$6 = (void *) 0xa1da48ac
$7 = 0
"remember to 'call(kfree($page))' when finished
"4080219633.89 395.85
(gdb) 

  This program works fine in the um arch but I was wondering what
the pitfalls are in an approach like this. This is a trivial example,
but other /proc files do very complicated bookkeeping and formatting;
and this method should be equally applicable to those.


GDB program 'proc-uptime' (18 lines):

set $gfp_atomic=0x20
call(kmalloc(4096,$gfp_atomic))
set $page=$
call(kmalloc(32,$gfp_atomic))
set $zero=(int *)$
set *$zero=(int)0
call(kmalloc(32,$gfp_atomic))
set $start=(int **)$
set *$start=$zero
call(kmalloc(32,$gfp_atomic))
set $eof=(int *)$
set *$eof=1
call(uptime_read_proc((char *)$page,(char **)$start,(off_t)0,\
  0,$eof,(void *)$zero))
call(kfree($zero))
call(kfree($eof))
call(kfree($start))
echo "remember to 'call(kfree($page))' before continuing\n"
printf "%s\n",$page



