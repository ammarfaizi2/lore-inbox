Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWEWB2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWEWB2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWEWB2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:28:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42379 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751240AbWEWB2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:28:24 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: NMI problems with Dell SMP Xeons 
In-reply-to: Your message of "Tue, 23 May 2006 01:56:39 +0200."
             <200605230156.40149.ak@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 May 2006 11:26:46 +1000
Message-ID: <4715.1148347606@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (on Tue, 23 May 2006 01:56:39 +0200) wrote:
>
>> (1) IPI 2, not marked as NMI.  This does _not_ call into the do_nmi()
>>     routine.
>> 
>>     People have been telling me (hi, Andi:) that sending interrupt 2 as
>>     an IPI automatically sends it as an NMI. 
>
>I can't remember ever saying that. I said that sending anything with the 
>NMI bit set will end up at the NMI vector, not the original vector
>you specified. Or at least that is what the Intel manual specify.
>That is why it is useless to hook the original vector like you did
>and add special cases just to get an NMI send with different vector.

I have never disagreed that all NMIs will end up on the NMI vector (2).
But there still has to be code in arch/*/kernel to detect that the IPI
being sent is to be marked as NMI, IOW you still need the code that
sets APIC_DM_NMI.  Whether that is done by using a special vector
number (i386 does) or by defining a separate routine for sending NMI
(x86_64 does) is a matter for debate.

Unfortunately the way that you changed the x86_64 kdb code, it now does
neither.  Your hack to kdb sends an IPI using NMI_VECTOR (2) which is

(a) not actually sent as an NMI and
(b) on most of the hardware I have tested, it does not even get through
    to the other cpus, instead it generates APIC errors.

FWIW, kdb on ia64 first sends a normal maskable IPI using its own
KDB_VECTOR and waits for the other cpus to rendezvous.  Only if some
cpus have not rendezvoused does ia64 kdb resort to using a non-maskable
interrupt.  I have found that this gives much better backtracing and is
more reliable.  It is a sad fact of life that NMIs can be delivered in
the middle of code that sets up the kernel stack, when that happens it
is impossible to backtrace.  I am changing kdb on i386 to do the same
two step process, try a normal interrupt first, wait a bit then resort
to NMI.

