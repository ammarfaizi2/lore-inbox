Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286256AbRL0MZy>; Thu, 27 Dec 2001 07:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286255AbRL0MZn>; Thu, 27 Dec 2001 07:25:43 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:3738 "EHLO gin")
	by vger.kernel.org with ESMTP id <S286256AbRL0MZa>;
	Thu, 27 Dec 2001 07:25:30 -0500
Date: Thu, 27 Dec 2001 13:25:20 +0100
To: Andrew Morton <akpm@zip.com.au>
Cc: andersg@0x63.nu, linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: lvm in 2.5.1
Message-ID: <20011227122520.GA2194@h55p111.delphi.afb.lu.se>
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C2AEADB.24BEFE94@zip.com.au>
User-Agent: Mutt/1.3.24i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 01:33:15AM -0800, Andrew Morton wrote:

> > I'm now running 2.5.1 with lvm. The following patch makes some minor changes
> > for bio-support and removes allocation of a lv_t on the stack, which made
> > the stack overflow and gave me something to spend my last 24 hours
> > debugging.
> 
> That's a worry, because an lv_t is only 420 bytes.  If that's triggering
> a stack overflow then we're way too close.  Think interrupts....
> 
> There must be other sources of stack bloat.
> 
> lvm_chr_ioctl() calls lvm_do_vg_create(), and it has has another lv_t
> on the stack.  That's 840 bytes - still not enough.  Maybe lvm_do_vg_create()
> is calling something which uses lots of stack?  Can't see it.  Odd.

did a calltrace in lvm_do_vg_create and it contains 48 symbols between

Trace; c013c786 <sys_ioctl+16a/184>

and 

Trace; c01a78f8 <lvm_chr_ioctl+2b8/670>

which looks like they comes from an old system call as it just contiains
lots of unrelated symbols. That would suggest that lvm_char_ioctl allcates a
big object on the stack that it havn't touched?

Removing these symbols makes the calltrace look like:

>>EIP; c01a8cf2 <lvm_do_vg_create+22/498>   <=====
Trace; c01a78f8 <lvm_chr_ioctl+2b8/670>
Trace; c013c786 <sys_ioctl+16a/184>
Trace; c010856a <system_call+32/38>

not many symbols that could allcate stackspace, lets have a look how they
allocates:

0x938 <lvm_blk_ioctl>:		   sub    $0x8,%esp

not much... lets have a look at lvm_do_vg_create then:

with my patch:
0x1830 <lvm_do_vg_create>:	   sub    $0x20,%esp

without my patch:
0x1830 <lvm_do_vg_create>:	   sub    $0x11c4,%esp

whoa! 0x11c4

thats a LOT! much more than sizeof(lv_t)

> Seems that in various places here you've forgotten to free the lv_t storage
> on error paths?

of course, how could i forget.. will put together a new patch with that
fixed in a minute. 

-- 

//anders/g

