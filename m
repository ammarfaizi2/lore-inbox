Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUJGVLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUJGVLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUJGVJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:09:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:40396 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268283AbUJGUtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:49:40 -0400
Date: Thu, 7 Oct 2004 22:46:53 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Olaf Hering <olh@suse.de>
Subject: out of order execution of shell commands
Message-ID: <20041007204653.GA26820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we have a weird bug where the open of the shell output redirection
happens before the mkdir command returns.
As a result, the redirection will fail. Unexpected data loss.

This bug was seen on ppc64 (dual ppc970) and also on i386, single cpu
3GHz xeon with smp kernel. Running kernel was our SLES9 2.6.5. It did
also happen on ppc64 with 2.6.9-rc2-mm4, but I havent verified that.
It was not seen with just one script running, but with 2 (or more).

The inner loop fails after 2-3 hours, sometimes earlier, sometimes
never. Some tracing shows:

sys32_open(2076) fs-stress-olh.s(2736):c1,j3193150 S /dev/zero
sys32_open(2076) fs-stress-olh.s(2736):c1,j3193154 S 01/11/59/8/data
sys32_open(2076) fs-stress-olh.s(2736):c1,j3193157 S ./01/11/59/9/DIRNAME
sys_mkdir(1696) fs-stress-olh.s(2736):c1,j3193162 E 01/11/59/9

That means, a gap of up 5 jiffies betwen the start of the open
syscall and the end of the mkdir syscall.
In this case, everything happend on cpu1.
The dd command does never fail.

If I add more printk (start/end of sys_open, sys_mkdir), the bug will
disappear.

A quick look at the bash2 sources shows a wait(-1,..), I believe the
bash does nothing unusual.

Any ideas whats going on here, and how to debug it further?


testcase:

fs-stress-olh.sh
#!/bin/bash
export PATH=
/bin/echo $$ > /dev/shm/bug42232-pid-$$
/bin/mkdir stress-root
cd stress-root

/bin/echo Setting up ...
for i in 0 1 2 3 4 5 6 7 8 9; do
  for j in 0 1 2 3 4 5 6 7 8 9; do
    for k in 0 1 2 3 4 5 6 7 8 9; do
      /bin/echo -n "$i$j$k " >> onethousand
    done
    /bin/echo -n "$i$j " >> onehundret
  done
  /bin/echo -n "$i " >> ten
done
/bin/echo -n "0 1 2 3 4 5 6 7 8 9" > onethousand
for h in 0 1 ; do
  for i in `/bin/cat onethousand`; do
    /bin/mkdir $h$i
    /bin/echo $h$i > ./$h$i/DIRNAME
    for j in `/bin/cat onehundret`; do
      /bin/mkdir $h$i/$j
      /bin/echo $h$i/$j > ./$h$i/$j/DIRNAME
      for k in `/bin/cat onehundret`; do
        /bin/mkdir $h$i/$j/$k
        /bin/echo $h$i/$j/$k > ./$h$i/$j/$k/DIRNAME
        for l in `/bin/cat ten`; do
          /bin/mkdir $h$i/$j/$k/$l
          /bin/echo $h$i/$j/$k/$l > ./$h$i/$j/$k/$l/DIRNAME || /bin/kill -STOP `/bin/cat /dev/shm/bug42232-pid-*`
          /bin/dd if=/dev/zero of=$h$i/$j/$k/$l/data bs=1024 count=1 &> /dev/zero
        done
      done
    done
  done
done

cd ..
/bin/rm -rf stress-root /dev/shm/bug42232-pid-$$


start_test.sh
#!/bin/bash
set -ex
cd /bug42232
test -x ~olh/bugs/42232/fs-stress-olh.sh
numcpus=`grep -Ec '^cpu[0-9]' /proc/stat`
for i in `seq 1 $numcpus`
do
(rm -rf $i ; mkdir -v $i; cd $i || exit 1 ; pwd ; nohup sh -c 'while date ; do ~olh/bugs/42232/fs-stress-olh.sh ; done' < /dev/null > logfile 2>&1 & )
done
sleep $numcpus
( tail --follow=name --retry --lines=42 ?/logfile & )
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
