Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272552AbRI0M1h>; Thu, 27 Sep 2001 08:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272619AbRI0M12>; Thu, 27 Sep 2001 08:27:28 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:8408 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S272552AbRI0M1J>; Thu, 27 Sep 2001 08:27:09 -0400
Message-ID: <3BB319ED.5020406@antefacto.com>
Date: Thu, 27 Sep 2001 13:22:05 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: CPU frequency shifting "problems"
In-Reply-To: <Pine.LNX.4.33.0109261123380.8558-100000@penguin.transmeta.com> <Pine.LNX.4.30.0109262036480.8655-100000@Appserv.suse.de> <9ot9bm$8gu$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Linus Torvalds wrote:

>In article <Pine.LNX.4.30.0109262036480.8655-100000@Appserv.suse.de>,
>Dave Jones  <davej@suse.de> wrote:
>
>>On Wed, 26 Sep 2001, Linus Torvalds wrote:
>>
>>>>>cpuid: 72 cycles
>>>>>
>>>>cpuid: 79 cycles
>>>>Only slightly worse, but I'd not expected this.
>>>>
>>>That difference can easily be explained by the compiler and options.
>>>
>>Actually repeated runs of the test on that box show it deviating by up
>>to 10 cycles, making it match the results that Alan posted.
>>-O2 made no difference, these deviations still occur. They seem more
>>prominent on the C3 than other boxes I've tried, even with the same
>>compiler toolchain.
>>
>
>Does the C3 do any kind of frequency shifting?
>
Not automatic, but you can set the multiplier dynamically by setting the 
msr.
Russell King has been working on an arch independent framework for this
kind of thing and support for the C3 has recently been added by Dave Jones.
The code is available @:
cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot login
cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot co cpufreq

>
>For example, on a transmeta CPU, the TSC will run at a constant
>"nominal" speed (the highest the CPU can go), although the real CPU
>speed will depend on the load of the machine and temperature etc.
>
As does the P4 from what I understand. So a question..
What are the software dependencies on this auto/manual frequency shifting?
The code referenced above scales jiffies appropriately when a manual
frequency change is requested. I'm not sure about the possible consequences
of this for e.g. could there be races introduced with various busy loop 
locking etc.
A quick check for the use of jiffies in the kernel:
[padraig@pixelbeat linux]$ find -name "*.[ch]" | xargs grep jiffies | wc -l
   3992

Also with the auto shifting of the transmeta/P4, wont this invalidate 
the jiffies
value? Also how does this affect the rtLinux guys (and realtime software
in general).

cheers,
Padraig.

>  So on
>a crusoe CPU you'll see varying speeds (and it depends on the speed
>grade, because that in turn depends on how many longrun steps are being
>actively used). 
>
>For example, on a mostly idle machine I get
>
>	torvalds@kiwi:~ > ./a.out 
>	nothing: 54 cycles
>	locked add: 54 cycles
>	cpuid: 91 cycles
>
>while if I have another window that does an endless loop to keep the CPU
>busy, the _real_ frequency of the CPU scales up, and the machine
>basically becomes faster:
>
>	torvalds@kiwi:~ > ./a.out 
>	nothing: 36 cycles
>	locked add: 36 cycles
>	cpuid: 54 cycles
>
>(The reason why the "nothing" TSC read is expensive on crusoe is because
>of the scaling of the TSC - rdtsc literally has to do a floating point
>multiply-add to scale the clock to the right "nominal" frequency.  Of
>course, "expensive" is still a lot less than the inexplicable 80 cycles
>on a P4). 
>
>(That's a 600MHz part 
>going down to to 400MHz in idle, btw)
>
>On a 633MHz part (I don't actually have access to any of the high speed
>grades ;) it ends up being 
>
>fast:
>	nothing: 39 cycles
>	locked add: 40 cycles
>	cpuid: 68 cycles
>
>slow: 
>	nothing: 82 cycles
>	locked add: 84 cycles
>	cpuid: 122 cycles
>
>which corresponds to a 633MHz part going down to 300MHz in idle.
>
>And of course, you can get pretty much anything in between, depending on
>what the load is...
>
>		Linus
>




