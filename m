Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269617AbUIRT0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269617AbUIRT0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 15:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269618AbUIRT0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 15:26:25 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:13532 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S269617AbUIRT0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 15:26:02 -0400
Message-ID: <414C8BC4.30303@softhome.net>
Date: Sat, 18 Sep 2004 21:25:56 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.8 (Macintosh/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fact that a static /dev keeps these race conditions from showing up
> as often as they really are there is no reason to keep trying to rely on
> old, undefined behaviour :)

   [ I'm late to discussion, and do not have much time at all.
   Just observation from aside by driver writer and OS builder. ]

   You really do not solve problem - problem as I see it - but just move 
it around.

   When I did first release of device driver for some obscure device, I 
used to wait in init script for "touch /dev/whatever" to be Ok. My 
device was ok with dumb open()/close() sequence.

   What I was really missing - is a way to tell user space that not only 
driver loaded Ok, but that device was found, diagnosed and upped Ok. 
Diagnostics was taking time - that's why I tryed to do it async. While 
device does some inernal spinning, I can load up other drivers.

   I haven't found any reasonable solution. module_init() is locking 
everything - I cannot load any other module, while one module is 
loading. But from user space point of view this is the only way to 
return error from device driver.

   IOW, mapping my experience to this discussion, we need to have a way 
for user space to wait for discover process to end. After all user space 
knows better than enyone in kernel what to expect from loaded driver.

   We are not talking about hot-plug and preloading of modules. We are 
talking more about the case where system cannot go on without requested 
device & its device node. We need a way for modprobe to be able to wait 
for driver initialization phases (we do not have them - make it sense to 
have them?): driver initialization, device discovery, device 
initialization, device node ready. So then user space will be able to 
wait for driver to reach any of given phases. If init script needs 
/dev/sda1 and after all phases completed Ok we failed to locate it - it 
can mean only one thing - /dev/sda1 is not here. Since modprobe will 
wait - it will mean that we will be able to return error, if any. IMHO 
that what need to be implemented. Polling is crappy solution: we do not 
need to poll for something we can reliably find out.

   We have all info in kernel in drivers - we need a way to give it back 
to user space for both play nice with each other.

   My 0.02 Euro.
