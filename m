Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314936AbSDVX33>; Mon, 22 Apr 2002 19:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSDVX32>; Mon, 22 Apr 2002 19:29:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:775 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314936AbSDVX3X>; Mon, 22 Apr 2002 19:29:23 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Initial process CPU state was Re: SSE related security hole
Date: Mon, 22 Apr 2002 23:28:21 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aa26al$1gk$1@penguin.transmeta.com>
In-Reply-To: <9287DC1579B0D411AA2F009027F44C3F171C1A9E@FMSMSX41> <m3ofgbcppe.fsf@averell.firstfloor.org>
X-Trace: palladium.transmeta.com 1019518127 26993 127.0.0.1 (22 Apr 2002 23:28:47 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 22 Apr 2002 23:28:47 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m3ofgbcppe.fsf@averell.firstfloor.org>,
Andi Kleen  <ak@muc.de> wrote:
>
>Could you quickly describe what the Intel recommended way is to clear
>the whole CPU at the beginning of a process? Is there a better way
>than "save state with fxsave at bootup and restore into each
>new process"?

Note that I will _not_ accept a patch that does the "fxsave at bootup"
thing, because since Linux doesn't actually control the bootup, and
since it gets more an dmore likely that the BIOS will actually use the
SSE etc registers, a boot-time "fxsave" will mean that different
machines will have potentially quite different process initialization. 

In fact, even the same machine might act differently depending on how it
was booted up (ie warm vs cold vs resume boot, different BIOS path due
to different BIOS options etc). 

Now, that wouldn't be a security hole per se, but it would be hell to
debug problems ("My other machine that is identical doesn't show that
bug").

Basically there _needs_ to be an architected way to ensure that the FP
data is in a known and valid state.

(The "fxsave early" approach results in a valid - but not known -
state). 

>Another way would be to do a fxsave after clearing of known state (x87,MMX,
>SSE) at OS bootup and then afterwards set all the so far reserved parts of the 
>FXSAVE image to zero.

This is basically what we do right now (ie as of 2.5.9, just released). 

Except we set it to zero before, since the state we _do_ know about (ie
current x87, MMX, SSE) is initialized to exactly the state you mention
(by hand), and then the rest is just initialized to zero. 

		Linus
