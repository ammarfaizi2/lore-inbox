Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWHIUSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWHIUSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWHIUSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:18:40 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:16469 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751349AbWHIUSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:18:40 -0400
Message-ID: <44DA431A.1010902@tls.msk.ru>
Date: Thu, 10 Aug 2006 00:18:34 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Forrest Voight <voights@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/i386/kernel/cpu/transmeta.c, kernel 2.6.17.8
References: <b572c9e10608091049q5223adddxb2fd854c31877670@mail.gmail.com>
In-Reply-To: <b572c9e10608091049q5223adddxb2fd854c31877670@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forrest Voight wrote:
> Corrects warning:
> 
>  CC      arch/i386/kernel/cpu/centaur.o
>  CC      arch/i386/kernel/cpu/transmeta.o
> arch/i386/kernel/cpu/transmeta.c: In function 'init_transmeta':
> arch/i386/kernel/cpu/transmeta.c:12: warning: 'cpu_freq' may be used
> uninitialized in this function
>  CC      arch/i386/kernel/cpu/intel.o
> 

This is a false alarm.
Here's the code (details omitted):

 if ( max >= 0x80860001 ) {
   cpuid(0x80860001, &dummy, &cpu_rev, &cpu_freq, &cpu_flags);
                                       ^^^^^^^^^
 }
 if ( max >= 0x80860002 ) {
    printk(KERN_INFO "CPU: Processor %u MHz\n", cpu_freq);
 }

Note the two conditions: if second is true, the first is
true too, so both branches are executed, so first cpu_freq
is initialized (by cpuid() call) and next it's used in printk.

The same thing will be done by the following code:

 if ( max >= 0x80860001 ) {
   cpuid(0x80860001, &dummy, &cpu_rev, &cpu_freq, &cpu_flags);
   if ( max >= 0x80860002 ) {
      printk(KERN_INFO "CPU: Processor %u MHz\n", cpu_freq);
   }
 }

and in this case gcc will not (hopefully) issue the warning.

BTW, cpu_rev gets initialized to 0 here as well - looks like
it's done also just to prevent warning message.

/mjt

