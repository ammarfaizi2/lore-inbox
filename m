Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271993AbRHVMLF>; Wed, 22 Aug 2001 08:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271992AbRHVMK5>; Wed, 22 Aug 2001 08:10:57 -0400
Received: from ns.suse.de ([213.95.15.193]:57350 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271986AbRHVMKp>;
	Wed, 22 Aug 2001 08:10:45 -0400
Date: Wed, 22 Aug 2001 14:10:58 +0200
From: Andi Kleen <ak@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, set@pobox.com,
        alan@lxorguk.ukuu.org.uk, Wilfried.Weissmann@gmx.at
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
Message-ID: <20010822141058.A18043@gruyere.muc.suse.de>
In-Reply-To: <20010819004703.A226@squish.home.loc.suse.lists.linux.kernel> <3B831CDF.4CC930A7@didntduck.org.suse.lists.linux.kernel> <oupn14sny4f.fsf@pigdrop.muc.suse.de> <3B839E47.874F8F64@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B839E47.874F8F64@didntduck.org>; from bgerst@didntduck.org on Wed, Aug 22, 2001 at 07:57:59AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001 at 07:57:59AM -0400, Brian Gerst wrote:
> Yes.  What happened here is that %ds and %es were not being updated
> atomically.  Under normal operation, this would just leave %es with
> USER_DS, which is sufficiently equivalent to KERNEL_DS to not cause a
> fault.  Coming out of vm86 mode however forces the data segment
> registers to null after saving the real mode values on the stack.  If an
> interrupt happened between setting %ds and %es (what are the odds?) then
> that assumption would fail and leave %es null, causing the next string
> instruction to go boom.  The same fix should be applied to entry.S as
> well.

No that's not the problem. interrupt gates come in with interrupts off, 
so there are no other interrupts that could race here. The syscall entry
always updates %ds/%es unconditionally and %ds first, so there is no
race.

It was much simpler. It assumed that __KERNEL_DS could not be loaded 
from user space because of the segment register priviledge checking; and
that was obviously not true from vm86 mode.

-Andi

