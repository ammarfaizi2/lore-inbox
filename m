Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271986AbRHVMPF>; Wed, 22 Aug 2001 08:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271992AbRHVMO5>; Wed, 22 Aug 2001 08:14:57 -0400
Received: from femail25.sdc1.sfba.home.com ([24.254.60.15]:27299 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271986AbRHVMOo>; Wed, 22 Aug 2001 08:14:44 -0400
Message-ID: <3B83A17C.CB8ABC53@didntduck.org>
Date: Wed, 22 Aug 2001 08:11:40 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, set@pobox.com, alan@lxorguk.ukuu.org.uk,
        Wilfried.Weissmann@gmx.at
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
In-Reply-To: <20010819004703.A226@squish.home.loc.suse.lists.linux.kernel> <3B831CDF.4CC930A7@didntduck.org.suse.lists.linux.kernel> <oupn14sny4f.fsf@pigdrop.muc.suse.de> <3B839E47.874F8F64@didntduck.org> <20010822141058.A18043@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Wed, Aug 22, 2001 at 07:57:59AM -0400, Brian Gerst wrote:
> > Yes.  What happened here is that %ds and %es were not being updated
> > atomically.  Under normal operation, this would just leave %es with
> > USER_DS, which is sufficiently equivalent to KERNEL_DS to not cause a
> > fault.  Coming out of vm86 mode however forces the data segment
> > registers to null after saving the real mode values on the stack.  If an
> > interrupt happened between setting %ds and %es (what are the odds?) then
> > that assumption would fail and leave %es null, causing the next string
> > instruction to go boom.  The same fix should be applied to entry.S as
> > well.
> 
> No that's not the problem. interrupt gates come in with interrupts off,
> so there are no other interrupts that could race here. The syscall entry
> always updates %ds/%es unconditionally and %ds first, so there is no
> race.
> 
> It was much simpler. It assumed that __KERNEL_DS could not be loaded
> from user space because of the segment register priviledge checking; and
> that was obviously not true from vm86 mode.
> 
> -Andi

The kernel was initially entered throught the general protection fault
trap gate, with interupts on.  The syscall entry was left on the stack
because of the way sys_vm86 works.

-- 

						Brian Gerst
