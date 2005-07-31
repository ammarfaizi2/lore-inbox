Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVGaT4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVGaT4V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVGaT4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:56:21 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:23311 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261841AbVGaTzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:55:33 -0400
Message-ID: <42ED2C64.6030100@vmware.com>
Date: Sun, 31 Jul 2005 12:54:12 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i386-arch-cleanup-seralize-msr-fix.patch added to -mm tree
References: <200507310747.j6V7lI1l004908@shell0.pdx.osdl.net>
In-Reply-To: <200507310747.j6V7lI1l004908@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jul 2005 19:54:13.0859 (UTC) FILETIME=[A052F330:01C59609]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:

>The patch titled
>
>     i386-arch-cleanup-seralize-msr fix
>
>diff -puN arch/i386/kernel/microcode.c~i386-arch-cleanup-seralize-msr-fix arch/i386/kernel/microcode.c
>--- 25/arch/i386/kernel/microcode.c~i386-arch-cleanup-seralize-msr-fix	2005-07-30 23:40:17.000000000 -0700
>+++ 25-akpm/arch/i386/kernel/microcode.c	2005-07-30 23:40:34.000000000 -0700
>@@ -83,6 +83,7 @@
> #include <asm/msr.h>
> #include <asm/uaccess.h>
> #include <asm/processor.h>
>+#include <asm/processor.h>
>


Sorry to break something yet again.  Looks like a duplicate include got 
inserted here.  Actually this last fix brings up a very valid point.  
There is now sharing in both directions between i386 and x86_64 (I was 
only aware that early_printk.c was shared from the x86_64 tree).  There 
is still a lot more code that could be shared; in particular, one can 
only imagine how many apic and io-apic bugs have been caused or are 
still lurking because of lack of shared code (*).  A lot of these code 
cleanups I submitted could be utilized by x86_64 as well, and if we 
continue to move machine specific inline assembler into header files and 
out of the arch directory, there is a lot more chance to share code - 
even across entirely different architectures, as eventually happened to 
much of irq.c.

Is it worthwhile considering some more explicit way of sharing code 
between i386 and x86_64?  I don't like breaking builds for one or the 
other because I changed a file that I did not know was shared, and it is 
not always possible to personally test both builds from every location I 
might be at.  I think moving x86_64 as a sub-arch of i386 is rather far 
too radical, for now, but perhaps there is a better solution 
(arch/i386/x86_64-shared/) to make code sharing explicit so that 
developers are always thinking about these issues when changing code here.

Zach

(*) It is quite likely the APIC / IO-APIC code would require a minimal 
set of #ifdefs to be shared, because code must deal with different board 
features and vendors, but the ugliness of a couple of #ifdefs combined 
with strategic creation of machine specific abstractions via header 
files could likely win huge savings by increasing the number of people 
testing and debugging common code.
