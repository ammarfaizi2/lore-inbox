Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTHBTpO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTHBTpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:45:14 -0400
Received: from pop.gmx.net ([213.165.64.20]:47580 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263861AbTHBTpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:45:09 -0400
Message-ID: <3F2C14BF.9060505@gmx.de>
Date: Sat, 02 Aug 2003 21:45:03 +0200
From: Carsten Otto <c-otto@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030727
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: e1000 statistics timer
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
I own two Intel Gigabit cards running with the e1000 driver.
The only problem is the statistics for ifconfig (RX bytes, TX bytes) and 
for other programs like gkrellm, bwmon, ... are only updated every _two_ 
seconds.
This results in a strange display. When the real traffic is at constant 
10MB/sec every program displays:
"0 - 20MB/sec - 0 - 20MB/sec - ..."
So, every two seconds the total of the last two seconds. Between that 
just nothing.

After a while I got too annoyed and tried to change that.
In e1000_main.c you can find the line (number 1424):

"mod_timer(&adapter->watchdog_timer, jiffies + 2* HZ);"

I don't really understand driver programming, but HZ is 100 and means 1 
second.
Changing this line to "... + 1* HZ" resulted  in a better behaviour. I 
got "a - b - c - d - 0 - e - f  - g - h - 0 - ..." where the letters are 
quite correct numbers, every fifth value is zero.
The next step was deleting these "jiffies" (what are these?).
Final result:

"mod_timer(&adapter->watchdog_timer, HZ);"

With this line (and the new kernel of course) I get everything what I 
need. All programs display the bandwith like they do with my other NICs.

Now my questions:
1) Is my implementation right? It works...
2) Can I change that delay to 1 sec withhout "hurting someone"?
3) What are these jiffies? Mathematically they are about 20 :>
4) There are other timers in the code, that use "jiffies + 2 * HZ" too. 
Should they  be changed, too?

IMPORTANT:
Please answer to c-otto@gmx.de, because I don't get the whole LKML.

Thanks,
Carsten Otto

PS:
My kernel is 2.4.20 wolk4.2s
CPUs are Durons

