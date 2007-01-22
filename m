Return-Path: <linux-kernel-owner+w=401wt.eu-S1751648AbXAVP5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbXAVP5m (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbXAVP5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:57:41 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:15836 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbXAVP5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:57:41 -0500
Message-ID: <d4cf37a60701220757v4557879dr611b50d3bafa2e65@mail.gmail.com>
Date: Mon, 22 Jan 2007 07:57:40 -0800
From: "Wink Saville" <wink@saville.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Asynchronous Messaging
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070122144433.68598359@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d4cf37a60701220019h7cae91f6nc33bd24761a54c67@mail.gmail.com>
	 <20070122144433.68598359@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > This is accomplished by allocating a page (or more) of memory which
> > is executable and mapped into every threads address space. Also, all
> > ISR entry points are modified to detect if the code that was interrupted
> > was executing within the ACE page. If it was then the ACE code is
> > allowed to complete before the ISR continues. This then provides
> > the guarantee of atomic execution.
>
> What if you enter the ISR, pass the point of the check and then another
> CPU core hits the ACE space ?

If CPU A has passed the point of the check then by definition the lock in
the ACE space that it was holding will have been released and be available
to CPU B, thus there will be no contention and CPU B will proceed to
execute the code within the ACE space.

> Also how do you handle the case where the code gets stuck in your atomic
> pages ?

The code in the ACE space must execute quickly and must never get stuck, the
same rules as any code which holds spin locks. As I envision it the
ACE space is "micro-code" provided by only the kernel and thus is bug
free.

Of course shit happens, for example I use ACE to manipulate shared linked lists.
What happens if a pointer passed to the ACE code caused a page fault.
This will cause the ISR to be reentered and is definitely a problem. But this
can be detected and "fixed-up", i.e. release the spin lock and mark the
faulting code to be killed and not rescheduled.

My proof of concept code does not handle this situation but I believe it
can be handled.

A similar problem might occur if buggy or malicious code were to begin
executing in the "middle" of the ACE space rather than at one of its entry
points. Protection will need to put in place to handle this also. For instance
if N ISR's in a row detect that the ACE space code has never stopped
executing then kill the erroneous thread. Another idea would be to only
allow "approved" code to use ACE.

Wink
