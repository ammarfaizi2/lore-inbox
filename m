Return-Path: <linux-kernel-owner+w=401wt.eu-S1030284AbWL3HWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWL3HWZ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 02:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWL3HWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 02:22:25 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:38613 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030284AbWL3HWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 02:22:25 -0500
Message-ID: <45961358.2010906@gmail.com>
Date: Sat, 30 Dec 2006 08:20:56 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: Laurent Riffard <laurent.riffard@free.fr>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
References: <4592E685.5000602@gmail.com> <45950DD1.2010208@free.fr> <4595679F.6070905@gmail.com> <200612300025.06088.dtor@insightbb.com>
In-Reply-To: <200612300025.06088.dtor@insightbb.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

> Somehow you get 2 ACks in a row, I wonder if on your boxes i8042
> pumps command and data into keyboard before i8042_interrupt gets a
> chance to run. Could you please apply the debug patch below and tell
> me the pattern of the data flow.

Yes, I believe the below trace confirms what you said? Both the ED and 
the 00/05 are sent before the first ACK gets back, by a 1 jiffie margin:

drivers/input/serio/i8042.c: ed -> i8042 (panic blink) [N]
drivers/input/serio/i8042.c: 05 -> i8042 (panic blink) [N + 2]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [N + 3]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [N + 6]
drivers/input/serio/i8042.c: ed -> i8042 (panic blink) [M]
drivers/input/serio/i8042.c: 00 -> i8042 (panic blink) [M + 2]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [M + 3]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [M + 6]

The +2, +3 and +6 are constant. Forgot to pay attention to M - N, but I 
suppose it's not too important.

For me, the patch as you posted it is actually good to go. No more 
spurious ACK complaints...

Thanks,
Rene.

