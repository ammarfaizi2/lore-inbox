Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTJGNq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTJGNq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:46:26 -0400
Received: from gemini.smart.net ([205.197.48.109]:58637 "EHLO gemini.smart.net")
	by vger.kernel.org with ESMTP id S262223AbTJGNqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:46:24 -0400
Message-ID: <3F82C3B2.A764EA6D@smart.net>
Date: Tue, 07 Oct 2003 09:46:26 -0400
From: "Daniel B." <dsb@smart.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18+dsb+smp+ide i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA errors, massive disk corruption: Why? Fixed Yet? Whynotre-do 
 failed op?
References: <Pine.LNX.4.44.0310071250450.3492-100000@gatemaster.ivimey.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:
> 
> On Tue, 7 Oct 2003, Valdis.Kletnieks@vt.edu wrote:
> ...
> But surely what Daniel is complaining about is that the disk never did ack the
> bus transfer.

Yes, much closer to what I meant.  

Actually, I'd talking about when the kernel doesn't receive the 
acknowledgment (the DMA  interrupt).


> 
> Consider this as a correct sequence of operations (hope I get it right:-) :
> 
> 1.   Kernel uses IDE controller to initiate ATA disk write request:
...
> 2.   IDE controller DMA used to transfer data to disk unit:
...
> 3.   Transfer complete actions: when the required number of words are acked:
>      a. IDE DMA controller fires end-of-transfer IRQ
>      b. ...
> 
> 4.   Kernel sees end of transfer IRQ and initiates software ACK of transfer,
>      e.g. to remove DMA buffer from 'block dirty' list.
> 
> 5.   If caching enabled, some time later the data in the drive is written to
>      the platter.
> 
> Now, the case I believe Daniel is complaining about is that things go well
> through step 1 and perhaps some part of step 2. But, because the drive doesn't
> accept the data or some other error, step 3 doesn't happen. 

Actually, I think I'm talking about the very beginning of step 4--
the interrupt request doesn't actually make it to the kernel ("interrupt
lost"?), so the kernel doesn't see the interrupt request.

(I've been assuming that the errors I'm getting are just from DMA 
interrupt problems, that is, the drive accepted the data just fine, but 
the kernel didn't see the acknowledgement.  Of course, it's not clear
how that in itself would cause corruption, so I don't know for sure
that drive-side errors or rejections aren't involved.)


> Consequently, the
> IDE DMA timeout happens, the kernel cries foul and things go wrong. So the
> failure actually looks like this:
> 
> 1.   Kernel uses IDE controller to initiate ATA disk write request:
>      a. Kernel sets up DMA parameters (start, length, timeout)
>      b. kernel initiates transfer of 1 sector to disk
>      c. (in parallel with b) drive accepts transfer request and waits for data
> 
> 2.   IDE controller DMA used to transfer data to disk unit:
>      a. hardware DMA tries to send 256 16-bit words of data to disk
>      b. (in parallel) drive accepts none or, perhaps, some data from bus into
>         internal buffer, but not all of it.
> 
> 3.   After waiting, IDE controller fires DMA timeout IRQ.
> 
> 4.   Kernel sees IRQ and emits warning message. Tries to reset bus and ....

Actually, I'm thinking of the case where the interrupt request doesn't
make it to the kernel, so the kernel _doesn't_ see any IRQ in the expected 
time (and proceeds as you say).


> Have I got this scenario right?

Just about.

(Also, thanks for the DMA details.)



Daniel
-- 
Daniel Barclay
dsb@smart.net
