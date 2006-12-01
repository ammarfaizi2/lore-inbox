Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162102AbWLAWUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162102AbWLAWUv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162105AbWLAWUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:20:50 -0500
Received: from junsun.net ([66.29.16.26]:46860 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S1162102AbWLAWUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:20:50 -0500
Date: Fri, 1 Dec 2006 14:20:47 -0800
From: Jun Sun <jsun@junsun.net>
To: linux-kernel@vger.kernel.org
Subject: Re: failed 'ljmp' in linear addressing mode
Message-ID: <20061201222047.GA29035@srv.junsun.net>
References: <20061122234111.GA8499@srv.junsun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122234111.GA8499@srv.junsun.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 03:41:11PM -0800, Jun Sun wrote:
> 
> I am plowing along as I am learning about the in'n'outs about i386.  I am
> totally stuck on this one.  I would appreciate any help.
> 
> As you can see, the function turns off paging mode (of course it
> runs from identically mapped page) and tries to jump to an absolute
> address at 0x10000000.  It appears the machine would reboot when running
> "ljmp" instruction.
> 
> Any pointers?
> 

Pageexec gave me an excellent explanation on why "ljmp" fails. See below.
It is so obvious once you see it. :)

Thanks.

Jun
-----------------

From: pageexec@freemail.hu
To: jsun@junsun.net
Date: Fri, 01 Dec 2006 14:35:09 +0200
Subject: failed 'ljmp' in linear addressing mode

hello,

just saw your post on lkml. your original problem was that when you
executed the far jump, the CPU's internal GDT base register was still
loaded with the kernel's virtual address of gdt_table - an address
somewhere high in the (then virtual) address space which when
interpreted as a physical address (you turned off paging, remember)
contained nothing, let alone a valid GDT.

so when the CPU tried to look up __KERNEL_CS in the GDT, it found
nothing there, that in turn triggered an exception which in turn
double then triple faulted as the IDT couldn't be accessed either
for the same reason. later you posted code that shows that you
reload the IDT/GDT with a constant 0, i doubt that will do much
good either on the long run as there's no valid GDT/IDT set up
there normally.

in short, the normal course of action when going from paged protected
mode into non-paged protected mode is to reload IDT/GDT with physical
addresses pointing to valid tables then reload the segment registers
(if they're different from those used in paged mode) then you can go
on with the rest. note that the reload operation uses *two* addresses
(one for the memory operand of lgdt/lidt and one for the actual table
address), both of which had better be of the same kind (physical or
virtual).
 
