Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbTAFVNh>; Mon, 6 Jan 2003 16:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267142AbTAFVNh>; Mon, 6 Jan 2003 16:13:37 -0500
Received: from navgwout.symantec.com ([198.6.49.12]:40425 "EHLO
	navgwout.symantec.com") by vger.kernel.org with ESMTP
	id <S267141AbTAFVNg>; Mon, 6 Jan 2003 16:13:36 -0500
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit/SMP performance problem
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.9a  January 7, 2002
Message-ID: <OF5C6328F0.14224996-ON85256CA6.006FDD27-85256CA6.00705A20@symantec.com>
From: "Avery Fay" <avery_fay@symantec.com>
Date: Mon, 6 Jan 2003 15:25:40 -0500
X-MIMETrack: Serialize by Router on USCU-SMTPOB01-1/GLOBE-ADMIN/SYMANTEC(Release 5.0.11
  |July 24, 2002) at 01/06/2003 12:35:40 PM,
	Serialize complete at 01/06/2003 12:35:40 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, I have 4 interfaces in and 4 interfaces out (ideal routing 
setup). I'm using just shy of 1500 byte udp packets for testing.

I tried binding the irqs for each pair of interfaces to a cpu... so for 
example, if eth0 to sending to eth2 they would be bound to the same cpu. 
This seemed to improve performance a little, but I didn't get definite 
numbers and it certainly wasn't much.

I'm currently playing around with UP kernels, but when I go back I'll 
check out softnet_stat

Avery Fay





Robert Olsson <Robert.Olsson@data.slu.se>
01/03/2003 04:20 PM

 
        To:     "Avery Fay" <avery_fay@symantec.com>
        cc:     linux-kernel@vger.kernel.org
        Subject:        Gigabit/SMP performance problem



Avery Fay writes:
 > 
 > I'm working with a dual xeon platform with 4 dual e1000 cards on 
different 
 > pci-x buses. I'm having trouble getting better performance with the 
second 
 > cpu enabled (ht disabled). With a UP kernel (redhat's 2.4.18), I can 
route 
 > about 2.9 gigabits/s at around 90% cpu utilization. With a SMP kernel 
 > (redhat's 2.4.18), I can route about 2.8 gigabits/s with both cpus at 
 > around 90% utilization. This suggests to me that the network code is 
 > serialized. I would expect one of two things from my understanding of 
the 
 > 2.4.x networking improvements (softirqs allowing execution on more than 

 > one cpu):

 Well you have a gigabit router :-)

 How is your routing setup? Packet size?

 Also you'll never get increased performance of a single flow with SMP. 
 Aggregated performance possible at best. I've been fighting with for some 

 time too.

 You have some important data in /proc/net/softnet_stat which are per cpu
 packets received and "cpu collisions" should interest you.

 As far as I understand there no serialization in forwarding path except 
where
 it has to be -- when we add softirq's from different cpu into a single 
device.
 This seen in "cpu collisions"

 Also here we get into inherent SMP cache bouncing problem with TX 
interrupts
 When TX has skb's which are processed/created in different CPU's. Which 
CPU
 gonna take the interrupt? No matter how we do we run kfree we gona see a 
lot 
 of cache bouncing. For systems that have same in/out interface 
smp_affinity
 can be used. In practice this impossible for forwarding.

 And this bouncing hurts especially for small pakets....

 A litte TX test illustrates. Sender on cpu0.

 UP                      186 kpps
 SMP Aff to cpu0         160 kpps
 SMP Aff to cpu0, cpu1   124 kpps
 SMP Aff to cpu1         106 kpps

 We are playing some code that might decrease this problem.


 Cheers.
                 --ro



