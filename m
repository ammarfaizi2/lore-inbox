Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262967AbTCKQaw>; Tue, 11 Mar 2003 11:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262970AbTCKQaw>; Tue, 11 Mar 2003 11:30:52 -0500
Received: from stock.xs4all.nl ([213.84.187.26]:13440 "HELO stokkie.net")
	by vger.kernel.org with SMTP id <S262967AbTCKQat>;
	Tue, 11 Mar 2003 11:30:49 -0500
Date: Tue, 11 Mar 2003 17:41:28 +0100 (CET)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 and kernel memory leak?
Message-ID: <Pine.LNX.4.44.0303111731500.6897-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After 24 hours my system seem to start using much more memory
as that procps reports with ps aux. info about my system :

The machine is a compaq proliant 2500 with 2x PPro 200MHz cpu, and a 
smart2/p array controller. The machine runs redhat 6.2 with kernel 2.4.19 :

[hubble:stock]:(~)$ gcc -v
Reading specs from /usr/local/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/specs
gcc version 2.95.3 20010315 (release)
[hubble:stock]:(~)$ ps -V
procps version 3.1.6
[hubble:stock]:(~)$ uname -a
Linux hubble.stokkie.net 2.4.19 #2 SMP Thu Oct 17 07:19:55 CEST 2002 i686 unknown

After barely running 1 day i get this :

[hubble:stock]:(~)$ w
 17:25:07 up 1 day,  4:28,  1 user,  load average: 0.00, 0.00, 0.00
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
stock    pts/0     17:14    0.00s  0.19s  0.07s w
[hubble:stock]:(~)$ memtotal 
Total  memory: 
Total Virtual memory : 89356 kbytes
Total Real memory    : 40388 kbytes
[hubble:stock]:(~)$ free
             total       used       free     shared    buffers     cached
Mem:        257008     251248       5760          0      46156      81772
-/+ buffers/cache:     123320     133688
Swap:       265192        472     264720
[hubble:stock]:(~)$ 

[hubble:stock]:(~)$ cat bin/memtotal 
ps aux | awk -f /home/stock/bin/totalmem.awk
[hubble:stock]:(~)$ cat /home/stock/bin/totalmem.awk
BEGIN { FS = " " }
NR == 1 {
        print "Total  memory: "
}
{ 
                vmem += $5;
                rmem += $6;
}
END {
        print "Total Virtual memory : "vmem" kbytes"
        print "Total Real memory    : "rmem" kbytes"
}

ps aux :

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1  1120  476 ?        S    Mar10   0:06 init [3] 
root         2  0.0  0.0     0    0 ?        SW   Mar10   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Mar10   0:00 [ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SWN  Mar10   0:00 [ksoftirqd_CPU1]
root         5  0.0  0.0     0    0 ?        SW   Mar10   0:01 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   Mar10   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        SW   Mar10   0:01 [kupdated]
root         8  0.0  0.0     0    0 ?        SW   Mar10   0:00 [scsi_eh_0]
root         9  0.0  0.0     0    0 ?        SW   Mar10   0:05 [kjournald]
root        99  0.0  0.0     0    0 ?        SW   Mar10   0:00 [kjournald]
bin        412  0.0  0.1  1212  504 ?        S    Mar10   0:00 portmap
root       465  0.0  0.2  1168  528 ?        S    Mar10   0:00 syslogd -m 0
root       474  0.0  0.4  1796 1132 ?        S    Mar10   0:00 klogd
nobody     488  0.0  0.2  1292  644 ?        S    Mar10   0:00 identd -e -o
nobody     490  0.0  0.2  1292  644 ?        S    Mar10   0:01 identd -e -o
nobody     491  0.0  0.2  1292  644 ?        S    Mar10   0:00 identd -e -o
nobody     492  0.0  0.2  1292  644 ?        S    Mar10   0:00 identd -e -o
nobody     495  0.0  0.2  1292  644 ?        S    Mar10   0:00 identd -e -o
daemon     506  0.0  0.1  1144  504 ?        S    Mar10   0:00 /usr/sbin/atd
root       520  0.0  0.2  1328  628 ?        S    Mar10   0:00 crond
root       534  0.0  0.1  1144  496 ?        S    Mar10   0:00 inetd
named      544  0.0  1.0  4240 2728 ?        S    Mar10   0:02 named -u named
root       557  0.0  0.4  2392 1172 ?        S    Mar10   0:09 sshd
root       574  0.0  0.5  1364 1360 ?        SL   Mar10   0:06 xntpd -A
root       589  0.0  0.2  1204  540 ?        S    Mar10   0:00 lpd
root       608  0.0  0.1  1104  388 ?        S    Mar10   0:00 rpc.rquotad
root       617  0.0  0.3  1484  832 ?        S    Mar10   0:00 rpc.mountd --no-nfs-version 3
root       626  0.0  0.0     0    0 ?        SW   Mar10   0:00 [nfsd]
root       627  0.0  0.0     0    0 ?        SW   Mar10   0:00 [nfsd]
root       628  0.0  0.0     0    0 ?        SW   Mar10   0:00 [nfsd]
root       629  0.0  0.0     0    0 ?        SW   Mar10   0:00 [nfsd]
root       630  0.0  0.0     0    0 ?        SW   Mar10   0:00 [nfsd]
root       631  0.0  0.0     0    0 ?        SW   Mar10   0:00 [nfsd]
root       632  0.0  0.0     0    0 ?        SW   Mar10   0:00 [nfsd]
root       633  0.0  0.0     0    0 ?        SW   Mar10   0:00 [nfsd]
root       634  0.0  0.0     0    0 ?        SW   Mar10   0:00 [lockd]
root       635  0.0  0.0     0    0 ?        SW   Mar10   0:00 [rpciod]
root       657  0.0  0.2  1156  568 ?        S    Mar10   0:00 rpc.statd
root       671  0.0  0.2  1312  592 ?        S    Mar10   0:00 /usr/sbin/dhcpd
root       700  0.0  0.1  1124  336 ?        S    Mar10   0:04 svscan
root       701  0.0  0.1  1088  308 ?        S    Mar10   0:00 supervise qmail-send
root       702  0.0  0.1  1088  308 ?        S    Mar10   0:00 supervise log
root       703  0.0  0.1  1088  308 ?        S    Mar10   0:00 supervise qmail-smtpd
root       704  0.0  0.1  1088  308 ?        S    Mar10   0:00 supervise log
qmaill     705  0.0  0.1  1104  360 ?        S    Mar10   0:00 /usr/local/bin/multilog t /var/log/qmail
qmaild     706  0.0  0.1  1152  476 ?        S    Mar10   0:00 /usr/local/bin/tcpserver -v -p -x /etc/tcp.smtp.cdb -c 20 -u 518 -g 517 0 smtp /var/qmail/bin/qmail-smtpd
qmails     707  0.0  0.1  1140  384 ?        S    Mar10   0:00 qmail-send
qmaill     708  0.0  0.1  1100  304 ?        S    Mar10   0:00 /usr/local/bin/multilog t /var/log/qmail/smtpd
root       711  0.0  0.1  1100  332 ?        S    Mar10   0:00 qmail-lspawn |dot-forward .forward?|preline procmail
qmailr     712  0.0  0.1  1100  344 ?        S    Mar10   0:00 qmail-rspawn
qmailq     713  0.0  0.1  1092  344 ?        S    Mar10   0:00 qmail-clean
root       730  0.0  0.1  1144  408 ?        S    Mar10   0:00 gpm -t ps/2
xfs        771  0.0  0.5  2228 1296 ?        S    Mar10   0:00 xfs -droppriv -daemon -port -1
root       785  0.0  0.2  2992  744 ?        S    Mar10   0:00 smbd -D
root       794  0.0  0.3  2168  940 ?        S    Mar10   0:05 nmbd -D
root       795  0.0  0.2  2100  536 ?        S    Mar10   0:00 nmbd -D
root       839  0.0  0.3  1588  804 ?        S    Mar10   0:02 /usr/sbin/pppd /dev/pts/1 38400 file /etc/ppp/options.adsl
root       841  0.2  0.1  1156  480 ?        S    Mar10   3:54 /usr/sbin/pptp pptp: GRE-to-PPP gateway on (null)   
root       844  0.0  0.2  1156  516 ?        S    Mar10   0:00 /usr/sbin/pptp pptp: call manager for 10.0.0.138    
root      1026  0.0  0.1  1092  384 tty1     S    Mar10   0:00 /sbin/mingetty tty1
root      1027  0.0  0.1  1092  384 tty2     S    Mar10   0:00 /sbin/mingetty tty2
root      1028  0.0  0.1  1092  384 tty3     S    Mar10   0:00 /sbin/mingetty tty3
root      1029  0.0  0.1  1092  384 tty4     S    Mar10   0:00 /sbin/mingetty tty4
root      1030  0.0  0.1  1092  384 tty5     S    Mar10   0:00 /sbin/mingetty tty5
root      1033  0.0  0.1  1092  384 tty6     S    Mar10   0:00 /sbin/mingetty tty6
root      1035  0.0  0.2  1148  532 ?        S    Mar10   0:00 /usr/sbin/pptpd -f 
root      6730  0.0  0.7  3300 1900 ?        S    17:14   0:00 sshd
stock     6731  0.0  0.3  1740  996 pts/0    S    17:14   0:00 -bash
root      6874  0.4  0.7  3300 1900 ?        S    17:31   0:01 sshd
stock     6875  0.0  0.3  1732  984 pts/2    S    17:31   0:00 -bash
stock     6897  0.3  1.1  6708 2892 pts/2    S    17:31   0:01 pine
stock     6899  0.0  0.3  1800  956 pts/2    S    17:32   0:00 vi /tmp/pico.006897
stock     6911  0.0  0.3  1652  772 pts/2    S    17:37   0:00 /bin/bash -c (ps aux) < /tmp/viC1Tla4 >/tmp/voglxWbY 2>&1
stock     6912  0.0  0.2  2316  712 pts/2    R    17:37   0:00 ps aux

1. So why does /bin/ps report 0 kbytes for kernel processes ? 
2. And why does /usr/bin/free (also a procps item) seems to report much 
   more memory usage? 
3. Do we have a kernel memory leak inside 2.4.19 ?

regards,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX Consultant
crashrecovery.org  stock@stokkie.net

