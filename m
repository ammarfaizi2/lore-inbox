Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUIHMSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUIHMSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUIHMSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:18:10 -0400
Received: from ltgp.iram.es ([150.214.224.138]:37509 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S261239AbUIHMP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:15:58 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 8 Sep 2004 14:12:36 +0200
To: "David S. Miller" <davem@davemloft.net>
Cc: Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, bgerst@didntduck.org,
       Riley@Williams.Name
Subject: Re: PROBLEM: x86 alignment check bug
Message-ID: <20040908121236.GA5283@iram.es>
References: <413E498D.4020807@vmware.com> <20040907170807.2e8bba1d.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907170807.2e8bba1d.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 05:08:07PM -0700, David S. Miller wrote:
> On Tue, 07 Sep 2004 16:51:41 -0700
> Zachary Amsden <zach@vmware.com> wrote:
> 
> > Clearly, this is not correct.  Considering how difficult the fix is (the 
> > kernel must disassemble the faulting instruction and use register 
> > information to determine the faulting address),
> 
> While it is more difficult to disassemble x86 opcodes,
> what you describe is exactly how we handle this on
> sparc64.  In fact we do opcode decoding for most fault
> types.

For page faults, cr2 gives you the linear address, i.e., after
adding the base of the segment, which you can only find
by looking up the GDT and/or LDT for the correct segment.

Of course, the address decoding depends also of the size
attributes of the code segment (16 or 32 bits for i386, 
64 bits for x86_64) which needs also a lookup of CS in the
segment tables, and of a possible address prefix which 
affects the decoding. Of course this is fraught with race
if another thread modifies the LDT at the same time.

Then most instructions use a standard memory address
encoding, but there are a few exceptions which implicitly
use ESI and/or EDI. For the ones that use two memory 
addresses (movs/cmps), you'd have to even compute both 
addresses and decide which one is the unaligned one. 

I somehow suspect that Sparc is somewhat simpler to decode
than i386/x86_64 ;-)

Don't bloat the kernel with decoding this mess, please.
A helper library in user space, why not?

	Regards,
	Gabriel
