Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132360AbRA0XAt>; Sat, 27 Jan 2001 18:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132362AbRA0XAj>; Sat, 27 Jan 2001 18:00:39 -0500
Received: from ghost.btnet.cz ([62.80.85.74]:14345 "HELO ghost.btnet.cz")
	by vger.kernel.org with SMTP id <S132360AbRA0XA1>;
	Sat, 27 Jan 2001 18:00:27 -0500
Message-ID: <20010128000157.48012@ghost.btnet.cz>
Date: Sun, 28 Jan 2001 00:01:57 +0100
From: clock@ghost.btnet.cz
To: linux-kernel@vger.kernel.org
Subject: CBQ simply doesn't work
Reply-To: clock@atrey.karlin.mff.cuni.cz
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=XmbgvnjoT4axfJEp
X-Mailer: Mutt 0.84
X-Echameleon: GRU Aquarium Khodinka Vatutinki KGB CIA Putin Suvorov Ladygin FBI NSA IRS whitewater arkanside MOSSAD MI5 ONI CID AK47 M16 C4 wackenhut terrorist task force 160 atomic nuclear Lybia plutonium fission uranium deuterium H-bomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XmbgvnjoT4axfJEp
Content-Type: text/plain; charset=us-ascii

I can't get the CBQ running on 2.2.17. Alexey look like he doesn't reply to his
mails.  I made one more man to check it over me. We both can't find a problem.
The file with config info is attached.

Eager for any idea

Clock


--XmbgvnjoT4axfJEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=qos

This is an excerpt from the kernel configuration:

        [*] QoS and/or fair queueing                      
        <M> CBQ packet scheduler                          
        < > CSZ packet scheduler                          
        <M> The simplest PRIO pseudoscheduler             
        <M> RED queue                                     
        <M> SFQ queue                                     
        <M> TEQL queue                                    
        <M> TBF queue                                     
        [*] QoS support                                   
        [*] Rate estimator                                
        [*] Packet classifier API                         
        <M> Routing table based classifier             
        <M> Firewall based classifier                  
        <M> U32 classifier                             
        <M> Special RSVP classifier                    
        < > Special RSVP classifier for IPv6           
        [*] Ingres traffic policing                    

...
	
        [*] IP: multicasting                 
	[*] IP: advanced router              

This is a script that sets up the qos:

#!/bin/bash
/sbin/insmod cls_fw
/sbin/insmod sch_prio
/sbin/insmod sch_cbq
/sbin/insmod cls__u32
/sbin/insmod cls_rsvp
/sbin/insmod sch_red

tc qdisc add dev ppp0 root handle 10: cbq bandwidth 28Kbit avpkt 1000

tc class add dev ppp0 parent 10:0 classid 10:1 cbq bandwidth 28Kbit rate 28Kbit
allot 1514 weight 28Kbit prio 8 maxburst 20 avpkt 1000

tc class add dev ppp0 parent 10:1 classid 10:100 cbq bandwidth 28Kbit rate 16Kbit allot 1514 weight 16Kbit prio 5 maxburst 20 avpkt 1000
tc class add dev ppp0 parent 10:1 classid 10:200 cbq bandwidth 28Kbit rate 9Kbit allot 1514 weight 9Kbit prio 5 maxburst 20 avpkt 1000
tc class add dev ppp0 parent 10:1 classid 10:300 cbq bandwidth 28Kbit rate 3Kbit allot 1514 weight 3Kbit prio 5 maxburst 20 avpkt 1000

tc qdisc add dev ppp0 parent 10:100 sfq quantum 1514b perturb 15
tc qdisc add dev ppp0 parent 10:200 sfq quantum 1514b perturb 15
tc qdisc add dev ppp0 parent 10:300 sfq quantum 1514b perturb 15

This is what the script says when run just before testing:

root@mspool:~# ./qos
Using /lib/modules/2.2.17/misc/cls_fw.o
insmod: a module named cls_fw already exists
Using /lib/modules/2.2.17/misc/sch_prio.o
insmod: a module named sch_prio already exists
Using /lib/modules/2.2.17/misc/sch_cbq.o
insmod: a module named sch_cbq already exists
insmod: cls__u32: no module by that name found
Using /lib/modules/2.2.17/misc/cls_rsvp.o
insmod: a module named cls_rsvp already exists
Using /lib/modules/2.2.17/misc/sch_red.o
insmod: a module named sch_red already exists


Config listings:

root@mspool:~# tc qdisc show
qdisc sfq 8036: dev ppp0 quantum 1514b perturb 15sec
qdisc sfq 8035: dev ppp0 quantum 1514b perturb 15sec
qdisc sfq 8034: dev ppp0 quantum 1514b perturb 15sec
qdisc cbq 10: dev ppp0 rate 28Kbit (bounded,isolated) prio no-transmit

root@mspool:~# tc class show dev ppp0
class cbq 10: root rate 28Kbit (bounded,isolated) prio no-transmit
class cbq 10:100 parent 10:1 leaf 8034: rate 16Kbit prio 5
class cbq 10:1 parent 10: rate 28Kbit prio no-transmit
class cbq 10:200 parent 10:1 leaf 8035: rate 9Kbit prio 5
class cbq 10:300 parent 10:1 leaf 8036: rate 3Kbit prio 5

root@mspool:~# tc filter show dev ppp0
filter parent 10: protocol ip pref 25 u32 
filter parent 10: protocol ip pref 25 u32 fh 802: ht divisor 1 
filter parent 10: protocol ip pref 25 u32 fh 802::800 order 2048 key ht 802 bkt 0 flowid 10:300 
  match 3e50554d/ffffffff at 16
filter parent 10: protocol ip pref 25 u32 fh 801: ht divisor 1 
filter parent 10: protocol ip pref 25 u32 fh 801::800 order 2048 key ht 801 bkt 0 flowid 10:200 
  match 3e50554c/ffffffff at 16
filter parent 10: protocol ip pref 25 u32 fh 800: ht divisor 1 
filter parent 10: protocol ip pref 25 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 10:100 
  match 3e50554a/ffffffff at 16
filter parent 10: protocol ip pref 50 u32 
filter parent 10: protocol ip pref 50 u32 fh 802: ht divisor 1 
filter parent 10: protocol ip pref 50 u32 fh 802::800 order 2048 key ht 802 bkt 0 flowid 10:300 
  match 3e50554d/ffffffff at 16
filter parent 10: protocol ip pref 50 u32 fh 801: ht divisor 1 
filter parent 10: protocol ip pref 50 u32 fh 801::800 order 2048 key ht 801 bkt 0 flowid 10:200 
  match 3e50554c/ffffffff at 16
filter parent 10: protocol ip pref 50 u32 fh 800: ht divisor 1 
filter parent 10: protocol ip pref 50 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 10:100 
  match 3e50554a/ffffffff at 16
filter parent 10: protocol ip pref 100 u32 
filter parent 10: protocol ip pref 100 u32 fh 802: ht divisor 1 
filter parent 10: protocol ip pref 100 u32 fh 802::800 order 2048 key ht 802 bkt 0 flowid 10:300 
  match 3e50554d/ffffffff at 16
filter parent 10: protocol ip pref 100 u32 fh 801: ht divisor 1 
filter parent 10: protocol ip pref 100 u32 fh 801::800 order 2048 key ht 801 bkt 0 flowid 10:200 
  match 3e50554c/ffffffff at 16
filter parent 10: protocol ip pref 100 u32 fh 800: ht divisor 1 
filter parent 10: protocol ip pref 100 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 10:100 
  match 3e50554a/ffffffff at 16

Problem: I tested running two links browsers at 62.80.85.74 and 62.80.85.76
downloading both the same big file. They behaved just as without the packet
scheduling. Their behaviour was random and they shared the link statistically
about the same. Then I run donload on the .74 and ssh at .76 and usually I had
to wait about a minute to get a connection which showed also it simply didn't
work. Running these things separately indicated there were no other problems
in the way. The packet scheduling simply didn't work.

Kernel:

root@mspool:~# cat /proc/version
Linux version 2.2.17 (root@gam) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Fri Nov 3 13:04:46 CET 2000


--XmbgvnjoT4axfJEp--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
