Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271898AbTGYD0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 23:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271899AbTGYD0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 23:26:18 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:11468 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S271898AbTGYD0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 23:26:16 -0400
Date: Thu, 24 Jul 2003 23:43:52 -0400
To: linux-kernel@vger.kernel.org
Subject: dbench has intermittent hang on 2.6.0-test1-ac2
Message-ID: <20030725034352.GA10261@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dbench 64 hung during a run using 2.6.0-test1-ac2 on ext3. One
of the dbench processes never created the clients/clientsXX
directory.

The parent dbench-2.0 process continues to update the throughput
measurement and the MB/sec slowly drops.

I saw the same behavior on a dbench 32 run with 2.6.0-test1-ac1
on reiserfs.

ps -ef|grep dbenc[h]
root     12266 11460  0 21:24 pts/0    00:00:00 ./dbench 64
root     12320 12266  0 21:24 pts/0    00:00:00 ./dbench 64

It isn't highly reproduceable.  Of 28 different dbench runs
on 2.6.0-test1-ac[12], only 2 have done this.

Uniprocessor x86 running RedHat 7.3 + patches.

Sysrq T for the dbench processes shows:

dbench        R C010F024 4089854812 12266  11460 12320               (NOTLB)
c909df60 00000082 bffffa58 c010f024 d5439360 d5439360 00000001 fffffe00
       00000000 c0118dda c909c000 00000001 00000000 d5439360 c0113e10 00000000
       00000000 c909dfc4 c010836b c909dfc4 00000000 d5439360 c0113e10 d54394b4
Call Trace:
 [<c010f024>] restore_i387+0x54/0x80
 [<c0118dda>] sys_wait4+0x1ea/0x220
 [<c0113e10>] default_wake_function+0x0/0x20
 [<c010836b>] sys_sigreturn+0x8b/0xc0
 [<c0113e10>] default_wake_function+0x0/0x20
 [<c0108e27>] syscall_call+0x7/0xb

dbench        S C46F3FC4 4028283312 12320  12266                     (NOTLB)
c46f3fb8 00000086 00000000 c46f3fc4 d4546060 0000000b 00000774 00000040
       c46f2000 c0120f14 c0108e27 0000000b 00000000 40013000 00000774 00000040
       bffffb28 0000001d 0000007b 0000007b 0000001d 400c6837 00000073 00000246
Call Trace:
 [<c0120f14>] sys_pause+0x14/0x20
 [<c0108e27>] syscall_call+0x7/0xb


strace -p 12320		# child
pause(


kill 12320
kill -INT 12320

The state changes from S to T.

ps axu|grep dbenc[h]
root     12266  0.0  0.1  1364  424 pts/0    S    21:24   0:00 ./dbench 64
root     12320  0.0  0.0  1360  356 pts/0    T    21:24   0:00 ./dbench 64

cat /proc/12320/wchan
finish_stop

kill -CONT 12320	# child and parent exit

All of <sysrq t> output at:
http://home.earthlink.net/~rwhron/kernel/sysrq-t.txt

config at
http://home.earthlink.net/~rwhron/kernel/config/config-2.6.0-test1-ac2

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

