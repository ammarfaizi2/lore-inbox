Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283777AbRLMJic>; Thu, 13 Dec 2001 04:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283782AbRLMJiW>; Thu, 13 Dec 2001 04:38:22 -0500
Received: from david.siemens.de ([192.35.17.14]:60382 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S283766AbRLMJiJ>;
	Thu, 13 Dec 2001 04:38:09 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel@vger.kernel.org
Subject: APM idle problems - how to check if BIOS halts CPU?
Date: Thu, 13 Dec 2001 12:37:56 +0300
Message-ID: <000801c183b9$d8eaf5f0$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many people (me including) are bothered by monitoring tools like
gkrellm/top showing kapm_idled consuming excessive amount CPU time
(reports vary from 50% to 70%). In my case I was concerned by the fact
that CPU was *not* cooled, the temperature stayed above minimal value
even when system was completely idle (it did not rocket up still it was
noticeably above low limit).

The only possible explanation to me was that BIOS neither slows nor
halts CPU. I have ASUS CUSL2 motherboard (BIOS 1011 beta 5) that reports
that it does not slow CPU (bit 2 == 0), so I tried to check if CPU was
really halted.

If I understand it correctly, if BIOS halts CPU during Idle call and no
other activity takes place it is clock interrupt that resumes CPU
activity. In this case jiffies should be advanced, because we return
into apm_do_idle() after clock interrupt has finished. I tried to count
number of times when jiffies stayed the same in apm_do_idle() and hot
nice result - in 99.9% of calls to apm_do_idle() jiffies value did not
change after return fro BIOS Idle call.

Then I tried to replace call to apm_do_idle() with call to
apm_cpu_idle() that directly executes HLT instead of calling BIOS. Lo
and behold - I got expected picture of cool CPU and 0% CPU time during
idle times.

Unfortunately, APM does not specify any way to find out if BIOS halts
CPU or simply does nothing. It may also be a BIOS bug, because with
original apm_do_idle() I _sometimes_ got the same picture (cooled CPU
and 0% CPU usage), so it seems that sometimes BIOS correctly does its
job. Still, as it seems to be broken most of the time, I thought about
adding run-time parameter to use apm_cpu_idle() instead. Would such
patch be acceptable? 

TIA

-andrej
