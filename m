Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262339AbRENLoR>; Mon, 14 May 2001 07:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262341AbRENLoG>; Mon, 14 May 2001 07:44:06 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:47628 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S262339AbRENLn4>; Mon, 14 May 2001 07:43:56 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 14 May 2001 13:43:03 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.2.18: severe performance problem (high load, low mem, idle CPU)
Message-ID: <3AFFE0E5.30854.13C8A7A@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.1/SWEEP Version 3.43, March 2001 
X-Content-Conformance: LittleSister-1.6/0.0.100644.20010514.100056Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we experienced a severe performance problem on a PentiumPro 200 MHz, 
64MB RAM, 128MB swap:

Due to many processes being started in a short time, the system load 
went up to 53, and the 9GB SCSI disk was working heavily. At that time 
I suspected no severe problem, and I was busy doing something else. 
However after almost three hours the system load was still at about 40 
with the old processes not yet finished. (The processes typically take 
2 to 5 seconds to finish, and need about 4MB memory each).

At that point I became active.

In top I was surprised that the CPU claimed to be more than 90% idle, 
while the swap space was exceeded. But the memory wasn't really tight; 
cached and buffers were about 12MB together. So basically the situation 
should have gone away. Should, but didn't.

The kernel running was that from SuSE Linux 7.1 (Linux version 2.2.18 
(root@Pentium.suse.de) (gcc version 2.95.2 19991024 (release)) #1 Fri 
Jan 19 22:10:35 GMT 2001). So maybe the defect is an "enhancement" done 
by SuSE. Anyway:

In top I noticed that the processes to finish were all mostly swapped 
out, and they showed a zero in the "PRI" column. Usually runnable 
processes have more "fuel" there. It seems to me swapped out processes 
did not get their fules reloaded. The processes all had a "D" status 
(blocked on I/O). Also it seemed that processes that share a lot of 
data are not favoured enough when paging in. If a page is shared 10 
times, paging that one in would help 10 processes. Instead the kernel 
seemed to swap in and out a few kB wihout getting any process done.

I decided to kill a few non-essential processes to improve the 
situation. No help. I added an extra 32MB swapfile, so the buffers and 
shared went up to ver 30MB, but still no process finished. The CPU 
still was quite "idle".

So I decided to kill the processes in question. After several seconds, 
no process had terminated however. (Maybe due to the code to handle the 
signal being paged out). Then I did a kill -9 to the processes which 
finally helped.

So to summarize:
1) paged out processes seem not to get enough CPU
2) paged out shared pages seem not to get enough priority to be swapped 
in
3) On low memory situations the schedulting algorithm seems to perform 
poor

For 3) I sould imagine doing a round-robing scheduling with extended 
time-slice (while still being fair, i.e. run them rarely but longer) 
for massively swapped out processes, hoping that one of them will 
finish soon. That way maybe more of the working set will be paged in, 
enabbling some progress.

I don't have the top screen saved, but I have a ps -aux. The 40 
processes being paged out were all displayed with a %CPU of "0.0".
The ps command with 7.4% CPU was the highest value. The kernel pager 
also seemed to be non-busy:

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   400   52 ?        S    Mar22   0:22 init [3]
root         2  0.0  0.0     0    0 ?        SW   Mar22   0:03 [kflushd]
root         3  0.0  0.0     0    0 ?        SW   Mar22   0:01 [kupdate]
root         4  0.0  0.0     0    0 ?        SW   Mar22   6:58 [kswapd]
root         5  0.0  0.0     0    0 ?        SW<  Mar22   0:00 
[mdrecoveryd]
...
daemon   32528  0.0  2.0  4984 1352 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32529  0.0  2.0  4984 1352 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32531  0.0  2.7  5008 1760 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32533  0.0  2.5  4984 1640 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32539  0.0  3.1  5008 2044 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32540  0.0  1.9  4984 1276 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32542  0.0  1.4  4984  948 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32547  0.0  2.1  4984 1404 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32548  0.0  2.1  4984 1380 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32549  0.0  1.9  4984 1284 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32550  0.0  1.1  4984  768 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32555  0.0  2.3  4984 1504 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32556  0.0  1.8  4984 1224 ?        D    14:42   0:04 
/etc/mail/dirty-h
daemon   32557  0.0  1.9  4984 1244 ?        D    14:42   0:04 
/etc/mail/dirty-h
...

These were some of the processes that should have finished.

Regards,
Ulrich

