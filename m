Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbULHVlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbULHVlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbULHVlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:41:55 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:61780 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261370AbULHVlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:41:50 -0500
Message-ID: <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
In-Reply-To: <1102532625.25841.327.camel@localhost.localdomain>
References: <20041116130946.GA11053@elte.hu> 
    <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> 
    <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> 
    <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> 
    <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> 
    <20041207132927.GA4846@elte.hu>  <20041207141123.GA12025@elte.hu> 
    <1102526018.25841.308.camel@localhost.localdomain> 
    <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
    <1102532625.25841.327.camel@localhost.localdomain>
Date: Wed, 8 Dec 2004 21:39:20 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, "LKML" <linux-kernel@vger.kernel.org>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Mark Johnson" <mark_h_johnson@raytheon.com>,
       "K.R. Foley" <kr@cybsft.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 08 Dec 2004 21:41:49.0110 (UTC) FILETIME=[B8E0D560:01C4DD6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
>> Steven Rostedt wrote:
>> >
>> > I found a race condition in slab.c, but I'm still trying to figure
>> > out exactly how it's playing out.  This has to do with dynamic
>> > loading and unloading of caches. I have a small test case that
>> > simulates the problem at
>> > http://home.stny.rr.com/rostedt/tests/sillycaches.tgz
>> >
>> > This was done on:
>> >
>> > # uname -r
>> > 2.6.10-rc2-mm3-V0.7.32-9
>> >

>
> Rui,
>
> Try adding the following in slab.c
>
> --- slab.c      2004-12-08 09:27:10.000000000 -0500
> +++ slab.c.new  2004-12-08 13:58:40.000000000 -0500
> @@ -1533,6 +1533,12 @@
>  #ifndef CONFIG_PREEMPT_RT
>         smp_call_function_all_cpus(do_drain, cachep);
>  #endif
> +       {
> +               struct array_cache *ac;
> +               ac = ac_data(cachep, smp_processor_id());
> +               free_block(cachep, &ac_entry(ac)[0], ac->avail);
> +               ac->avail = 0;
> +       }
>         check_irq_on();
>         spin_lock_irq(&cachep->spinlock);
>         if (cachep->lists.shared)
>
>
> and see if this fixes your usb problems.  I would say that this is not a
> proper fix and especially for a SMP system. But if it fixes your problem
> then you know this is the solution.
>

Almost there, perhaps not...

It doesn't solve the problem completely, if not at all. What was kind of a
deterministic failure now seems probabilistic: the fault still occur on
unplugging the usb-storage stick, but not everytime as before.

Did try several times, reboot included, and now it fails after unplugging
a second or a third time. Never needed to replug/unplug more than 3 times
for it to show up, however.

Here is one sample, taken on the patched RT-V0.7.32-9:

 usb 4-5: USB disconnect, address 7
 slab error in kmem_cache_destroy(): cache `scsi_cmd_cache': Can't free
all objects
  [<c010361f>] dump_stack+0x23/0x25 (20)
  [<c014669f>] kmem_cache_destroy+0x103/0x1aa (28)
  [<c026e61a>] scsi_destroy_command_freelist+0x97/0xa8 (28)
  [<c026f451>] scsi_host_dev_release+0x37/0xe1 (104)
  [<c023c569>] device_release+0x7a/0x7c (32)
  [<c01efc50>] kobject_cleanup+0x87/0x89 (28)
  [<c01f06ab>] kref_put+0x52/0xef (40)
  [<c01efc8c>] kobject_put+0x25/0x27 (16)
  [<f8cf1843>] usb_stor_release_resources+0x66/0xca [usb_storage] (16)
  [<f8cf1d93>] storage_disconnect+0x8e/0x9b [usb_storage] (16)
  [<f89ca117>] usb_unbind_interface+0x84/0x86 [usbcore] (28)
  [<c023d7d5>] device_release_driver+0x75/0x77 (28)
  [<c023d9d8>] bus_remove_device+0x53/0x82 (20)
  [<c023c9a1>] device_del+0x4b/0x9b (20)
  [<f89d142a>] usb_disable_device+0xf5/0x10a [usbcore] (28)
  [<f89cc61c>] usb_disconnect+0xc8/0x164 [usbcore] (40)
  [<f89cd77e>] hub_port_connect_change+0x2ef/0x426 [usbcore] (56)
  [<f89cda7b>] hub_events+0x1c6/0x39d [usbcore] (56)
  [<f89cdc89>] hub_thread+0x37/0x109 [usbcore] (96)
  [<c01009b1>] kernel_thread_helper+0x5/0xb (150118420)

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

