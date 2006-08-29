Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWH2AZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWH2AZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 20:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWH2AZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 20:25:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:35269 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964944AbWH2AZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 20:25:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kcAAwMkEs0b5d6J9jq++IiRY8/h7mVem3oPbFysr22bVzrGLyLLWFnBdzFlR1shVHw0NYmrjfmmLdKfHB7a8MDpY0dUBtRkpF/UyrBbpyXAy4DBZPmtlQ83m5SWfs1kG0QzeD5uxLQURwZN0evCvDaQpE5qbuD3Hl/fJEsURp7o=
Message-ID: <b1bc6a000608281725v2b17df67pcba33e77f95e36db@mail.gmail.com>
Date: Mon, 28 Aug 2006 17:25:22 -0700
From: "adam radford" <aradford@gmail.com>
To: "Jim Klimov" <klimov@2ka.mipt.ru>
Subject: Re: 3ware glitches cause softraid rebuilds
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <1926236045.20060829034652@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1926236045.20060829034652@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim,

The 3ware driver reset code is doing msleep() polling with local interrupts
enabled... You shouldn't be getting soft lockups.  I'll do some investigation
into this.

BTW, this is a linux-scsi issue, not linux-kernel.

-Adam

On 8/28/06, Jim Klimov <klimov@2ka.mipt.ru> wrote:
> Hello linux-kernel,
>
>   In July I wrote about problems with our Xeon/3ware fileservers which
>   occasionally dump a stacktrace, usually of smbd somewhere in iptables
>   routines, and reboot. Possibly this can be because one of PCI-X buses
>   is shared by the 3Ware controller and onboard Intel Gigabit chips,
>   and some interrupt events have a conflict? Regardless, it's not good
>   anyway :)
>
>   Then I went on vacation and didn't reply in a timely fashion to a
>   suggestion to build a kernel with more debugging info. Now I did it
>   with a newer kernel and wait for those bugs to repeat.
>
>   Meanwhile I found a new strange behavior, not seen before. Sometimes
>   a 3Ware card times out, and usually begins to verify itself. That's
>   "normal", or rather usual and not considered critical. But now in
>   exactly 10 seconds a soft lockup bug happens and the raid1 arrays
>   (made by the linux md driver from 2 system ide drives) are rebuilt.
>
>   So far this has hit us twice:
>
> Kernel: 2.6.17.11 vanilla
>
> [  423.569222] 3w-9xxx: scsi0: AEN: INFO (0x04:0x0029): Verify started:unit=1.
> [  429.688317] 3w-9xxx: scsi1: AEN: INFO (0x04:0x0029): Verify started:unit=0.
> [ 7042.478001] 3w-9xxx: scsi0: AEN: INFO (0x04:0x002B): Verify completed:unit=1.
> [ 8387.242115] 3w-9xxx: scsi1: AEN: INFO (0x04:0x003D): Verify paused:unit=0.
> [ 8402.400749] 3w-9xxx: scsi1: AEN: INFO (0x04:0x0029): Verify started:unit=0.
> [17184.832241] sd 1:0:0:0: WARNING: (0x06:0x002C): Command (0x88) timed out,
> resetting card.
> [17194.818537] BUG: soft lockup detected on CPU#0!
> [17194.823249]  <c010396f> show_trace+0xd/0xf  <c0103a5a>
> dump_stack+0x17/0x1b
> [17194.825809]  <c0136ec8> softlockup_tick+0xa9/0xc2  <c0124be3>
> run_local_timers+0x12/0x14
> [17194.825834]  <c01249e6> update_process_times+0x34/0x78  <c010f5e7>
> smp_apic_timer_interrupt+0x58/0x60
> [17194.825858]  <c010359c> apic_timer_interrupt+0x1c/0x24  <c02c8d51>
> twa_reset_sequence+0x37/0x1e1
> [17194.825884]  <c02c8c90> twa_reset_device_extension+0xe9/0x173  <c02c9003>
> twa_scsi_eh_reset+0x6e/0xe4
> [17194.825908]  <c02bcd91> scsi_try_host_reset+0x43/0xb0  <c02bcfc5>
> scsi_eh_host_reset+0x2f/0xf4
> [17194.825932]  <c02bd40d> scsi_eh_ready_devs+0x56/0x65  <c02bd5ba>
> scsi_unjam_host+0xa3/0x1d0
> [17194.825954]  <c02bd76a> scsi_error_handler+0x83/0x112  <c012dd24>
> kthread+0x9f/0xa4
> [17194.825977]  <c0101009> kernel_thread_helper+0x5/0xb
> [17240.675713] 3w-9xxx: scsi1: AEN: INFO (0x04:0x0029): Verify
> started:unit=0.
> [19019.998212] md: syncing RAID array md0
> [19019.998231] md: minimum _guaranteed_ reconstruction speed: 1000
> KB/sec/disc.
> [19019.998243] md: using maximum available idle IO bandwidth (but not more
> than 200000 KB/sec) for reconstruction.
> [19019.998268] md: using 128k window, over a total of 500352 blocks.
> [19020.022029] md: delaying resync of md1 until md0 has finished resync
> (they share one or more physical units)
> [19020.079784] md: delaying resync of md10 until md1 has finished resync
> (they share one or more physical units)
> [19020.079813] md: delaying resync of md1 until md0 has finished resync
> (they share one or more physical units)
> [19020.265076] md: delaying resync of md11 until md10 has finished resync
> (they share one or more physical units)
> [19020.265106] md: delaying resync of md1 until md0 has finished resync
> (they share one or more physical units)
> [19020.265130] md: delaying resync of md10 until md1 has finished resync
> (they share one or more physical units)
> [19020.392908] md: delaying resync of md12 until md1 has finished resync
> (they share one or more physical units)
> [19020.392930] md: delaying resync of md10 until md12 has finished resync
> (they share one or more physical units)
> [19020.392953] md: delaying resync of md1 until md0 has finished resync
> (they share one or more physical units)
> [19020.392972] md: delaying resync of md11 until md12 has finished resync
> (they share one or more physical units)
> [19020.460745] md: delaying resync of md3 until md0 has finished resync
> (they share one or more physical units)
> [19020.468102] md: delaying resync of md5 until md3 has finished resync
> (they share one or more physical units)
> [19020.468122] md: delaying resync of md11 until md12 has finished resync
> (they share one or more physical units)
> [19020.468145] md: delaying resync of md1 until md5 has finished resync
> (they share one or more physical units)
> [19020.468162] md: delaying resync of md10 until md12 has finished resync
> (they share one or more physical units)
> [19020.468190] md: delaying resync of md3 until md0 has finished resync
> (they share one or more physical units)
> [19020.468210] md: delaying resync of md12 until md5 has finished resync
> (they share one or more physical units)
> [19020.476311] md: delaying resync of md6 until md12 has finished resync
> (they share one or more physical units)
> [19020.476334] md: delaying resync of md10 until md12 has finished resync
> (they share one or more physical units)
> [19020.476362] md: delaying resync of md1 until md5 has finished resync
> (they share one or more physical units)
> [19020.476382] md: delaying resync of md11 until md12 has finished resync
> (they share one or more physical units)
> [19020.476404] md: delaying resync of md12 until md5 has finished resync
> (they share one or more physical units)
> [19020.476434] md: delaying resync of md3 until md0 has finished resync
> (they share one or more physical units)
> [19020.476455] md: delaying resync of md5 until md3 has finished resync
> (they share one or more physical units)
> [19020.486455] md: delaying resync of md7 until md12 has finished resync
> (they share one or more physical units)
> [19020.486478] md: delaying resync of md11 until md12 has finished resync
> (they share one or more physical units)
> [19020.486503] md: delaying resync of md1 until md5 has finished resync
> (they share one or more physical units)
> [19020.486519] md: delaying resync of md10 until md12 has finished resync
> (they share one or more physical units)
> [19020.486542] md: delaying resync of md5 until md3 has finished resync
> (they share one or more physical units)
> [19020.486571] md: delaying resync of md3 until md0 has finished resync
> (they share one or more physical units)
> [19020.486593] md: delaying resync of md12 until md5 has finished resync
> (they share one or more physical units)
> [19020.486612] md: delaying resync of md6 until md12 has finished resync
> (they share one or more physical units)
> [19020.498362] md: delaying resync of md8 until md12 has finished resync
> (they share one or more physical units)
> [19020.498394] md: delaying resync of md12 until md5 has finished resync
> (they share one or more physical units)
> [19020.498414] md: delaying resync of md10 until md12 has finished resync
> (they share one or more physical units)
> [19020.498438] md: delaying resync of md1 until md5 has finished resync
> (they share one or more physical units)
> [19020.498457] md: delaying resync of md11 until md12 has finished resync
> (they share one or more physical units)
> [19020.498475] md: delaying resync of md6 until md12 has finished resync
> (they share one or more physical units)
> [19020.498509] md: delaying resync of md3 until md0 has finished resync
> (they share one or more physical units)
> [19020.498534] md: delaying resync of md5 until md3 has finished resync
> (they share one or more physical units)
> [19020.498553] md: delaying resync of md7 until md12 has finished resync
> (they share one or more physical units)
> [19020.612240] md: delaying resync of md9 until md12 has finished resync
> (they share one or more physical units)
> [19020.612309] md: delaying resync of md7 until md12 has finished resync
> (they share one or more physical units)
> [19020.612338] md: delaying resync of md5 until md3 has finished resync
> (they share one or more physical units)
> [19020.612371] md: delaying resync of md3 until md0 has finished resync
> (they share one or more physical units)
> [19020.612392] md: delaying resync of md6 until md12 has finished resync
> (they share one or more physical units)
> [19020.612412] md: delaying resync of md11 until md12 has finished resync
> (they share one or more physical units)
> [19020.612435] md: delaying resync of md1 until md5 has finished resync
> (they share one or more physical units)
> [19020.612456] md: delaying resync of md10 until md12 has finished resync
> (they share one or more physical units)
> [19020.612481] md: delaying resync of md12 until md5 has finished resync
> (they share one or more physical units)
> [19020.612501] md: delaying resync of md8 until md12 has finished resync
> (they share one or more physical units)
> [19047.955571] md: md0: sync done.
> [19047.996082] md: delaying resync of md8 until md12 has finished resync
> (they share one or more physical units)
> [19047.996105] md: delaying resync of md11 until md12 has finished resync
> (they share one or more physical units)
> [19047.996129] md: delaying resync of md6 until md12 has finished resync
> (they share one or more physical units)
> [19047.996143] md: delaying resync of md12 until md5 has finished resync
> (they share one or more physical units)
> [19047.996154] RAID1 conf printout:
> [19047.996171] md: syncing RAID array md3
> [19047.996179]  --- wd:2 rd:2
> [19047.996191]  disk 0, wo:0, o:1, dev:hdc1
> [19047.996199] md: minimum _guaranteed_ reconstruction speed: 1000
> KB/sec/disc.
> [19047.996211]  disk 1, wo:0, o:1, dev:hda1
> [19047.996220] md: using maximum available idle IO bandwidth (but not more
> than 200000 KB/sec) for reconstruction.
> [19047.996233] md: using 128k window, over a total of 5859904 blocks.
> [19047.998803] md: delaying resync of md5 until md3 has finished resync
> (they share one or more physical units)
> [19047.998820] md: delaying resync of md7 until md12 has finished resync
> (they share one or more physical units)
> [19047.998833] md: delaying resync of md9 until md12 has finished resync
> (they share one or more physical units)
> [19048.005192] md: delaying resync of md1 until md5 has finished resync
> (they share one or more physical units)
> [19048.005209] md: delaying resync of md10 until md12 has finished resync
> (they share one or more physical units)
> [19363.392599] md: md3: sync done.
> [19363.453882] md: delaying resync of md10 until md12 has finished resync
> (they share one or more physical units)
> [19363.453894] md: delaying resync of md9 until md12 has finished resync
> (they share one or more physical units)
> [19363.453926] md: delaying resync of md1 until md5 has finished resync
> (they share one or more physical units)
> [19363.453934] md: syncing RAID array md5
> [19363.453942] md: minimum _guaranteed_ reconstruction speed: 1000
> KB/sec/disc.
> [19363.453950] md: using maximum available idle IO bandwidth (but not more
> than 200000 KB/sec) for reconstruction.
> [19363.453963] md: using 128k window, over a total of 3906368 blocks.
> [19363.453970] md: delaying resync of md7 until md12 has finished resync
> (they share one or more physical units)
> [19363.453985] md: delaying resync of md6 until md12 has finished resync
> (they share one or more physical units)
> [19363.454003] md: delaying resync of md11 until md12 has finished resync
> (they share one or more physical units)
> [19363.454122] RAID1 conf printout:
> [19363.455970] md: delaying resync of md12 until md5 has finished resync
> (they share one or more physical units)
> [19363.455985] md: delaying resync of md8 until md12 has finished resync
> (they share one or more physical units)
> [19363.457941]  --- wd:2 rd:2
> [19363.461140]  disk 0, wo:0, o:1, dev:hdc3
> [19363.465654]  disk 1, wo:0, o:1, dev:hda3
> [19514.855587] md: md5: sync done.
> [19514.894392] md: delaying resync of md8 until md12 has finished resync
> (they share one or more physical units)
> [19514.894431] md: delaying resync of md12 until md1 has finished resync
> (they share one or more physical units)
> [19514.894467] md: syncing RAID array md1
> [19514.894476] md: delaying resync of md11 until md12 has finished resync
> (they share one or more physical units)
> [19514.894489] md: minimum _guaranteed_ reconstruction speed: 1000
> KB/sec/disc.
> [19514.894497] md: delaying resync of md6 until md12 has finished resync
> (they share one or more physical units)
> [19514.894508] md: using maximum available idle IO bandwidth (but not more
> than 200000 KB/sec) for reconstruction.
> [19514.894518] md: delaying resync of md7 until md12 has finished resync
> (they share one or more physical units)
> [19514.894531] md: delaying resync of md10 until md12 has finished resync
> (they share one or more physical units)
> [19514.894540] md: using 128k window, over a total of 2000256 blocks.
> [19514.894628] RAID1 conf printout:
> [19514.896747] md: delaying resync of md9 until md12 has finished resync
> (they share one or more physical units)
> [19514.898392]  --- wd:2 rd:2
> [19514.901370]  disk 0, wo:0, o:1, dev:hdc5
> [19514.905901]  disk 1, wo:0, o:1, dev:hda5
> [19590.739467] md: md1: sync done.
> [19590.797061] md: delaying resync of md10 until md12 has finished resync
> (they share one or more physical units)
> [19590.797080] md: delaying resync of md9 until md12 has finished resync
> (they share one or more physical units)
> [19590.797120] md: delaying resync of md7 until md12 has finished resync
> (they share one or more physical units)
> [19590.797131] md: syncing RAID array md12
> [19590.797142] md: delaying resync of md6 until md12 has finished resync
> (they share one or more physical units)
> [19590.797162] md: minimum _guaranteed_ reconstruction speed: 1000
> KB/sec/disc.
> [19590.797174] md: delaying resync of md11 until md12 has finished resync
> (they share one or more physical units)
> [19590.797192] md: using maximum available idle IO bandwidth (but not more
> than 200000 KB/sec) for reconstruction.
> [19590.797209] md: using 128k window, over a total of 5244992 blocks.
> [19590.797232] RAID1 conf printout:
> [19590.799289] md: delaying resync of md8 until md12 has finished resync
> (they share one or more physical units)
> [19590.800846]  --- wd:2 rd:2
> [19590.803920]  disk 0, wo:0, o:1, dev:hdc2
> [19590.808568]  disk 1, wo:0, o:1, dev:hda2
> [19942.989053] md: md12: sync done.
> [19943.085278] md: delaying resync of md8 until md7 has finished resync
> (they share one or more physical units)
> [19943.085291] md: delaying resync of md6 until md11 has finished resync
> (they share one or more physical units)
> [19943.085315] md: delaying resync of md9 until md8 has finished resync
> (they share one or more physical units)
> [19943.085340] md: delaying resync of md11 until md10 has finished resync
> (they share one or more physical units)
> [19943.085377] RAID1 conf printout:
> [19943.085386] md: syncing RAID array md7
> [19943.085396] md: minimum _guaranteed_ reconstruction speed: 1000
> KB/sec/disc.
> [19943.085404] md: using maximum available idle IO bandwidth (but not more
> than 200000 KB/sec) for reconstruction.
> [19943.085417] md: using 128k window, over a total of 1953408 blocks.
> [19943.086535] md: delaying resync of md10 until md9 has finished resync
> (they share one or more physical units)
> [19943.088928]  --- wd:2 rd:2
> [19943.091916]  disk 0, wo:0, o:1, dev:hdc12
> [19943.096249]  disk 1, wo:0, o:1, dev:hda12
> [20033.019114] md: md7: sync done.
> [20033.090440] md: delaying resync of md6 until md11 has finished resync
> (they share one or more physical units)
> [20033.090460] md: syncing RAID array md8
> [20033.090470] md: minimum _guaranteed_ reconstruction speed: 1000
> KB/sec/disc.
> [20033.090477] md: using maximum available idle IO bandwidth (but not more
> than 200000 KB/sec) for reconstruction.
> [20033.090489] md: using 128k window, over a total of 5859904 blocks.
> [20033.090571] md: delaying resync of md10 until md9 has finished resync
> (they share one or more physical units)
> [20033.090589] md: delaying resync of md9 until md8 has finished resync
> (they share one or more physical units)
> [20033.090602] md: delaying resync of md11 until md10 has finished resync
> (they share one or more physical units)
> [20033.090646] RAID1 conf printout:
> [20033.094083]  --- wd:2 rd:2
> [20033.097113]  disk 0, wo:0, o:1, dev:hdc7
> [20033.101318]  disk 1, wo:0, o:1, dev:hda7
> [20283.332772] md: md8: sync done.
> [20283.392384] md: delaying resync of md11 until md10 has finished resync
> (they share one or more physical units)
> [20283.392411] md: delaying resync of md6 until md11 has finished resync
> (they share one or more physical units)
> [20283.392432] RAID1 conf printout:
> [20283.392479] md: syncing RAID array md9
> [20283.392495] md: minimum _guaranteed_ reconstruction speed: 1000
> KB/sec/disc.
> [20283.392521] md: using maximum available idle IO bandwidth (but not more
> than 200000 KB/sec) for reconstruction.
> [20283.392557] md: using 128k window, over a total of 3906368 blocks.
> [20283.395898] md: delaying resync of md10 until md9 has finished resync
> (they share one or more physical units)
> [20283.396045]  --- wd:2 rd:2
> [20283.399015]  disk 0, wo:0, o:1, dev:hdc8
> [20283.403257]  disk 1, wo:0, o:1, dev:hda8
> [20452.540323] md: md9: sync done.
> [20452.610616] md: delaying resync of md6 until md11 has finished resync
> (they share one or more physical units)
> [20452.610633] md: syncing RAID array md10
> [20452.610661] md: minimum _guaranteed_ reconstruction speed: 1000
> KB/sec/disc.
> [20452.610669] RAID1 conf printout:
> [20452.610679]  --- wd:2 rd:2
> [20452.610692]  disk 0, wo:0, o:1, dev:hdc9
> [20452.610706]  disk 1, wo:0, o:1, dev:hda9
> [20452.611783] md: delaying resync of md11 until md10 has finished resync
> (they share one or more physical units)
> [20452.625535] md: using maximum available idle IO bandwidth (but not more
> than 200000 KB/sec) for reconstruction.
> [20452.625576] md: using 128k window, over a total of 3906368 blocks.
> [20608.982515] md: md10: sync done.
> [20609.027444] md: delaying resync of md6 until md11 has finished resync
> (they share one or more physical units)
> [20609.027460] md: syncing RAID array md11
> [20609.027473] md: minimum _guaranteed_ reconstruction speed: 1000
> KB/sec/disc.
> [20609.027485] md: using maximum available idle IO bandwidth (but not more
> than 200000 KB/sec) for reconstruction.
> [20609.027503] md: using 128k window, over a total of 65430144 blocks.
> [20609.027558] RAID1 conf printout:
> [20609.031138]  --- wd:2 rd:2
> [20609.034093]  disk 0, wo:0, o:1, dev:hdc10
> [20609.038435]  disk 1, wo:0, o:1, dev:hda10
> [22231.702114] sd 1:0:0:0: WARNING: (0x06:0x002C): Command (0x88) timed out,
> resetting card.
> [22241.688436] BUG: soft lockup detected on CPU#1!
> [22241.693331]  <c010396f> show_trace+0xd/0xf  <c0103a5a>
> dump_stack+0x17/0x1b
> [22241.695899]  <c0136ec8> softlockup_tick+0xa9/0xc2  <c0124be3>
> run_local_timers+0x12/0x14
> [22241.695929]  <c01249e6> update_process_times+0x34/0x78  <c010f5e7>
> smp_apic_timer_interrupt+0x58/0x60
> [22241.695961]  <c010359c> apic_timer_interrupt+0x1c/0x24  <c02c8d51>
> twa_reset_sequence+0x37/0x1e1
> [22241.695994]  <c02c8c90> twa_reset_device_extension+0xe9/0x173  <c02c9003>
> twa_scsi_eh_reset+0x6e/0xe4
> [22241.696027]  <c02bcd91> scsi_try_host_reset+0x43/0xb0  <c02bcfc5>
> scsi_eh_host_reset+0x2f/0xf4
> [22241.696059]  <c02bd40d> scsi_eh_ready_devs+0x56/0x65  <c02bd5ba>
> scsi_unjam_host+0xa3/0x1d0
> [22241.696086]  <c02bd76a> scsi_error_handler+0x83/0x112  <c012dd24>
> kthread+0x9f/0xa4
> [22241.696119]  <c0101009> kernel_thread_helper+0x5/0xb
> [22335.486623] 3w-9xxx: scsi1: AEN: INFO (0x04:0x0029): Verify
> started:unit=0.
> [22887.014006] 3w-9xxx: scsi1: AEN: INFO (0x04:0x002B): Verify
> completed:unit=0.
> [23994.650143] md: md11: sync done.
> [23994.804031] md: syncing RAID array md6
> [23994.804051] RAID1 conf printout:
> [23994.804065] md: minimum _guaranteed_ reconstruction speed: 1000
> KB/sec/disc.
> [23994.804075] md: using maximum available idle IO bandwidth (but not more
> than 200000 KB/sec) for reconstruction.
> [23994.804094] md: using 128k window, over a total of 1953408 blocks.
> [23994.808154]  --- wd:2 rd:2
> [23994.811253]  disk 0, wo:0, o:1, dev:hdc11
> [23994.815967]  disk 1, wo:0, o:1, dev:hda11
> [24225.817451] md: md6: sync done.
> [24225.939633] RAID1 conf printout:
> [24225.943358]  --- wd:2 rd:2
> [24225.946614]  disk 0, wo:0, o:1, dev:hdc6
> [24225.950917]  disk 1, wo:0, o:1, dev:hda6
>
>
> --
> Best regards,
>  Jim Klimov                          mailto:klimov@2ka.mipt.ru
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
