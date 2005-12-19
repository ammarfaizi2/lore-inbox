Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVLSCfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVLSCfs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 21:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVLSCfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 21:35:48 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:17127 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932178AbVLSCfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 21:35:48 -0500
Message-ID: <43A61BE4.7050709@jp.fujitsu.com>
Date: Mon, 19 Dec 2005 11:33:08 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG][PATCH] e1000: Fix invalid memory reference
References: <439EA1F4.3000204@jp.fujitsu.com> <9929d2390512161841m516b3728i8c08af3e83a4472f@mail.gmail.com>
In-Reply-To: <9929d2390512161841m516b3728i8c08af3e83a4472f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

> Could you provide the test case you used to get the kernel panic? and
> system related information.

I encountered the kernel panic when I repeated pci hotplug with
e1000 card on ia64 box. But please noted that the current e1000
driver always refers invalid memory regardless of pci hotplug.

In my understanding, e1000 driver set the adapter->bd_number
incrementally when a new e1000 card is initialized. So first
card has 0, second card has 1,..., as bd_number. On the other
hand, num_AutoNeg is 0 on my environment because I don't put
any module options for e1000 driver. Here, in the following
code path you mentioned, "int an = AutoNeg[bd];" cause invalid
memory reference.

>    if ((num_AutoNeg > bd) && (speed != 0 || dplx != 0)) {
>         DPRINTK(PROBE, INFO,
>                "AutoNeg specified along with Speed or Duplex, "
>                "parameter ignored\n");
>         adapter->hw.autoneg_advertised = AUTONEG_ADV_DEFAULT;
>     } else { /* Autoneg */
>                           .
>                           .
>                           .
> 
>         int an = AutoNeg[bd];
>         e1000_validate_option(&an, &opt, adapter);
>         adapter->hw.autoneg_advertised = an;
>     }



> num_Autoneg > bd will never be true  at this point in the code because
> we do the following test before we execute this branch.
> 

Why????????
Do you mean (speed != 0 || dplx != 0) will always be true when
num_Autoneg > bd is true? If yes, why do you need the following
if statement? Do you mean the current e1000 driver has another
bug?

>    if ((num_AutoNeg > bd) && (speed != 0 || dplx != 0)) {


Thanks,
Kenji Kaneshige



Jeff Kirsher wrote:
> On 12/13/05, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
> 
>>Hi,
>>
>>I encountered a kernel panic which was caused by the invalid memory
>>access by e1000 driver. The following patch fixes this issue.
>>
>>Thanks,
>>Kenji Kaneshige
>>
>>
>>This patch fixes invalid memory reference in the e1000 driver which
>>would cause kernel panic.
>>
>>Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
>>
>> drivers/net/e1000/e1000_param.c |   10 +++++++---
>> 1 files changed, 7 insertions(+), 3 deletions(-)
>>
>>Index: linux-2.6.15-rc5/drivers/net/e1000/e1000_param.c
>>===================================================================
>>--- linux-2.6.15-rc5.orig/drivers/net/e1000/e1000_param.c
>>+++ linux-2.6.15-rc5/drivers/net/e1000/e1000_param.c
>>@@ -545,7 +545,7 @@ e1000_check_fiber_options(struct e1000_a
>> static void __devinit
>> e1000_check_copper_options(struct e1000_adapter *adapter)
>> {
>>-       int speed, dplx;
>>+       int speed, dplx, an;
>>        int bd = adapter->bd_number;
>>
>>        { /* Speed */
>>@@ -641,8 +641,12 @@ e1000_check_copper_options(struct e1000_
>>                                         .p = an_list }}
>>                };
>>
>>-               int an = AutoNeg[bd];
>>-               e1000_validate_option(&an, &opt, adapter);
>>+               if (num_AutoNeg > bd) {
>>+                       an = AutoNeg[bd];
>>+                       e1000_validate_option(&an, &opt, adapter);
>>+               } else {
>>+                       an = opt.def;
>>+               }
>>                adapter->hw.autoneg_advertised = an;
>>        }
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 
> Could you provide the test case you used to get the kernel panic? and
> system related information.
> 
> num_Autoneg > bd will never be true  at this point in the code because
> we do the following test before we execute this branch.
> 
>    if ((num_AutoNeg > bd) && (speed != 0 || dplx != 0)) {
>         DPRINTK(PROBE, INFO,
>                "AutoNeg specified along with Speed or Duplex, "
>                "parameter ignored\n");
>         adapter->hw.autoneg_advertised = AUTONEG_ADV_DEFAULT;
>     } else { /* Autoneg */
>                           .
>                           .
>                           .
> 
>         int an = AutoNeg[bd];
>         e1000_validate_option(&an, &opt, adapter);
>         adapter->hw.autoneg_advertised = an;
>     }
> 
> 
> --
> Cheers,
> Jeff
> 

