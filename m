Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbSIWXRj>; Mon, 23 Sep 2002 19:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbSIWXRj>; Mon, 23 Sep 2002 19:17:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4869 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261457AbSIWXRh>;
	Mon, 23 Sep 2002 19:17:37 -0400
Message-ID: <3D8FA22A.6050104@pobox.com>
Date: Mon, 23 Sep 2002 19:22:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Konstantin Kletschke <konsti@ludenkalle.de>, linux-kernel@vger.kernel.org
Subject: Re: Quick aic7xxx bug hunt...
References: <20020923180017.GA16270@sexmachine.doom> <2539730816.1032808544@aslan.btc.adaptec.com> <3D8F874B.3070301@mandrakesoft.com> <2640410816.1032818062@aslan.btc.adaptec.com> <3D8F934F.7000606@mandrakesoft.com> <2678680816.1032821098@aslan.btc.adaptec.com> <3D8F9AB9.1040505@mandrakesoft.com> <2687750816.1032821710@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:
>>>For all of these delays, I'd be more than happy to make them all into
>>>sleeps if I can tell, from inside ahc_delay() if I'm in a context where
>>>it is safe to sleep.  On the other platforms that this core code runs on
>>>I'm usually not in a context where it is safe to sleep, so I don't want
>>>to switch to using a different driver primitive.
>>
>>For Linux it's unconditionally safe, and other platforms is sounds like
>>it's unconditionally not.  So, s/ahc_delay/ahc_sleep/ for the places I
>>pointed out, and just make ahc_delay==ahc_sleep on non-Linux platforms
>>(or any similarly-functioning solution)
> 
> 
> So you can sleep while in an interrupt context?  I didn't know that
> 2.5 had switched to using interrupt threads or some similar construct.


Of course not :)

ahc_reset
	aic7770_config -> can sleep
	ahc_pci_config -> can sleep
	ahc_shutdown -> can't sleep, whoops
	ahc_resume -> dead code
ahc_init
	aic7770_config -> can sleep
	ahc_pci_config -> can sleep
ahc_acquire_seeprom
	check_extport -> can sleep
	ahc_proc_write_seeprom -> can sleep

so, ahc_init and ahc_acquire_seeprom can s/ahc_delay/ahc_sleep/ safely.

Oh, and I found another bug:  never use check_region, it's inherently 
racy.  Use request_region and check its return value.	

Note I agree with a comment in the code, that wrapping SHT->detect() in 
io_request_lock is silly...  the comment describing the rationale in 
drivers/scsi/scsi.c is not really accurate...

	Jeff



