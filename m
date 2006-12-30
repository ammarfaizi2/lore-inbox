Return-Path: <linux-kernel-owner+w=401wt.eu-S1751738AbWL3LUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWL3LUE (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 06:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbWL3LUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 06:20:04 -0500
Received: from smtp12.orange.fr ([193.252.22.20]:8941 "EHLO smtp12.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738AbWL3LUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 06:20:02 -0500
X-ME-UUID: 20061230111959809.C59351C00092@mwinf1201.orange.fr
Message-ID: <45964B5E.2010909@free.fr>
Date: Sat, 30 Dec 2006 12:19:58 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.7) Gecko/20060405 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Rene Herman <rene.herman@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
References: <4592E685.5000602@gmail.com> <45950DD1.2010208@free.fr> <4595679F.6070905@gmail.com> <200612300025.06088.dtor@insightbb.com> <45961358.2010906@gmail.com>
In-Reply-To: <45961358.2010906@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30.12.2006 08:20, Rene Herman a écrit :
> Dmitry Torokhov wrote:
> 
>> Somehow you get 2 ACks in a row, I wonder if on your boxes i8042
>> pumps command and data into keyboard before i8042_interrupt gets a
>> chance to run. Could you please apply the debug patch below and tell
>> me the pattern of the data flow.
> 
> Yes, I believe the below trace confirms what you said? Both the ED and 
> the 00/05 are sent before the first ACK gets back, by a 1 jiffie margin:
> 
> drivers/input/serio/i8042.c: ed -> i8042 (panic blink) [N]
> drivers/input/serio/i8042.c: 05 -> i8042 (panic blink) [N + 2]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [N + 3]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [N + 6]
> drivers/input/serio/i8042.c: ed -> i8042 (panic blink) [M]
> drivers/input/serio/i8042.c: 00 -> i8042 (panic blink) [M + 2]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [M + 3]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [M + 6]
> 
> The +2, +3 and +6 are constant. Forgot to pay attention to M - N, but I 
> suppose it's not too important.
> 
> For me, the patch as you posted it is actually good to go. No more 
> spurious ACK complaints...
> 
> Thanks,
> Rene.

Hi Dmitry, Rene

I can confirm Rene's report: this patch works fine since there is no more "Spurious 
ACK on isa0060/serio0" message.

Here is a debug output as requested:

 <0>Kernel panic - not syncing: Fatal exception in interrupt
 <7>drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, 0, 1) [49602]
drivers/input/serio/i8042.c: 93 <- i8042 (interrupt, 0, 1) [49603]
drivers/input/serio/i8042.c: ed -> i8042 (panic blink) [49728]
drivers/input/serio/i8042.c: 05 -> i8042 (panic blink) [49729]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [49730]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [49732]
drivers/input/serio/i8042.c: ed -> i8042 (panic blink) [49856]
drivers/input/serio/i8042.c: 00 -> i8042 (panic blink) [49857]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [49858]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [49860]
drivers/input/serio/i8042.c: ed -> i8042 (panic blink) [49983]
drivers/input/serio/i8042.c: 05 -> i8042 (panic blink) [49985]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [49986]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [49988]
drivers/input/serio/i8042.c: ed -> i8042 (panic blink) [50112]
drivers/input/serio/i8042.c: 00 -> i8042 (panic blink) [50114]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [50115]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [50117]

thanks
-- 
laurent
