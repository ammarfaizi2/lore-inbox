Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWCOIsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWCOIsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 03:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWCOIsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 03:48:50 -0500
Received: from cernmx07.cern.ch ([137.138.166.171]:42792 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1750919AbWCOIsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 03:48:50 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=VYnoJomevj1Qwcra241Op1qy9Rq3tYSZh2m+iXQlZiqgHnFy4jY2TxlZ4/ScEAh77+HlgEqbNHnWOomwNjIA1Indye1xhFrHJA3gKnQ9kzYOOGBLu7+BoG8vO3v+sQ1B;
Keywords: CERN SpamKiller Note: -51 Charset: west-latin
X-Filter: CERNMX07 CERN MX v2.0 051012.1312 Release
Message-ID: <4417D4ED.6010808@cern.ch>
Date: Wed, 15 Mar 2006 09:48:45 +0100
From: Jiri Tyr <jiri.tyr@cern.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060128)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sami Farin <7atbggg02@sneakemail.com>
CC: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
References: <440C5672.7000009@cern.ch> <200603061656.18846.duncan.sands@math.u-psud.fr> <440D7384.5030307@cern.ch> <200603071332.19614.baldrick@free.fr>
In-Reply-To: <200603071332.19614.baldrick@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2006 08:48:43.0525 (UTC) FILETIME=[43C2C350:01C6480D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think, it's problem in XAWTV, because I've got the same error if I
had only one TV tuner in my PC. I've solved the problem that I reduced
number of items in channel list. If I have in the list only 10
channels, then any of the four XAWTV didn't crashed. It's very
strange. It looks like the pop-up menu with the channel list write to
the memory of the graphics card somewhere out of the memory. What do
you think about it?

Jiri


Sami Farin wrote:
 >On Sat, Mar 11, 2006 at 11:08:25AM +0100, Bodo Eggert wrote:
 >> Duncan Sands <duncan.sands@math.u-psud.fr> wrote:
 >>
 >> >> The bttv driver/chip seems to cause random memory corruption 
sometimes,
 >> >> processes will just start dying...
 >> >
 >> > There is a known buffer overflow in the bttv driver (when using
 >> > grabdisplay).  The fix is waiting on an audit of the rest of the
 >> > bttv (and similar) code, since it looks like the same mistake
 >> > occurs in several places.
 >>
 >> Can you give me a hint on where exactly to shoot at? I'n still 
hoping it's
 >> not my VIA board giving me trouble (corrupting the first four bytes of a
 >> semi-random page).
 >
 >check out this email to LKML
 >
 >it might not be the Final Fix, but xawtv hasn't crashed on me yet
 >
 >From:    Duncan Sands <duncan.sands@math.u-psud.fr>
 >Subject: [PATCH] bttv: correct bttv_risc_packed buffer size
 >Date:    Wed, 25 Jan 2006 11:24:27 +0100
 >Cc:    Linux Kernel list <linux-kernel@vger.kernel.org>
 >MIME-Version: 1.0
 >Content-Type: Multipart/Mixed;
 > boundary="Boundary-00=_cH11D22lqYSaiQl"
 >Message-Id: <200601251124.28392.duncan.sands@math.u-psud.fr>
 >
 >
 >This patch fixes the strange crashes I was seeing after using
 >my bttv card to watch television.  They were caused by a
 >buffer overflow in bttv_risc_packed.
 >
 >The instruction buffer size calculation contains two errors:
 >(a) a non-zero padding value can push the start of the next bpl
 >section to just before a page border, leading to more scanline
 >splits and thus additional instructions.
 >(b) the first DMA region can be smaller than one page, so there can
 >be a scanline split even if bpl*lines is smaller than PAGE_SIZE.
 >
 >For example, consider the case where offset is 0, bpl is 2, padding
 >is 4094, lines is smaller than 2048, the first DMA region has size 1
 >and all others have size PAGE_SIZE, assumed to equal 4096.  Then
 >all bpl regions cross page borders and the number of instructions
 >written is 2*lines+2, rather than lines+2 (the current estimate).
 >With this patch the number of instructions for this example is
 >estimated to be 2*lines+3.
 >
 >Also, the BUG_ON that was supposed to catch buffer overflows contained
 >a thinko causing it fire only if the buffer was overrun by a factor of
 >16 or more.
 >
 >I didn't check whether similar mistakes exist elsewhere in the bttv
 >code.
 >
 >Signed-off-by: Duncan Sands <baldrick@free.fr>
 >
 >PS: I'm sending the patch as an attachment because for some reason my
 >mailer crashes if I try to insert it into the email.
