Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277341AbRKYOtY>; Sun, 25 Nov 2001 09:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277165AbRKYOtO>; Sun, 25 Nov 2001 09:49:14 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:52876 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S277143AbRKYOtH>; Sun, 25 Nov 2001 09:49:07 -0500
Subject: Severe Linux 2.4 kernel memory leakage
From: Chris Chabot <chabotc@reviewboard.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 25 Nov 2001 15:49:27 +0100
Message-Id: <1006699767.1178.0.camel@gandalf.chabotc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a firewall / file server box which is displaying (severe)
memory leakage, presumably by the kernel.

The box has ran Redhat 7.1 and 7.2, with plain vanilla linux kernels
2.4.9 upto 2.4.15, in all situations the same problem appeared.

The problem is that when the box boots up, it uses about 60Mb of memory.
However after only 1 1/2 days, the memory usage is already around 430Mb
(!!). (this is ofcource used - buffers - cache, as displayed by 'free').

When i do a ps aux, and add the 'resident' memory usage of the
applications, the memory usage should be around 70-80Mb (a bit higher
then @ boot time since bind uses more memory for caching). Yet 'free'
happely tells me:

             total       used       free     shared    buffers    
cached
Mem:       1029752    1019188      10564          0     130888    
456000
-/+ buffers/cache:     432300     597452
Swap:      2104464        996    2103468

When the box keeps on running for about a month, the memory usage gets
so high that it turns into a swap-crazy, low-memory and slow server ;-/
(it does free up cache memory, and swaps stuff out, however the 'leaked'
memory only grows and is never re-claimed).

The box runs dhcpd, bind, fetchmail (cron), pppd (to adsl modem), smb,
nfs, xinetd (imapd mostly) and sshd.

Also it has a (custom) iptables firewall script, and a simple ip route
hack to allow 'outbound interface == inbound interface' (using ipmark
based routing) for my cable modem & adsl modem. Also it has a 310Gb raid
0 array on 4 IDE disks.

Since this box has ran several versions of different kernels, redhat
distro's, and various firewall scripts. I tend to believe this is a more
'structural' problem within the linux kernel.

The box firewalls for both my cable modem and my adsl modem, and has 3
network cards (1 direct to cable, one direct to adsl, one to local
network).

The hardware on the box is : Asus p2b-ds, 2x p3-600, 1Gb (ECC) ram, 3
network cards (1x Intel EtherExpressPro, 2x 3c905 tx), Internal adaptect
29xx u2w scsi, internal intel IDE, 2x Seagate Cheetah (u2w) 18 Gb disks
(/ and /var), 4x 80 Gb Maxtor IDE disks (raid 0 array) and a NVidia TNT2
card. This hardware 

The kernel is compiled with all network- and scsi card and raid0 drivers
build in, and nfs + iptables as modules. The machine currently uses ext3
(also build in), however this problem was also present before i
converted the raid0 volume to ext3, so i do not suspect it to cause this
problem. The kernel is also set for HIGHMEM (4gb) to use the last Mb's
of the 1Gb of ram (else 127Mb isnt detected).

If there is any additional information i can provide, please feel free
to ask! Also please CC me in the replies, since i am not subscribed to
the linux-kernel list.


I do not know which component (iptables / route hack / raid0 / network
cards / highmem) cause this problem. I run several of these components
on other servers, without the same problems.. However in this
combination, the kernel seems very leaky ;-/ Any and all sugestions or
help is greatly apreciated.


Additional info on the box:

My Routes script (to allow cable and adsl to use the same outbound
interface as inbound, to prevent invalid routing over the default gw):


#!/bin/bash
echo 1 > /proc/sys/net/ipv4/route/flush
echo "Removing old rules"
ip rule del from 24.132.33.179  table a2000  &>/dev/null
ip rule del from 213.84.192.197 table xs4all &>/dev/null
ip route del table a2000  &>/dev/null
ip route del table xs4all &>/dev/null
echo "Setting routing"
ip rule add from 24.132.33.179  table a2000   prio 20
ip rule add from 213.84.192.197 table xs4all  prio 30
ip route add 0/0 table a2000  dev eth0 prio 20
ip route add 0/0 table xs4all dev ppp0 prio 30


free (this is after 1 1/2 day):

             total       used       free     shared    buffers    
cached
Mem:       1029752    1018528      11224          0     131608    
454556
-/+ buffers/cache:     432364     597388
Swap:      2104464        996    2103468



ps aux:

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME
COMMAND                                                                
root         1  0.0  0.0  1416  476 ?        S    Nov24   0:04 init
[3]                                                               
root         2  0.0  0.0     0    0 ?        SW   Nov24   0:00
[keventd]                                                              
root         3  0.0  0.0     0    0 ?        SWN  Nov24   0:00
[ksoftirqd_CPU0]                                                       
root         4  0.0  0.0     0    0 ?        SWN  Nov24   0:00
[ksoftirqd_CPU1]                                                       
root         5  0.0  0.0     0    0 ?        SW   Nov24   0:13
[kswapd]                                                               
root         6  0.0  0.0     0    0 ?        SW   Nov24   0:00
[bdflush]                                                              
root         7  0.0  0.0     0    0 ?        SW   Nov24   0:03
[kupdated]                                                             
root         8  0.0  0.0     0    0 ?        SW   Nov24   0:00
[scsi_eh_0]                                                            
root         9  0.0  0.0     0    0 ?        SW<  Nov24   0:00
[mdrecoveryd]                                                          
root        10  0.0  0.0     0    0 ?        SW   Nov24   0:01
[kjournald]                                                            
root       145  0.0  0.0     0    0 ?        SW   Nov24   0:00
[kjournald]                                                            
root       146  0.0  0.0     0    0 ?        SW   Nov24   0:01
[kjournald]                                                            
root       147  0.0  0.0     0    0 ?        SW   Nov24   0:18
[kjournald]                                                            
root       719  0.0  0.0  1476  604 ?        S    Nov24   0:00 syslogd
-m 0 -r                                                        
root       724  0.0  0.0  1404  476 ?        S    Nov24   0:00 klogd -2
-x                                                            
bin        744  0.0  0.0  1660  764 ?        S    Nov24   0:00
portmap                                                                
root       801  0.0  0.0  1792  568 ?        S    Nov24   0:00
rpc.rquotad                                                            
root       806  0.0  0.0  1620  716 ?        S    Nov24   0:00
rpc.mountd                                                             
root       811  0.0  0.0     0    0 ?        SW   Nov24   0:20
[nfsd]                                                                 
root       812  0.0  0.0     0    0 ?        SW   Nov24   0:20
[nfsd]                                                                 
root       813  0.0  0.0     0    0 ?        SW   Nov24   0:20
[nfsd]                                                                 
root       814  0.0  0.0     0    0 ?        SW   Nov24   0:19
[nfsd]                                                                 
root       815  0.0  0.0     0    0 ?        SW   Nov24   0:20
[nfsd]                                                                 
root       816  0.0  0.0     0    0 ?        SW   Nov24   0:19
[nfsd]                                                                 
root       817  0.0  0.0     0    0 ?        SW   Nov24   0:20
[nfsd]                                                                 
root       818  0.0  0.0     0    0 ?        SW   Nov24   0:20
[nfsd]                                                                 
root       819  0.0  0.0     0    0 ?        SW   Nov24   0:00
[lockd]                                                                
root       820  0.0  0.0     0    0 ?        SW   Nov24   0:00
[rpciod]                                                               
root       892  0.0  0.0  1920  896 ?        S    Nov24   0:00
/usr/sbin/pppd ca                                                      
root       911  0.0  0.1  2680 1084 ?        S    Nov24   0:02
/usr/sbin/sshd                                                         
root       931  0.0  0.1  2312 1032 ?        S    Nov24   0:00 xinetd
-stayalive                                                      
root       951  0.0  0.0  1796  648 ?        S    Nov24   0:00
/usr/sbin/dhcpd                                                        
named     1009  0.0  0.4 15328 4364 ?        S    Nov24   0:00 named -u
named                                                         
named     1011  0.0  0.4 15328 4364 ?        S    Nov24   0:01 named -u
named                                                         
named     1012  0.0  0.4 15328 4364 ?        S    Nov24   0:07 named -u
named                                                         
named     1013  0.0  0.4 15328 4364 ?        S    Nov24   0:06 named -u
named                                                         
named     1014  0.0  0.4 15328 4364 ?        S    Nov24   0:04 named -u
named                                                         
named     1015  0.0  0.4 15328 4364 ?        S    Nov24   0:01 named -u
named                                                         
root      1033  0.9  0.0  1456  528 ?        S    Nov24  29:38
/usr/sbin/pptp pp                                                      
root      1043  0.0  0.1  5684 1384 ?        S    Nov24   0:10 sendmail:
accepti                                                      
root      1062  0.0  0.0  1648  676 ?        S    Nov24   0:00
crond                                                                  
root      1541  0.0  0.0  1388  380 tty1     S    Nov24   0:00
/sbin/mingetty tt                                                      
root      1542  0.0  0.0  1388  380 tty2     S    Nov24   0:00
/sbin/mingetty tt                                                      
root      1545  0.0  0.0  1448  560 ?        S    Nov24   0:00
/usr/sbin/pptp pp                                                      
root      7003  0.0  0.1  3260 1132 ?        S    05:00   0:00 smbd
-D                                                                
root      7008  0.0  0.1  2448 1128 ?        S    05:00   0:00 nmbd
-D                                                                
root      7609  0.0  0.1  3732 2016 ?        S    14:39   0:00
/usr/sbin/sshd                                                         
root      7611  0.0  0.1  2612 1448 pts/1    S    14:39   0:00
-bash                                                                  
root     13333  0.0  0.0  2656  752 pts/1    R    14:57   0:00 ps aux




