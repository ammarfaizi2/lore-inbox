Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWCZUjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWCZUjz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 15:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWCZUjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 15:39:55 -0500
Received: from smtpout.mac.com ([17.250.248.89]:38123 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751544AbWCZUjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 15:39:54 -0500
In-Reply-To: <20060326200537.GA5012@mars.ravnborg.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <20060326200537.GA5012@mars.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1DF54B48-4541-4BA9-A71C-A64CE98B4964@mac.com>
Cc: linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header infrastructure
Date: Sun, 26 Mar 2006 15:39:32 -0500
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 15:05:37, Sam Ravnborg wrote:
> On Sun, Mar 26, 2006 at 06:54:16AM -0500, Kyle Moffett wrote:
>> Create initial kernel ABI header infrastructure
>>
>> diff --git a/Makefile b/Makefile
>> index af6210d..8e9045a 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -787,13 +787,15 @@ ifneq ($(KBUILD_SRC),)
>>  		/bin/false; \
>>  	fi;
>>  	$(Q)if [ ! -d include2 ]; then mkdir -p include2; fi;
>> +	$(Q)if [ ! -d include2/kabi ]; then mkdir -p include2/kabi; fi;
>>  	$(Q)ln -fsn $(srctree)/include/asm-$(ARCH) include2/asm
>> +	$(Q)ln -fsn $(srctree)/include/kabi/arch-$(ARCH) include2/kabi/arch
>
> No - we do not want another symlink.
> Create something like:
> include/i386/kabi-asm/  <= i386 specific files
> include/kabi/           <= general files
>
> Then we can do:
> LINUXINCLUDE += -Iinclude/kabi-$(ARCH)
> And the following would work like expected:
> #include <kabi/foo.h>
> #include <kabi-asm/foo.h>

Hmm, I see where you're going with this.  Thanks for the tip!

> But this leaves all existing users in the dark cold.  So a more  
> involved approach could be to take the opposite approach. To  
> dedicate an area for kernel only header files and make sure this  
> directory is searched _before_ include/

I'm not entirely sure I understand this bit.  The idea behind this  
kabi stuff is precisely to split out portions of the headers so that  
both userspace and kernelspace can get at them; to designate specific  
items as "userspace clean" by putting them in kabi; everything else  
need not care at all, and all those headers would remain in include/ 
linux where they are now.  No sense moving _everything_ in include/  
around, we just want the parts that userspace needs too.

> And we have so many users of include/linux today. They do not need  
> a _kabi_ prefix so let it go.

_Exactly_ the point.  I'd like to leave 99% of the kernel code  
alone.  Userspace doesn't work with the headers in the stock kernel  
as-is, so I see no problem with working to provide a clean source ABI  
even if it's partially incompatible with the old source ABI.  The  
binary ABI would stay the same, though, and I'd try to fix the old  
source ABI where possible.

I think I'll try something like your original proposal:
include/kabi/			<= Userspace-clean generic ABI includes
include/$(ARCH)/		<= New arch-specific include directory
include/$(ARCH)/kabi-arch/	<= Arch-specific ABI includes

Then the following Makefile snippet:
LINUXINCLUDE += -Iinclude/$(ARCH)

And then in the header file:
#include <kabi-arch/stddef.h>
#include <kabi/types.h>

It would also be possible to move files from include/asm-$(ARCH) to  
include/$(ARCH)/asm if desired, but that's a little offtopic for the  
kernel-ABI headers project I'm working on right now.

Thanks for the advice!
Kyle Moffett

