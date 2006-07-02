Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWGBN7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWGBN7j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 09:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWGBN7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 09:59:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:37792 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750724AbWGBN7h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 09:59:37 -0400
Message-ID: <44A7D13B.5020608@tw.ibm.com>
Date: Sun, 02 Jul 2006 21:59:23 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       matthieu castet <castet.matthieu@free.fr>
CC: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, akpm@osdl.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net>	 <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org>	 <449E5445.60008@free.fr>  <44A4CE21.30009@tw.ibm.com> <1151661803.31392.1.camel@localhost.localdomain>
In-Reply-To: <1151661803.31392.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-06-30 am 15:09 +0800, ysgrifennodd Albert Lee:
> 
>>If it is the problem of the specific ATAPI device, all controllers
>>should be affected, not only VIA. So, strange not seeing the problem on
>>Promise.
> 
> 
> That may be because of the way the chips handle buffering of interrupt
> delivery and readahead/writebehind. I have two traces on the ALi
> chipsets that look like the delayed response problem.
> 
> 
> 

Understood. Thanks for the explanation. Checked Matthieu's log, and yes
it does look like early interrupt. Matthieu's Sil680 has no such problem.
Also the problem is not reproducible with the same CD-RW drive on my
Promise 20275 chip. So, the explanation makes sense.

BTW, even for VIA, the early irq problem occur on 'set features - xfer mode'
but IDENTIFY works ok. Just curious, does the ALi chip have the same
symptom? i.e. Besides the 'set features' command, are there any other
commands affected by the early irq problem? Say, any other PIO non-data
commands?

--
albert

(The relevant part from Matthieu's log.)

ata_dev_set_xfermode: set features - xfer mode
ata4: ata_dev_select: ENTER, ata4: device 1, wait 1
ata_tf_load_pio: feat 0x3 nsect 0x42 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xB0
ata_exec_command_pio: ata4: cmd 0xEF
ata_host_intr: ata4: protocol 1 task_state 3  <=== early irq
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata4: ata_port_flush_task: flush #2
ata4: ata_port_flush_task: EXIT
__ata_port_freeze: ata4 port frozen
ata4.01: qc timeout (cmd 0xef)
ata_dev_set_xfermode: EXIT, err_mask=4
ata4.01: failed to set xfermode (err_mask=0x4)
ata4.01: limiting speed to UDMA/25
ata4: failed to recover some devices, retrying in 5 secs
__ata_port_freeze: ata4 port frozen


