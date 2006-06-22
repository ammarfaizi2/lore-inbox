Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbWFVSI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWFVSI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWFVSI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:08:57 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:13482 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932624AbWFVSI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:08:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NXrbeAIEqM8w63UrRHTDKFl6KlIeFOYJAyTpgljbtLYO9/r+J7j0tVF30Z4zkU9JBtM0nnlSNfzmy3If2evjdLiYgMlrpQsHc/0Nda3rZRudKj5wuRDwiNuE+jJbV/ljfTGmT/XVvpW31f5avlbIpm2acPx+y6UfYafIaRs7z9s=
Message-ID: <449ADCB2.4000006@gmail.com>
Date: Fri, 23 Jun 2006 02:08:50 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_VGACON_SOFT_SCROLLBACK crashes 2.6.17
References: <200606211715.58773.a1426z@gawab.com> <200606220005.32446.a1426z@gawab.com> <4499E89F.6030509@gmail.com> <200606222036.45081.a1426z@gawab.com>
In-Reply-To: <200606222036.45081.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Antonino A. Daplas wrote:
>> Al Boldi wrote:
>>> Antonino A. Daplas wrote:
>>>> Al Boldi wrote:
> 
>> Anyway, can you try the patch below.  It's a debugging patch and
>> it will slow down the console.
> 
> Yes, that did the trick, although it screws-up concurrent console access.
> 
> What is surprising though, is that SOFT_SCROLLBACK is supposed to slow the 
> console down.  It actually looks that it speeds things up, albeit at higher 
> CPU cost, by buffering screen updates.
> 
> This maybe hardware related.  This machine has an onboard VIA/S3 UniChrome 
> chip, so I am thinking the CPU is dumping too fast for the chip to sync.
> 

That's what I thought too. But adding delays to the screen accessors is not
the correct fix. The screen buffer accessors, scr_readw() and scr_writew()
make assumptions that are not correct in all cases, that the screenbuffer
is either in system RAM or video RAM, never in both. (vgacon's screenbuffer
is video RAM while the rest of the console drivers have it in system RAM.
But you can have vgacon and fbcon compiled at the same time, for example, and
this basically screws up the screen accessors, especially in non-x86 archs.)

So a revamp of vgacon may be necessary, by placing the screen buffer in
system RAM. This will entail a lot of work, so the revamp will take some
time.

>> If the system hang disappears, remove the line
>>
>>     while (i--);
> 
> Hangs again.

I was hoping that's it's the memcpy() that's buggy when the source/destination
is video RAM.  That would be an easy fix, but it seems I'm out of luck here.

> 
>>> BTW, is there any chance to patch your savagefb to support VIA/S3
>>> UniChrome?
>> If someone posts a patch to lkml or fbdev-devel, why not?  But a separate
>> driver is probably better as the 2 are very different.
> 
> VIA has a separate driver, couldn't this be merged with mainline?

Sure, as long as it's GPL-compatible, properly written, and correctly
Signed-off.

Tony
