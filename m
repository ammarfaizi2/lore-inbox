Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbTLZW1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 17:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbTLZW1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 17:27:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:40889 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264323AbTLZW1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 17:27:43 -0500
Date: Fri, 26 Dec 2003 14:27:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: caszonyi@rdslink.ro
cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.53.0312262105560.537@grinch.ro>
Message-ID: <Pine.LNX.4.58.0312261419230.14874@home.osdl.org>
References: <Pine.LNX.4.53.0312262105560.537@grinch.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Dec 2003 caszonyi@rdslink.ro wrote:
> 
> I was trying to capture a tv program  with mencoder when the oops occured
> a couple  of hours later the system froze without leaving a single trace
> in logs. I was able to reboot with SysRq.
> 
> Programs versions, config and dmesg are attached.

Looks like this loop:

		....
                        while (voffset >= sg_dma_len(vsg)) {
                                voffset -= sg_dma_len(vsg);
                                vsg++;
                        }
		....

and in particular, it's the "sg_dma_len()" access that oopses, apparently 
because vsg was stale to begin with, or because it incremented past the 
last pointer.

The pointer that fails (0xc4bea00c) looks reasonable, so it's almost
certainly due to CONFIG_PAGE_DEBUG showing some kind of use-after-free
problem (ie the pointer is stale, and the memory has already been freed).

I suspect the problem is that 

	"voffset >= sg_dma_len(vsg)"

test: if "voffset" is _exactly_ the same as sg_dma_len(), then we will 
test one more iteration (when "voffset" is 0), and that iteration may be 
past the end of the "vsg" array.

I suspect the fix might be to change the test to

	"voffset && voffset >= sg_dma_len(vsg)"

to make sure that we never access vsg past the end of the array.
		

		Linus
