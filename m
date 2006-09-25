Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWIYVdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWIYVdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWIYVdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:33:25 -0400
Received: from gw.goop.org ([64.81.55.164]:56290 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751453AbWIYVdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:33:24 -0400
Message-ID: <45184B27.1030907@goop.org>
Date: Mon, 25 Sep 2006 14:33:27 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Matt Tolentino <matthew.e.tolentino@intel.com>
Subject: Re: [PATCH 1/6] Initialize the per-CPU data area.
References: <20060925184540.601971833@goop.org> <200609252249.54901.ak@suse.de> <45184318.6060807@goop.org> <200609252305.10239.ak@suse.de>
In-Reply-To: <200609252305.10239.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> I'll respin it against your patches later today.
>>     
>
> Thanks. It's not that urgent because the merge will need a few days
> at least.
>   

I guess I should just use plain 2.6.19 as a base.

> Also I must admit I haven't figured out yet if yours or Rusty's patchkit
> is better. So far I was leaning towards yours, but that might be because
> I haven't looked closely at Rusty's version.

The basic machinery is similar, though he's gone and made things like 
the per-cpu GDTs actual percpu variables, with a bit of gymnastics to 
use them from assembler.  I haven't looked at the last iteration which 
does all the setup in the head.S assembler.

On the plus side, he makes some use of %gs to reference percpu data, and 
it's a nice simple patch to do so.  One slightly odd aspect of it is 
that %gs:0 is actually at a large offset below the percpu memory, in 
order to compensate for the offset of the percpu data section in the 
kernel address space.

And in my heart of hearts I'd prefer to use the compiler TLS support to 
do this; it gets better generated code (at least in the non-Xen case), 
with the downside of needing some more support in the module loader.  It 
also gets rid of all the special access macros/assembler for percpu 
variables.  (And ideally we can convince the gcc folks to allow 
generation of positive offset TLS relocations, and solve the Xen problem 
that way.)

    J
