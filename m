Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288870AbSBILqB>; Sat, 9 Feb 2002 06:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288878AbSBILpv>; Sat, 9 Feb 2002 06:45:51 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:56797 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288870AbSBILpe>; Sat, 9 Feb 2002 06:45:34 -0500
Date: Sat, 9 Feb 2002 12:45:29 +0100
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: ingress policing still not working in 2.4?
Message-ID: <20020209114529.GA6753@links2linux.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.17 i586
X-Editor: VIM 6.0
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Is ingress policing not working in the current Kernel?

I'm using the Script from the Advanced Routing HOWTO
(Thanks for that BTW!)

While trying to do a

# tc qdisc add dev ppp0 handle ffff: ingress

I get this:
RTNETLINK answers: No such file or directory


Before that I successfully did this:
# install root CBQ
DEV=ppp0
UPLINK=100
DOWNLINK=750
tc qdisc add dev $DEV root handle 1: cbq avpkt 1000 bandwidth 100mbit

tc class add dev $DEV parent 1: classid 1:1 cbq rate ${UPLINK}kbit \
allot 1500 prio 5 bounded isolated

tc class add dev $DEV parent 1:1 classid 1:10 cbq rate ${UPLINK}kbit \
   allot 1600 prio 1 avpkt 1000

tc class add dev $DEV parent 1:1 classid 1:20 cbq rate $[9*$UPLINK/10]kbit \
   allot 1600 prio 2 avpkt 1000

tc qdisc add dev $DEV parent 1:10 handle 10: sfq perturb 10
tc qdisc add dev $DEV parent 1:20 handle 20: sfq perturb 10

tc filter add dev $DEV parent 1:0 protocol ip prio 10 u32 \
      match ip tos 0x10 0xff  flowid 1:10

tc filter add dev $DEV parent 1:0 protocol ip prio 11 u32 \
        match ip protocol 1 0xff flowid 1:10

tc filter add dev $DEV parent 1: protocol ip prio 12 u32 \
   match ip protocol 6 0xff \
   match u8 0x05 0x0f at 0 \
   match u16 0x0000 0xffc0 at 2 \
   match u8 0x10 0xff at 33 \
   flowid 1:10

tc filter add dev $DEV parent 1: protocol ip prio 13 u32 \
   match ip dst 0.0.0.0/0 flowid 1:20


I have crawled the archives and found some mails describing this
problem but I did not find any solution. Some of the mails were
from year 2000...

So does anybody know a solution for that Problem?

I'm using Kernel 2.4.17 with everything <M>'ed or [*]'ed in
QoS-Setup.

The Docu says something about the module would be called cls_ingress.o 
but there is only sch_ingress.o. Is this a Docu-Bug BTW?

All sch_* modules seem to load perfectly.

regards
-Marc

-- 
BUGS My programs  never  have  bugs.  They  just  develop  random
     features.  If you discover such a feature and you want it to
     be removed: please send an email to bug@links2linux.de 
