Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWIKH4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWIKH4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWIKH4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:56:19 -0400
Received: from gw.goop.org ([64.81.55.164]:29848 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751191AbWIKH4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:56:19 -0400
Message-ID: <4505169C.3010507@goop.org>
Date: Mon, 11 Sep 2006 00:56:12 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
References: <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911051028.GA10084@elte.hu> <450510E0.8080906@goop.org> <20060911072959.GA2322@elte.hu> <45051330.5050205@goop.org> <20060911073809.GB3188@elte.hu>
In-Reply-To: <20060911073809.GB3188@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> btw., what's the connection of %gs based PDA to Xen and 
> paravirtualization in general - %esp based current is just as 
> Xen-friendly, or am i wrong? I guess there must be some connection, 
> given that you are working on this ;)
>   

Yep.  The goal is to put the Xen VCPU structure into the PDA, so that it 
can be easily accessed.  At present, masking events (ie, cli), is 
something along the lines of

    xen_shared_info->vcpu[smp_processor_id()].mask = 1

which comes out to something like 20 bytes of code, and is probably too 
awkward to inline.  If the vcpu is in the PDA, it would come out to:

    movb $1, %gs:xen_vcpu_mask

which has the added benefit of not needing a register.

Even without modifying Xen to allow us to place the VCPU structure, 
putting a VCPU pointer into the PDA helps a lot:

    mov %gs:xen_vcpu, %eax
    movb $1, mask(%eax)

    J
