Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSDHL2A>; Mon, 8 Apr 2002 07:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313334AbSDHL17>; Mon, 8 Apr 2002 07:27:59 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20744 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313307AbSDHL16>; Mon, 8 Apr 2002 07:27:58 -0400
Message-Id: <200204081125.g38BPXX30972@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: 2.4 -> 2.5 breakage (rpciod?)
Date: Mon, 8 Apr 2002 14:28:46 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a testcase made from a shutdown script.
Note double ps invocation at the bottom in zz.

Testcase kills all processes nicely on a 2.4 in preparation to umount+reboot.
However on 2.5.7 it shows erratic behavior: killall5 -15 seems to disturb
rpciod for a moment, this shows as "/bin/ps: I/O error" at the first ps after
kill commands. However, after user presses <Enter> second ps executes just 
fine.

Without this pause (a few seconds while user hits <Enter>) it is impossible
to continue (e.g. do a reboot): even sleep N won't work ("/bin/sleep: I/O 
error"). You can see this while beeper tries to make 1 second pauses.

Additional notes:
* I use simpleinit from util-linux, hence kill -TSTP 1
  or else simpleinit will try to spawn new gettys.
* I run an NFS-mounted box. Have to kill dhcpcd first or else
  eth0 gets deconfigured with catastrophic results.
* I suspect this bug manifests itself over NFS only.

testcase
========
#!/bin/sh
PATH=/sbin:/usr/sbin:/bin:/usr/bin
setsid ./zz </dev/null >/dev/null 2>&1 3>&1 &
while true; do
    sleep 32000
done

zz
==
#!/bin/sh
# start annoying beeping sound :-)
./beeper >/dev/console 2>&1 &
echo "* Stop getty spawning" >/dev/console
kill -TSTP 1
echo "* Running processes:" >/dev/console
ps -AH e >/dev/console
echo -n "* Press <Enter>:" >/dev/console; read junk </dev/console
echo "  kill: dhcpcd" >/dev/console
killall -KILL dhcpcd 2>/dev/null
sleep 2
echo "  term: everybody" >/dev/console
killall5 -15 2>/dev/null # won't work with -TERM
sleep 2
echo "  kill: everybody" >/dev/console
killall5 -9 2>/dev/null # won't work with -KILL
sleep 2
echo "* Running processes:" >/dev/console
ps -AH e >/dev/console 2>&1
echo -n "* Press <Enter>:" >/dev/console; read junk </dev/console
echo "* Running processes:" >/dev/console
ps -AH e >/dev/console 2>&1
echo -n "* Press <Enter>:" >/dev/console; read junk </dev/console

beeper
======
#!/bin/sh
while true; do
    echo -n " "
    sleep 1
done

--
vda
