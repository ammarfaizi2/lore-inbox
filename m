Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263739AbUDGQz1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbUDGQz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:55:27 -0400
Received: from gizmo04ps.bigpond.com ([144.140.71.14]:63968 "HELO
	gizmo04ps.bigpond.com") by vger.kernel.org with SMTP
	id S263739AbUDGQzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:55:15 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: richard@techdrive.com.au
Subject: Re: Updated Ross Dickson C1Halt patch for 2.6.5
Date: Thu, 8 Apr 2004 02:58:28 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       a.verweij@student.tudelft.nl
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404080258.28277.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard James wrote

> This patch works against kernel 2.6.5 as it did for 2.6.3. If you try 
> and turn APIC off in settings then the kernel will crash at compile 
> because of his C1halt function. I'm not sure how to fix that. I forgot 
> to record the compile error as well. To use it you need to send 
> idle=C1patch to the kernel at boot and their needs to be a way so that 
> you can instead select this from the config menu and toggle it on and 
> off with the APIC controls. 

> Richard James :) 

Glad the patch has worked for you also. Thanks for the rediff.
I still have no explanation from Nvidia or Amd as to what is going 
on or why.

Agreed it is time to clean the patch up. Enough people have had good 
success with. 

I personally am happy without a config item for the patch invoking as 
bioses get updated and such updates may (should?!) remove the need for 
this workaround. The "idle=C1halt" provides a boot time means of turning
it off. Perhaps a config item to change the idle preselected for boot
with no kernel "idle=" arg would be handy.

I note there is talk on the list of runtime idle control. I think it is useful
for this patch to be integrated with such a system as it eases up on the
C1 Athlon headbanging rate. There is a recent posting stating that 
the idle call rate can be 3800Hz!! on audio playback.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/1516.html

Nobody has used patch for K8 that I know of, but is has been used on
both nforce2 and SIS740 to fix hard lockups.

I still mainly work with 2.4 series and have not worked with the
2.6 kernel config. I have also not yet downloaded 2.6.5. 

Any takers?  
Changes something like (please fix the indenting)

<snip>  
 +#if defined(CONFIG_X86_UP_APIC)
 +#include <asm/apic.h> 
 +#endif

<snip>
Note I have not tested the following particularly if kernel is
compiled with apic in and booted with "nolapic". 

 + /* 
 + * We use this to avoid nforce2 lockups 
 + * Reduces frequency of C1 disconnects 
 + */ 
 +static void c1halt_idle(void) 
 +{ 
 +   if (!hlt_counter && current_cpu_data.hlt_works_ok) { 
 +     local_irq_disable(); 
 +#if defined(CONFIG_X86_UP_APIC)
 +     /* only hlt disconnect if more than 1.6% of apic interval remains */ 
 +     if( !need_resched() && (enable_local_apic < 0 || 
 +     (apic_read(APIC_TMCCT) > (apic_read(APIC_TMICT)>>6))) ) { 
 +#else
 +     /* just adds a little delay to assist in back to back disconnects */ 
 +     if( !need_resched() ) {
 +#endif 
 +       ndelay(600); /* helps nforce2 but adds 0.6us hard int latency */ 
 +       safe_halt(); /* nothing better to do until we wake up */
 +     } 
 +     else 
 +       local_irq_enable(); 
 +   } 
 +} 
 + 
 + 
<snip>
We have to drop the extra static I added to the default idle function 
as it upsets APM which needs it public.
To do this just drop this part of the patch.

 @@ -88,7 +89,7 @@ EXPORT_SYMBOL(enable_hlt); 
   * We use this if we don't have any better 
   * idle routine.. 
   */ 
 -void default_idle(void) 
 +static void default_idle(void) 
  { 
          if (!hlt_counter && current_cpu_data.hlt_works_ok) { 
                  local_irq_disable(); 
<snip>

Thanks all.
Ross.


 




 
