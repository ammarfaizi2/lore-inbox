Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278928AbRKFKst>; Tue, 6 Nov 2001 05:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278962AbRKFKs3>; Tue, 6 Nov 2001 05:48:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17672 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278928AbRKFKsU>; Tue, 6 Nov 2001 05:48:20 -0500
Subject: Re: Using %cr2 to reference "current"
To: rml@tech9.net (Robert Love)
Date: Tue, 6 Nov 2001 10:55:23 +0000 (GMT)
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <1005033690.808.2.camel@phantasy> from "Robert Love" at Nov 06, 2001 03:01:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1613t5-00005M-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I too am confused.  More so, the difference between hard_get_current and
> get_current is confusing.  I further question things because I suspect

hard_get_current always works
get_current assumes %cr2 is loaded correctly

> do_page_fault, cpu_init" but all these functions call other functions
> that may very well use get_current.  How is this going to work?

do_page_fault and cpu_init load %cr2

> Further, the preemptible kernel patch oopses with this patch (IOW, don't
> use 2.4.13-ac8 + preempt-kernel, unless you remove all these bits like I
> did :>).  I think it may be because of:

You must ensure that you don't pre-empt until %cr2 is loaded. Obviously this
isnt a problem with the traditional low latency patch but if you pre-empty
very early in page fault handling then I suspect you might get the odd
suprise.

The reasoning behind all this is to fix the cache pessimal nature of the x86
stack layout - we had all task structs on the same cache colour and all 
stacks aligned within pages (so every apache thread waiting at the same
point is on the same colour too and each wait queue entry on their stacks
is linked to entries all the same colour)

Alan
