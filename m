Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbULHWMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbULHWMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 17:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbULHWMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 17:12:14 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:30663 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261384AbULHWLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 17:11:54 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: Steven Rostedt <rostedt@goodmis.org>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
References: <20041116130946.GA11053@elte.hu>
	 <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
	 <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu>
	 <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu>
	 <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu>
	 <20041207132927.GA4846@elte.hu>  <20041207141123.GA12025@elte.hu>
	 <1102526018.25841.308.camel@localhost.localdomain>
	 <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
	 <1102532625.25841.327.camel@localhost.localdomain>
	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Wed, 08 Dec 2004 17:11:44 -0500
Message-Id: <1102543904.25841.356.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 21:39 +0000, Rui Nuno Capela wrote:
> 
> Almost there, perhaps not...
> 
> It doesn't solve the problem completely, if not at all. What was kind of a
> deterministic failure now seems probabilistic: the fault still occur on
> unplugging the usb-storage stick, but not everytime as before.
> 

OK, so I would say that this is part of a fix, but there are others.
There are lots of changes done to the slab.c file by Ingo.  The change I
made (and that is just a quick patch, it needs real work), was only in a
place that was obvious that there could be problems. 

Are you running an SMP machine? If so, than the patch I gave you is
definitely not enough. 

Ingo really scares me with all the removing of local_irq_disables in the
rt mode. I'm not sure exactly what is going on there, and why they can,
or should be removed. Ingo?

> Did try several times, reboot included, and now it fails after unplugging
> a second or a third time. Never needed to replug/unplug more than 3 times
> for it to show up, however.
> 
> Here is one sample, taken on the patched RT-V0.7.32-9:
> 
>  usb 4-5: USB disconnect, address 7
>  slab error in kmem_cache_destroy(): cache `scsi_cmd_cache': Can't free
> all objects
>   [<c010361f>] dump_stack+0x23/0x25 (20)
>   [<c014669f>] kmem_cache_destroy+0x103/0x1aa (28)
>   [<c026e61a>] scsi_destroy_command_freelist+0x97/0xa8 (28)
>   [<c026f451>] scsi_host_dev_release+0x37/0xe1 (104)
>   [<c023c569>] device_release+0x7a/0x7c (32)
>   [<c01efc50>] kobject_cleanup+0x87/0x89 (28)
>   [<c01f06ab>] kref_put+0x52/0xef (40)
>   [<c01efc8c>] kobject_put+0x25/0x27 (16)
>   [<f8cf1843>] usb_stor_release_resources+0x66/0xca [usb_storage] (16)
>   [<f8cf1d93>] storage_disconnect+0x8e/0x9b [usb_storage] (16)
>   [<f89ca117>] usb_unbind_interface+0x84/0x86 [usbcore] (28)
>   [<c023d7d5>] device_release_driver+0x75/0x77 (28)
>   [<c023d9d8>] bus_remove_device+0x53/0x82 (20)
>   [<c023c9a1>] device_del+0x4b/0x9b (20)
>   [<f89d142a>] usb_disable_device+0xf5/0x10a [usbcore] (28)
>   [<f89cc61c>] usb_disconnect+0xc8/0x164 [usbcore] (40)
>   [<f89cd77e>] hub_port_connect_change+0x2ef/0x426 [usbcore] (56)
>   [<f89cda7b>] hub_events+0x1c6/0x39d [usbcore] (56)
>   [<f89cdc89>] hub_thread+0x37/0x109 [usbcore] (96)
>   [<c01009b1>] kernel_thread_helper+0x5/0xb (150118420)
> 

Unfortunately this really doesn't help. The problem occurs earlier than
this. What happened was that there are still slabs out there that need
to be freed that were postponed to a later time and not done with the
kmem_cache_free call.  So this dump only tells you that. The backtrace
unfortunately doesn't give us any more clues.  It's all in the slab.c
code.
(Of course if the driver really did not free the objects then it's not
slab.c's fault, and why Ingo may not have thought it was related to RT)

Tschuess,

-- Steve

