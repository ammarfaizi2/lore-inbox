Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbSJCXoD>; Thu, 3 Oct 2002 19:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbSJCXoC>; Thu, 3 Oct 2002 19:44:02 -0400
Received: from ns.suse.de ([213.95.15.193]:35083 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261472AbSJCXoC>;
	Thu, 3 Oct 2002 19:44:02 -0400
Date: Fri, 4 Oct 2002 01:49:28 +0200
From: Andi Kleen <ak@suse.de>
To: Kevin Corry <corryk@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [PATCH] EVMS core 3/4: evms_ioctl.h
Message-ID: <20021004014928.A21424@wotan.suse.de>
References: <02100307370503.05904@boiler.suse.lists.linux.kernel> <p73vg4jr1ic.fsf@oldwotan.suse.de> <0210031730460A.05904@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0210031730460A.05904@boiler>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 05:30:46PM -0500, Kevin Corry wrote:
> In general, we are aware of the issues with using 32-bit user-space on top of 
> 64-bit kernel. If you take a look at evms.c you will find several functions 
> that get registered at init-time with the 32-to-64-bit ioctl conversion code. 
> These take care of translating pointers from user-space to kernel-space in 
> this situation. EVMS has been tested on ppc64 with success, and we have 
> someone currently running tests on sparc64 to make sure it works there as 
> well.

I think you have some security holes in there: 

	+parms.buffer_address  = (u8 *)uvirt_to_kernel(parms32.buffer_address);
	[...]
	+set_fs(KERNEL_DS);
	+rc = sys_ioctl(fd, kcmd, (unsigned long)karg);
	+set_fs(old_fs);


parms32.buffer_address comes from user space. With the set_fs you turn
off all access checking. Surely when whatever sits at the bottom of 
sys_ioctl accesses it it'll use copy_from/to_user and it will do an 
unchecked reference of a user supplied pointer, allowing it to read/write
all memory.

Same bug is present in more functions.

The rule is: when you do set_fs(KERNEL_DS) you have to copy all user supplied
pointers before it.



-Andi
