Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTLLEjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 23:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbTLLEjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 23:39:40 -0500
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:58852 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264479AbTLLEjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 23:39:37 -0500
Message-ID: <3FD94681.3090008@nova.org>
Date: Thu, 11 Dec 2003 23:39:29 -0500
From: Ken <ken@nova.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-US
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4][PATCH] Xeon HT - SMT+SMP interrupt balancing
References: <3FD89EF5.30101@nova.org> <1071161984.5219.4.camel@laptop.fenrus.com>
In-Reply-To: <1071161984.5219.4.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 1) This got fixed in version 0.07

	Thank you, Arjan -- let's see how it does.  Hmm, I see you added a 
ROTATE policy for timer.  Ok, I edited your classify.c to add my storage 
controller -- just to ensure everything is properly classified.

I get this result:

            CPU0       CPU1       CPU2       CPU3
   0:       7502      48699      48048      49595    IO-APIC-edge  timer
   1:          2          0          0          0    IO-APIC-edge  keyboard
   2:          0          0          0          0          XT-PIC  cascade
   8:          1          0          0          0    IO-APIC-edge  rtc
  15:          4          0          0          1    IO-APIC-edge  ide1
  16:          0          0          0          0   IO-APIC-level  usb-uhci
  19:          0          0          0          0   IO-APIC-level  usb-uhci
  24:   21061496          0          0          0   IO-APIC-level  eth3
  27:         21          0        732          0   IO-APIC-level  eth2
  31:        374      11363          0          0   IO-APIC-level  eth0
  48:       2716          0       1328        566   IO-APIC-level  dpti0
NMI:          0          0          0          0
LOC:     153702     153699     153699     153635
ERR:          0
MIS:          0

	So, the timer now migrates, but IRQ 24 isn't even shared by the 
sibling, let alone the other "pair".  Well, all these interfaces are 
GigE -- 2 fiber, 2 copper -- so, I re-classified "eth" as GIGE and 
didn't see any improvement; however, if I follow your policy correctly, 
shouldn't the sibling get some usage in either case?

	In any case, I consider the above behavior undesirable over time. CPU0 
is handling most of the system while CPU1 contributes little.   For 
example, this snapshot:
top - 23:11:16 up 12 min,  1 user,  load average: 0.26, 0.35, 0.19
Tasks:  49 total,   3 running,  46 sleeping,   0 stopped,   0 zombie
Cpu0 :   0.8% user,  34.8% system,   0.0% nice,  64.4% idle
Cpu1 :   0.0% user,   0.0% system,   0.0% nice, 100.0% idle
Cpu2 :  15.5% user,   4.1% system,   0.0% nice,  80.5% idle
Cpu3 :   6.7% user,   2.4% system,   0.0% nice,  90.9% idle
Mem:   2068752k total,   477636k used,  1591116k free,     5156k buffers
Swap:  2097136k total,        0k used,  2097136k free,    36720k cached

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND
     3 root      19  19     0    0    0 R  0.0  0.0   0:00.21  0 
ksoftirqd_CPU0
  1206 nobody    15   0  359m 359m 1724 R 29.3 17.8   3:33.23  3 ntop
  1221 root      12   0   992  992  816 R  0.4  0.0   0:00.94  2 top
     1 root       9   0   228  228  196 S  0.0  0.0   0:09.40  3 init


	I appreciate your help, Arjan.  Am I missing something?

> 2) You are talking a whopping 100 irq's per second, which is like about
> no interrupts... I doubt you can find a scenario where 100 irq's per
> second matter.... ;)

	If I understand you correctly, I agree 100/s is negligible.  But, I 
think I see more than that on this lightly loaded machine:
'vmstat 1'
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  1  0      0 1569188   5708  36728    0    0    11     3 3464  4614  6 
11 83  0
  0  0      0 1569184   5708  36728    0    0     0     0 14560 23163  6 
10 84  0
  0  0      0 1569184   5708  36728    0    0     0     0 14284 23734  8 
11 81  0
  1  0      0 1569184   5708  36728    0    0     0     0 14292 23617  5 
10 85  0
  0  0      0 1569160   5732  36728    0    0     0    64 14426 23771  6 
12 82  0


	Again, am I missing something?

Thanks again,
Ken Beaty
-- 
ken@nova.org                                   /     /  /|   /  /  / | /
GPG KeyID: 09209FA2 (on KeyServer)            /     /  / |  /  /  /  |/
http://members.nova.org/~ken/index.html      /     /  /  | /  /  /  /|
Running Slackware 8.0 & SMP kernel 2.4.23.../___ _/_ /   |/  /__/  / |

