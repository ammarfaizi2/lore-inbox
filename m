Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWEMKbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWEMKbH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 06:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWEMKbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 06:31:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:56966 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932232AbWEMKbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 06:31:04 -0400
Date: Sat, 13 May 2006 16:00:48 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Sharyathi Nagesh <sharyath@in.ibm.com>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Bug while executing : cat /proc/iomem on 2.6.17-rc1/rc2
Message-ID: <20060513103047.GA28366@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <444DFD53.2000108@in.ibm.com> <1145962096.3114.19.camel@laptopd505.fenrus.org> <1147332468.17798.13.camel@localhost.localdomain> <20060511073205.GA28693@flint.arm.linux.org.uk> <4462F7F4.7050908@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4462F7F4.7050908@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 02:08:12PM +0530, Sachin Sant wrote:
> Russell King wrote:
> 
> >Only the root should have a NULL parent, so this is just covering up some
> >other problem - you have a resource which somehow has illegally ended up
> >with a NULL parent pointer while it's been registered.
> >
> >Maybe try adding:
> >
> >		if (p->parent == NULL) {
> >			printk("resource with null parent: %lx-%lx: %s\n",
> >				p->start, p->end, p->name);
> >			break;
> >		}
> >
> >just before the test in that loop, and then finding out why that resource
> >is becoming invalid.
> >
> > 
> >
> I get this output in dmesg with the above code.
> 
> resource with null parent: 0-57ffffff: System RAM
> resource with null parent: 0-57ffffff: System RAM
> 
> x236:/home/sharyathi/linux-2.6.17-rc1/kernel # cat /proc/iomem
> 00000000-0009dbff : System RAM
> 0009dc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000cafff : Video ROM
> 000cb000-000cc5ff : Adapter ROM
> 000f0000-000fffff : System ROM
> 00100000-c7fcb5ff : System RAM
>  00100000-004ff436 : Kernel code
>  004ff437-0068881f : Kernel data
> x236:/home/sharyathi/linux-2.6.17-rc1/kernel #
> 

Backing out 

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=10dbe196a8da6b3196881269c6639c0ec11c36cb

solves this problem for me. This patch adds memory more than 4G to /proc/iomem
but without 64-bit fields for struct resource it ends up in confusing 
iomem_resource list. I think this patch needs the core 64-bit struct resource
related changes also.


Thanks
Maneesh
