Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317977AbSGaK6g>; Wed, 31 Jul 2002 06:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSGaK6f>; Wed, 31 Jul 2002 06:58:35 -0400
Received: from sunny.pacific.net.au ([203.25.148.40]:28401 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S317977AbSGaK6f>; Wed, 31 Jul 2002 06:58:35 -0400
From: "David Luyer" <david@luyer.net>
To: <linux-kernel@vger.kernel.org>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Date: Wed, 31 Jul 2002 21:01:45 +1000
Message-ID: <00b601c23881$a8dfa180$638317d2@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> In Linux 2.4.19ac3rc3 on IBM x330/x340 SMP systems we're seeing this:
> 
> luyer@praxis8:~$ ps auxwww | tail -1
> luyer     1025  0.0  0.0  1276  352 pts/2    S    Aug06   0:00 tail -1
> luyer@praxis8:~$ date
> Wed Jul 31 12:35:16 EST 2002

(UP systems are fine, SMP have this problem)

Reason:

luyer@praxis8:~$ ps --info 2>&1 | grep Hertz
EUID=111 TTY=136,3 Hertz=50

procps is getting the hertz value wrong, it's computing it as:

  h = (unsigned long)( (double)jiffies/seconds/smp_num_cpus );

but we're only getting timer interrupts on CPU 0, and hence
jiffies is only incrementing once per 100th of a second.

luyer@praxis8:~/procps/procps-2.0.7.orig/proc$ cat /proc/interrupts
           CPU0       CPU1
  0:   52459351          0  local-APIC-edge  timer
  1:          0          2    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 24:     883655     863043   IO-APIC-level  ips
 26:          7          9   IO-APIC-level  aic7xxx
 27:          8          8   IO-APIC-level  aic7xxx
 28:   97880608   96542591   IO-APIC-level  eth0
NMI:          0          0
LOC:   52456889   52456887
ERR:          0
MIS:          0

procps version is 2.0.7 (Debian 3.0).

Where's the mistake -- should timer interrupts be on both
CPUs (I think this is the problem), or is procps miscalculating
Hz (seems less likely, someone would have noticed by now...)?

David.

