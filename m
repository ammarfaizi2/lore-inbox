Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUFCM5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUFCM5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 08:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUFCM5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 08:57:00 -0400
Received: from pxy3allmi.all.mi.charter.com ([24.247.15.42]:1732 "EHLO
	proxy3-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S263626AbUFCM4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 08:56:40 -0400
Message-ID: <40BF201F.2020701@quark.didntduck.org>
Date: Thu, 03 Jun 2004 08:57:03 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040603072146.GA14441@elte.hu>
In-Reply-To: <20040603072146.GA14441@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
>>>If the NX feature is supported by the CPU then the patched kernel turns
>>>on NX and it will enforce userspace executability constraints such as a
>>>no-exec stack and no-exec mmap and data areas. This means less chance
>>>for stack overflows and buffer-overflows to cause exploits.
>>
>>Just out of interest - how many legacy apps are broken by this? I
>>assume it's a non-zero number, but wouldn't mind to be happily
>>surprised.
> 
> 
> in the full install of FC1 and FC2 the number is zero - and Fedora has
> exec-shield which does a couple of things more: it makes the heap
> non-executable as well [this broke X], it randomizes the address-space
> layout and has a 4:4 VM [which broke the Sun JVM].
> 
> 
>>And do we have some way of on a per-process basis say "avoid NX
>>because this old version of Oracle/flash/whatever-binary-thing doesn't
>>run with it"?
> 
> 
> we have three mechanisms for this in Fedora:
> 
> 1) the PT_GNU_STACK flag itself - you can turn executability on/off
>    compile-time or even after the fact via the execstack(8) utility
>    Jakub wrote. This only affects the stack's executability - if an 
>    application assumes a non-PROT_EXEC mmap() can be executed it might
>    still break with NX - but based on experience with Fedora Core i'd
>    say there's almost no such application.
> 
> this method works in 2.6 too, since it supports PT_GNU_STACK. gcc's
> PT_GNU_STACK mechanism is very conservative - e.g. if an application
> does an asm() then gcc assumes that it might rely on stack executability
> and emits the X flag. [applications can then turn this off in the source
> if stack executability is not required.] Likewise, if gcc emits
> trampolines then the X flag is emitted too. (glibc knows about
> PT_GNU_STACK all across - so e.g. if a nonexec stack application
> dlopen()s a library that needs stack executability then glibc makes the
> stack executable on the fly via PROT_GROWSDOWN/GROWSUP.)
> 
> 2) via a runtime method: via the i386 personality. So an application can
>    trigger the 'legacy' Linux VM layout by e.g doing 'i386 java
>    ./test.class'.
> 
> this is a hack in Fedora - we wanted to have a finegrained runtime
> mechanism just in case. But it would be nice to have this upstream too -
> e.g. via a PERSONALITY_3G?
> 
> 3) via a kernel boot parameter (exec-shield=0)
> 
> with the NX patch this becomes noexec=off [the same flag works on x86_64
> too]. This method is the most inflexible one, and is a last-resort
> thing. (Fedora also has a runtime global switch to turn off the VM
> layout changes.)
> 
> here's a list of applications that we had to fix/work around in Fedora
> when the VM layout changed:
> 
>  - emacs _rebuild_. (it coredumps itself during build ... xemacs is OK.)
> 
>  - some JDKs. Since they generate code and try to be as fast as possible 
>    they tend to rely more on VM details than normal applications.
> 
>  - X's module loader assumed that brk was executable. (fixed)
> 
>  - Wine. (it implements another OS so it's by definition very sensitive 
>    to layout changes.)

Wine breaks because of the part of exec-shield that relocates shared 
libs to low addresses, where the (stripped) Windows binaries expect to 
be loaded at.  NX stack doesn't affect it.

--
				Brian Gerst
