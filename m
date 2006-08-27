Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWH0Qqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWH0Qqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWH0Qqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:46:37 -0400
Received: from gw.goop.org ([64.81.55.164]:22490 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932180AbWH0Qqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:46:37 -0400
Message-ID: <44F1CC67.8040807@goop.org>
Date: Sun, 27 Aug 2006 09:46:31 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
References: <20060827084417.918992193@goop.org> <1156672071.3034.103.camel@laptopd505.fenrus.org>
In-Reply-To: <1156672071.3034.103.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> this will be interesting; x86-64 has a nice instruction to help with
> this; 32 bit does not... so far conventional wisdom has been that
> without the instruction it's not going to be worth it.
>   

Hm, swapgs may be quick, but it isn't very easy to use since it doesn't 
stack, and so requires careful handling for recursive kernel entries, 
which involves extra tests and conditional jumps.  I tried doing 
something similar with my earlier patches, but it got all too messy.  
Stacking %gs like the other registers turns out pretty cleanly.

> When you're benchmarking this please use multiple CPU generations from
> different vendors; I suspect this is one of those things that vary
> greatly between models
>   

Hm, it seems to me that unless the existing %ds/%es register 
save/restores are a significant part of the existing cost of going 
through entry.S, adding %gs to the set shouldn't make too much 
difference.  And I'm not sure about the relative cost of using a %gs 
override vs. the normal current_task_info() masking, but I'm assuming 
they're at worst equal, with the %gs override having a code-size advantage.

But yes, it definitely needs measurement.

    J
