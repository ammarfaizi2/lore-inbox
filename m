Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267663AbTACVDN>; Fri, 3 Jan 2003 16:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267666AbTACVDN>; Fri, 3 Jan 2003 16:03:13 -0500
Received: from robur.slu.se ([130.238.98.12]:65042 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S267663AbTACVDM>;
	Fri, 3 Jan 2003 16:03:12 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15893.65155.49072.307843@robur.slu.se>
Date: Fri, 3 Jan 2003 22:20:03 +0100
To: "Avery Fay" <avery_fay@symantec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Gigabit/SMP performance problem
In-Reply-To: <OFC4D9AF0E.DA93F4D7-ON85256CA3.0058C567-85256CA3.00592873@symantec.com>
References: <OFC4D9AF0E.DA93F4D7-ON85256CA3.0058C567-85256CA3.00592873@symantec.com>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avery Fay writes:
 > 
 > I'm working with a dual xeon platform with 4 dual e1000 cards on different 
 > pci-x buses. I'm having trouble getting better performance with the second 
 > cpu enabled (ht disabled). With a UP kernel (redhat's 2.4.18), I can route 
 > about 2.9 gigabits/s at around 90% cpu utilization. With a SMP kernel 
 > (redhat's 2.4.18), I can route about 2.8 gigabits/s with both cpus at 
 > around 90% utilization. This suggests to me that the network code is 
 > serialized. I would expect one of two things from my understanding of the 
 > 2.4.x networking improvements (softirqs allowing execution on more than 
 > one cpu):

 Well you have a gigabit router :-)

 How is your routing setup? Packet size?

 Also you'll never get increased performance of a single flow with SMP. 
 Aggregated performance possible at best. I've been fighting with for some 
 time too.

 You have some important data in /proc/net/softnet_stat which are per cpu
 packets received and "cpu collisions" should interest you.

 As far as I understand there no serialization in forwarding path except where
 it has to be -- when we add softirq's from different cpu into a single device.
 This seen in "cpu collisions"

 Also here we get into inherent SMP cache bouncing problem with TX interrupts
 When TX has skb's which are processed/created in different CPU's. Which CPU
 gonna take the interrupt? No matter how we do we run kfree we gona see a lot 
 of cache bouncing. For systems that have same in/out interface smp_affinity
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
