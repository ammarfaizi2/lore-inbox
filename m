Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271656AbRHUN10>; Tue, 21 Aug 2001 09:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271657AbRHUN1Q>; Tue, 21 Aug 2001 09:27:16 -0400
Received: from [195.66.192.167] ([195.66.192.167]:62215 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271656AbRHUN1G>; Tue, 21 Aug 2001 09:27:06 -0400
Date: Tue, 21 Aug 2001 16:29:23 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <6228957608.20010821162923@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Could NFS daemons be started via inetd?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am setting up NFS on my Linux box.
When I start server daemons from init scripts or by hand,
everything is working fine.

I tried to arrange these daemons to be run by inetd
but after I issue an NFS mount command inetd starts spawning
tons on rpc.mountd daemons. Log is filled with:
rpc.mountd[179]: connect from 127.0.0.1
rpc.mountd[180]: connect from 127.0.0.1
...
and load average goes up (went up to 40)
I repeatedly killall'ed rpc.mountd and eventually inetd
noticed failing service and disabled it.

Does anybody tried this? If you do, I am very interested in your
inetd.conf and/or NFS part of startup script. Mine is:

inetd.conf
----------
...
# NFS daemons (FIXME: not working)
rquotad/1-2     dgram   rpc/udp wait    root    /usr/sbin/tcpd  /usr/sbin/rpc.rquotad
nfs/2-3         dgram   rpc/udp wait    root    /usr/sbin/tcpd  /usr/sbin/rpc.nfsd
mountd/1-3      dgram   rpc/udp wait    root    /usr/sbin/tcpd  /usr/sbin/rpc.mountd
nlockmgr/1-4    dgram   rpc/udp wait    root    /usr/sbin/tcpd  /usr/sbin/rpc.lockd
rstatd/1-3      dgram   rpc/udp wait    root    /usr/sbin/tcpd  /usr/sbin/rpc.rstatd
...

init script
-----------
...
echo "* Starting NFS services:"
echo "  DEBUG: modprobe nfsd"
modprobe nfsd
echo "  DEBUG: exportfs -r - I will convert /etc/exports to /var/lib/nfs/* conv"
/usr/sbin/exportfs -r         # Does /etc/exports -> /var/lib/nfs/* conv
echo "  DEBUG: rpc.rquotad - needed?"
/usr/sbin/rpc.rquotad
echo "  DEBUG: rpc.nfsd 1 - 1 server started"
/usr/sbin/rpc.nfsd 1
echo "  DEBUG: rpc.mountd - listen to mount requests"
/usr/sbin/rpc.mountd
# With newer kernels, this starts by itself, but this won't hurt:
#echo "  DEBUG: rpc.lockd"
#/usr/sbin/rpc.lockd
echo "  DEBUG: rpc.statd - lock recovery after crash/reboot?"
/usr/sbin/rpc.statd
...

kernel: 2.4.5

Please CC me. I'm not on the list.


