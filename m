Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWFUKDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWFUKDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWFUKDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:03:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:48306 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751360AbWFUKDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:03:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=CuX2MRP/f9TJxzdMafd5m6zewlz5lvP1v7+f/C6K7qaUbm9YWsN43zL1AorLsgisHiQdDe5+Vt8IJ/X0Xov1Tlch+sniX3v2MF3bduN08W/B0wkXUGusZAvr6PI+2N67Plf2fVw46rig9McRHCz2KucOChvUZP0YQ7fZ1yKyPpc=
Date: Wed, 21 Jun 2006 12:03:57 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Steven Rostedt <rostedt@goodmis.org>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <Pine.LNX.4.58.0606210406310.29673@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0606211035550.10723@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
 <1150816429.6780.222.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
 <Pine.LNX.4.58.0606210406310.29673@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jun 2006, Steven Rostedt wrote:

> [...]
> No, I think fixing the bug you found is better :)
>

Thomas convinced me. I don't like the design though. Moving the 
task priorities around isn't very healthy. It is confusing and it 
complicates stuff a lot. But as Thomas says, with my solution one could 
make DOS attack from userspace by arranging a lot of timers to timeout
simultaniously (or sufficient close to each other).
However, this is still possible, but less easy to do: In the interrupt 
every timer expirering is touched. I.e. by having a lot of timers you push 
a lot of work into the interrupt routine. In fact the interrupt routine 
also have to take the timer out of the binary tree, so the worst case interrupt 
latency is O(N log N), N being the total amount of timer in the system!!

But what about the configure option HIGH_RES_RESOLUTION ? It is barely 
used in the system now. But if timers closer than the resolution were 
batched together in a plist, then all the interrupt should do was to merge 
two plists, namely the list of newly timeouts and the list of stuff still 
pending to be executed by the softirq thread. The worst case would then be
max(O(log N), O(<number of priorities==140>), which is both fairly limited as
N can never be bigger than 1G on a 32 bit system such that log N <= 30.

Esben

> -- Steve
>
