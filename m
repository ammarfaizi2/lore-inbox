Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWGJQaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWGJQaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422684AbWGJQaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:30:18 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:47671 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422683AbWGJQaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:30:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=He/2DzNNFe0YStwY6lpHrFU24H+UJx5Q0T7ouIEhmReaj1wTojYc03473QgyFf/dhMDckLS/lApushQLTJAUJBceMFu2g77atjv5BV/7zBpaF5v9Lb4oyMAW/JoyRHmrTwfMxfzHi+FXdohJLrfML4FV7700BoGigoA9vMU0Spo=
Message-ID: <44B2808F.8000901@pol.net>
Date: Tue, 11 Jul 2006 00:30:07 +0800
From: "Antonino A. Daplas" <adaplas@pol.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: "Antonino A. Daplas" <adaplas@gmail.com>,
       Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>	<20060705165255.ab7f1b83.khali@linux-fr.org>	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net>	<m3ejwt65of.fsf@defiant.localdomain> <44B248E4.2020506@pol.net>	<m3u05p4mkx.fsf@defiant.localdomain> <44B26004.4050500@gmail.com> <m3r70tqxmt.fsf@defiant.localdomain>
In-Reply-To: <m3r70tqxmt.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> writes:
> 
>> David Eger is the author, the last I heard from him was 2 years ago.
>> But I haven't received that many problem reports on cirrusfb.
> 
> Doesn't matter, what is important is that you know the stuff.
> 
>> The only register touched by the i2c code is EEPROM control (CL_SEQR8).
>> This is never touched by the rest of the cirrusfb code. So I don't
>> think concurrent access is a problem (unless the hardware has restrictions
>> such as no other register accesses are allowed while this register is being
>> accessed).
> 
> I mean I'm using (simplified):

Yes, I realized that.

>>> The framebuffer layer is serialized by
>> acquire_console_sem()/release_console_sem(). If you think concurrent access
>> is a problem, you can always use that.
> 
> It's quite big... While I haven't investigated that, I rather thought
> about some small lock for vga_rseq() and vga_wseq(). Not sure.

Yes, the console semaphore is quite heavy. It's also used to flush the
printk buffer.  Since the framebuffer can be called in any context,
spinlocks may be the least expensive.

> 
> Another thing... How is access to VGA registers shared between
> X11 and the framebuffer?

This is no-man's land.  Basically X grabs the VT with KD_GRAPHICS mode
set.  When in KD_GRAPHICS mode, the framebuffer console will not
send any commands to the drivers. The problem is trying to do
framebuffer operation while in X, we don't have any guards on that.
Just try fbset mymode while in X.

