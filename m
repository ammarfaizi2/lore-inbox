Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbUK0DBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbUK0DBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbUK0DBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:01:16 -0500
Received: from mail.dnm.gov.ar ([200.55.54.66]:25227 "EHLO mail.dnm.gov.ar")
	by vger.kernel.org with ESMTP id S262898AbUK0C5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 21:57:31 -0500
Message-ID: <41A7EDA1.5000609@migraciones.gov.ar>
Date: Fri, 26 Nov 2004 23:59:45 -0300
From: Javier Villavicencio <javierv@migraciones.gov.ar>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: no entropy and no output at /dev/random  (quick question)
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i've just suscribed from work to the list (now my boss will have to 
buy a new server :+)

The quick question/problem follows:

I have a server that runs kernel 2.6.9, some web and monitoring 
services, it's connected to two different networks with two different 
network cards, and somehow a php developer discovered that /dev/random 
wasn't giving any entropy to him (O_O) so i checked it out...

the (BUG??) follows:
(via ssh, i have no keyboard there)

# cat /dev/random (5 minutes, the server working, nothing)
ctrl+c
# cat /dev/urandom
<snip> (lots of randomness)

then I went to /proc/sys/kernel/random
# /proc/sys/kernel/random
# cat entropy_avail
0
# OMG!
-bash: OMG1: command not found

O_O. No entropy available. WTF??

Then i did a little search in the whole source directory of the kernel 
(looking for entropy sources) and I've found that NONE OF MY (interrupts 
  generating) HARDWARE was (contributing??) helping with the entropy.

This is the (little) summary of the "working" stuff.
* 3Com Corporation 3c905B 100BaseTX (driver 3c59x.c doesn't give any 
entropy).
* Intel Corp. 82557/8/9 [Ethernet Pro 100] (driver eepro100.c o_O)
* Mylex Corporation DAC960PRL (driver DAC960.c neither)

So and this is the /proc/interrupts output:
   0:    2991777         15    IO-APIC-edge  timer
   2:          0          0          XT-PIC  cascade
   5:     434913          1   IO-APIC-level  eth0
   8:          2          0    IO-APIC-edge  rtc
   9:     383701          0   IO-APIC-level  eth1
  10:        101          0   IO-APIC-level  sym53c8xx
  11:          0          0   IO-APIC-level  uhci_hcd
  15:      14543          1   IO-APIC-level  Mylex DAC960PG

As you may see my only sources of entropy where the timer, eth0, eth1 
and the DAC960.
So I patched my 3 drivers (near request_irq, sending SA_SAMPLE_RANDOM | 
SA_SHIRQ in the call).
Now I have entropy :+):

# cat /proc/sys/kernel/random/entropy_avail
4096

The quick question (at last), is this "right?" I mean, everything works 
as before, no problems (so far) and the php developer is happy. It is 
"risky" to put this in the DAC960 driver? (seems pretty much complicated 
compared with others i've touched in my life)

Thanks for any advice.
