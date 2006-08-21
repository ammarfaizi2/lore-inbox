Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWHUQpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWHUQpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 12:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWHUQpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 12:45:53 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53392 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S964987AbWHUQpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 12:45:52 -0400
Date: Mon, 21 Aug 2006 12:45:50 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Message-ID: <20060821164550.GB3678@fieldses.org>
References: <20060820013121.GA18401@fieldses.org> <200608201026.54530.ak@suse.de> <20060821155431.GA3678@fieldses.org> <200608211803.28867.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608211803.28867.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 06:03:28PM +0200, Andi Kleen wrote:
> On Monday 21 August 2006 17:54, J. Bruce Fields wrote:
> > On Sun, Aug 20, 2006 at 10:26:54AM +0200, Andi Kleen wrote:
> > > 
> > > > DWARF2 unwinder stuck at 0xc0100199
> > > > Leftover inexact backtrace:
> > > >  =======================
> > > >  BUG: unable to handle kernel paging request at virtual address 0000b034
> > > 
> > > This is already fixed in mainline.
> > 
> > I'm seeing the same behavior on Linus's latest as of this morning
> > (2.6.18-rc4-gef7d1b24).  Is there something else I should be testing?
> 
> The stuck is expected, but the unable to handle paging request should be 
> fixed. If not then it's a different problem than what I'm thinking,
> but it looks very similar.

OK, so any suggestions for what I should try?

My most recent panic on boot ended with:

DWARF2 unwinder tack at 0xc0100199
Leftover inexact backtrace:
 =======================
BUG: unable to handle kernel paging requets at virtual address 0000b034
 printing eip:
c0103712
*pde = 00000000
Recursive die() failure, output suppressed
 <0>Kernel panic - not syncing: Fatal exception in interrupt

Taking a look at an "objdump -d vmlinux", that c0103712 is in
show_trace_log_lvl():

...
c01036f9:	e8 a2 33 01 00       	call   c0116aa0 <printk>
c01036fe:	53                   	push   %ebx
c01036ff:	68 4c 20 5a c0       	push   $0xc05a204c
c0103704:	e8 67 41 03 00       	call   c0137870 <__print_symbol>
c0103709:	8b 06                	mov    (%esi),%eax
c010370b:	83 c4 10             	add    $0x10,%esp
c010370e:	39 c6                	cmp    %eax,%esi
c0103710:	75 ce                	jne    c01036e0 <show_trace_log_lvl+0x60>
-->c0103712:	8b 4f 34             	mov    0x34(%edi),%ecx
c0103715:	85 c9                	test   %ecx,%ecx
c0103717:	74 14                	je     c010372d <show_trace_log_lvl+0xad>
c0103719:	89 cb                	mov    %ecx,%ebx
c010371b:	8b 4d 08             	mov    0x8(%ebp),%ecx
c010371e:	51                   	push   %ecx
c010371f:	68 06 aa 59 c0       	push   $0xc059aa06
c0103724:	e8 77 33 01 00       	call   c0116aa0 <printk>
...

It looks like that's the deference of context on line 221:
		stack = (unsigned long*)context->previous_esp;

So "context" was 0000b000?? OK, I don't know this code at all, so I'm
probably not going to figure out anything useful here.

--b.
