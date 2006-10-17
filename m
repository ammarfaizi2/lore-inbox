Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWJQWNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWJQWNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWJQWNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:13:51 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:49812 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750704AbWJQWNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:13:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:In-Reply-To:Thread-Index:X-MimeOLE;
  b=1Ll5BHOPYh19CNTrgp+Wa1gcPBcE7xuLDTLedvyIO9PJjnaKoQEahVFEmNu+6zccXEA8wPeOPHjpkNFF3Sgn8lac+IAs3cyIvQVwq+DtGbsk95OuPHrDAGnH0ADRwl83YjnWWLsnO4EeBvobogbJxgIDYR5cfwKaUwasNiJs9ZU=  ;
From: "dared1st" <dared1st@sbcglobal.net>
To: "'Auke Kok'" <auke-jan.h.kok@intel.com>
Cc: "'Ryan Richter'" <ryan@tau.solarneutrino.net>,
       "'Lukas Hejtmanek'" <xhejtman@mail.muni.cz>,
       <linux-kernel@vger.kernel.org>,
       "'Jesse Brandeburg'" <jesse.brandeburg@intel.com>,
       "'Ronciak, John'" <john.ronciak@intel.com>
Subject: RE: Machine restart doesn't work - Intel 965G, 2.6.19-rc2 / e1000?
Date: Tue, 17 Oct 2006 15:14:03 -0700
Message-ID: <000601c6f239$8fd61ef0$3d3d7a86@dareddesktop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <45354850.6050900@intel.com>
Thread-Index: AcbyMdsbLkC9xzCiQNGCmZnx/g/faAABjr3w
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Auke Kok [mailto:auke-jan.h.kok@intel.com]
>Sent: Tuesday, October 17, 2006 2:17 PM
>To: Aleksey Gorelov
>Cc: Ryan Richter; Lukas Hejtmanek; linux-kernel@vger.kernel.org; auke-
>jan.h.kok@intel.com; Jesse Brandeburg; Ronciak, John
>Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2 / e1000?
>
>Aleksey Gorelov wrote:
>>
>> --- Ryan Richter <ryan@tau.solarneutrino.net> wrote:
>>> 2.6.19-rc1-git9 doesn't work any better for me.  I haven't tried
>>> unloading the e1000 module yet.  Since I run the machine off an nfsroot,
>>> it will require some creativity to test that.
>>>
>>> -ryan
>>
>> You may try the following patch instead if it's easier for you. It'll
>likely break suspend stuff,
>> but you won't need to play around with modules.
>>
>> Aleks.
>>
>> --- linux-2.6.19-rc2/drivers/net/e1000/e1000_main.c.orig	2006-10-17
>13:36:06.000000000 -0700
>> +++ linux-2.6.19-rc2/drivers/net/e1000/e1000_main.c	2006-10-17
>13:36:50.000000000 -0700
>> @@ -4847,6 +4847,7 @@
>>  static void e1000_shutdown(struct pci_dev *pdev)
>>  {
>>  	e1000_suspend(pdev, PMSG_SUSPEND);
>> +	pci_set_power_state(pdev, PCI_D0);
>>  }
>>
>>  #ifdef CONFIG_NET_POLL_CONTROLLER
>
>I wouldn't do that like this, since e1000_suspend already does a
>pci_set_power_state()
>right before it exits, and doing two of those closely after another might
>result in an
>undetermined state.
>
>I would be more interested in forcing D3 state instead of the current
>`pci_set_power_state(pdev, pci_choose_state(pdev, state));` in
>e1000_suspend, so can you
>try this instead?


But how this is different from original variant? 
pci_choose_state(pdev, PMSG_SUSPEND) returns PCI_D3hot, and it is when LAN
in this state machine does not reboot. That's why I tried PCI_D0 in first
place (actually, I've originally just remove pci_set_power_state call at
all). I did not try PCI_D3cold, though.

>
>diff --git a/drivers/net/e1000/e1000_main.c
>b/drivers/net/e1000/e1000_main.c
>index ce0d35f..30ceeec 100644
>--- a/drivers/net/e1000/e1000_main.c
>+++ b/drivers/net/e1000/e1000_main.c
>@@ -4793,7 +4793,7 @@ #endif
>
>         pci_disable_device(pdev);
>
>-       pci_set_power_state(pdev, pci_choose_state(pdev, state));
>+       pci_set_power_state(pdev, PCI_D3hot);
>
>         return 0;
>  }
>

>
>alternatively, you can try PCI_D3cold or PCI_D0, but setting the device to
>D0 is a
>no-op: the device is already in D0 at run-time, so that's silly.
>
>In any case: this is not a driver bug, but really (unfortunately) a
>platform issue, so
>this fix is not suitable for general cases *at all*, and we'd have to
>validate this
>nasty workaround on all other chipsets that e1000 supports too, something
>that ain't
>going to happen I'm sure.

Anyway, both patches are rather ugly, and will become even uglier with
checks for particular platform and system_state. I wish BIOS engineers fix
it 'the right way'.

Aleks

>
>constructive: I've just spend some time working with
>e100+suspend+shutdown+netconsole,
>so I'll audit e1000 for that in the next few weeks and make sure that all
>works
>properly. Perhaps that yields something for you.
>
>Cheers,
>
>Auke

