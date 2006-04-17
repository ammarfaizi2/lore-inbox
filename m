Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWDQCPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWDQCPR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 22:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWDQCPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 22:15:17 -0400
Received: from xenotime.net ([66.160.160.81]:5038 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750944AbWDQCPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 22:15:15 -0400
Date: Sun, 16 Apr 2006 19:17:41 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: zhiyi huang <hzy@cs.otago.ac.nz>
Cc: penberg@cs.helsinki.fi, hnagar2@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Slab corruption after unloading a module
Message-Id: <20060416191741.f859ed90.rdunlap@xenotime.net>
In-Reply-To: <0829C3E1-F140-4561-9DFA-F865C7DECBB6@cs.otago.ac.nz>
References: <20060412230439.WMCC8268.mta4-rme.xtra.co.nz@[202.27.184.228]>
	<20060415212147.6e9b0c11.rdunlap@xenotime.net>
	<0829C3E1-F140-4561-9DFA-F865C7DECBB6@cs.otago.ac.nz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Apr 2006 21:38:44 +1200 zhiyi huang wrote:

> 
> On 16/04/2006, at 4:21 PM, Randy.Dunlap wrote:
> 
> > On Thu, 13 Apr 2006 11:04:39 +1200 Zhiyi Huang wrote:
> >
> >>> 2.6.8 is an old kernel, you could very well be hitting a kernel bug
> >>> that has been fixed already. Can you reproduce this with 2.6.16?
> >>
> >> I will try that soon.
> >>
> >>> Also,
> >>> you're not including sources to your module so it's impossible to  
> >>> tell
> >>> whether you're doing something wrong.
> >>>
> >>>                                                          Pekka
> >>
> >> Below is my baby module which only uses kmalloc and kfree for my  
> >> device
> >> structure. I found the slab corruption address is the address of  
> >> the structure.
> >> It seems to be a bug for kmalloc and kfree.
> >
> >> /* The parameter for testing */
> >> int major=0;
> >> MODULE_PARM(major, "i");
> >> MODULE_PARM_DESC(major, "device major number");
> >
> > Hi,
> > I had no problem loading and unloading your module on
> > 2.6.17-rc1 [after changing MODULE_PARM() to
> > module_param(major, int, 0644);
> > ].
> >
> > ---
> > ~Randy
> 
> There was no problem if I just load and unload the module. But if I  
> write to the device using "ls > /dev/temp" and then unload the  
> module, I would get slab corruption.  I tried to install 2.6.16.5 at  
> the moment but got stuck when I was making an initrd image file (no  
> output file produced! and no errors displayed). Once I get around  
> this problem, I should be able to test it on the new kernel.
> Zhiyi

Hm, OK, somehow I missed that crucial part.  Yes, my kernel now dies
a horrible death after I unload the tem module, but not with slab
corruption, just with invalid memory pointers.  Anyway, the most
obvious hint in your earlier email was the data values that were
printed:

Slab corruption: start=c7933c38, len=192
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01ac52d>](load_elf_interp+0xdd/0x2d0)
070: 6b 6b 6b 6b ac 3c 93 c7 ac 3c 93 c7 6b 6b 6b 6b
Prev obj: start=c7933b6c, len=192
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=c7933d04, len=192
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01e58fa>](__journal_remove_checkpoint+0x4a/0xa0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

Aside from the obvious slab corruption and redzone error,
the 0x6b value is what mm/slab.c uses for use-after-free
poisoning, so it seems that there are some pointers out in
never-never land somewhere.


from mm/slab.c:
#define	POISON_INUSE	0x5a	/* for use-uninitialised poisoning */
#define POISON_FREE	0x6b	/* for use-after-free poisoning */
#define	POISON_END	0xa5	/* end-byte of poisoning */

---
~Randy
