Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbTBLJ62>; Wed, 12 Feb 2003 04:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbTBLJ62>; Wed, 12 Feb 2003 04:58:28 -0500
Received: from [128.222.32.10] ([128.222.32.10]:17376 "EHLO mxic1.corp.emc.com")
	by vger.kernel.org with ESMTP id <S266983AbTBLJ6Y>;
	Wed, 12 Feb 2003 04:58:24 -0500
Message-ID: <70652A801D9E0C469C28A0F8BCF49CF9012EBA15@itmi1mx2.corp.emc.com>
From: Ballabio_Dario@emc.com
To: manfred@colorfullife.com, warp@mercury.d2dc.net
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-eata@i-connect.net
Subject: RE: eata irq abuse (was: Re: Linux 2.5.60)
Date: Wed, 12 Feb 2003 05:08:07 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, you are correct. I used spin_unlock in order to release the local
driver lock
during the scsi_register call, but I forgot that I had the irq disabled as
well.
SO the correct fix is to use spin_unlock_irq/spin_lock_irq around the
scsi_register call. Same fix applies to the u14-34f driver.

Cheers,

*********************************
Ph.D. Dario Ballabio
EMC Computer Systems Italia spa
Mobile phone +393487978851
Office phone +390244571315
Mobile fax   +393487951622

*** Si vis pacem, para bellum ***


-----Original Message-----
From: Manfred Spraul [mailto:manfred@colorfullife.com]
Sent: Tuesday, February 11, 2003 6:46 PM
To: Zephaniah E. Hull
Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org;
linux-eata@i-connect.net
Subject: eata irq abuse (was: Re: Linux 2.5.60)


Zephaniah wrote:

>kernel BUG at mm/slab.c:1102!

Slab notices that a function that expects enabled local interrupts is called
with disabled local interrupts.


>Call Trace:
> [<c014a3b3>] do_tune_cpucache+0x83/0x240

do_tune_cpucache:
the function call smp_call_function(), and that is only permitted with
enabled local interrupts. The complain is correct.


> [<c014a300>] do_ccpupdate_local+0x0/0x30
> [<c014a5c1>] enable_cpucache+0x51/0x80
> [<c0148ea5>] kmem_cache_create+0x4a5/0x560

Within kmem_cache_create. kmem_cache_create checks for in_interrupt(), thus
someone probably does

	spin_lock_irqsave();
	kmem_cache_create();


> [<c0285dd2>] scsi_setup_command_freelist+0xa2/0x130

calls kmem_cache_create()

> [<c02887e0>] scsi_register+0x3c0/0x660

calls scsi_setup_command_freelist


> [<c02919a1>] get_pci_dev+0x31/0x50

?? probably stale

> [<c0291df2>] port_detect+0x3c2/0xe50

Do you have an eata scsi controller?

Ugs.
eata2x_detect():
* spin_lock_irqsave();
* calls port_detect();
* * spin_unlock();
* * scsi_register.

Eata maintainers: Is that necessary?
Why do the interrupts remain disabled across scsi_register?
Is that a bug workaround, or an oversight?
I'd use

	spin_unlock_irq();
	scsi_register();
	spin_lock_irq();

--
	Manfred


-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
