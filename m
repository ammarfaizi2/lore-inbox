Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWIFGXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWIFGXr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 02:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWIFGXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 02:23:47 -0400
Received: from 66-117-159-244.lmi.net ([66.117.159.244]:14312 "EHLO slick.org")
	by vger.kernel.org with ESMTP id S1751535AbWIFEtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 00:49:49 -0400
Message-ID: <44FE536C.8080000@imvu.com>
Date: Tue, 05 Sep 2006 21:49:48 -0700
From: "Brett G. Durrett" <brett@imvu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sumant.Patro@lsil.com, Sreenivas.Bagalkote@lsil.com
CC: lkml <linux-kernel@vger.kernel.org>, dlloyd@exegy.com
Subject: megaraid_sas waiting for command and then offline
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have the same or a similar issue running 2.6.17 SMP x86_64 - the 
megaraid_sas driver hangs waiting for commands and then the filesystem 
unmounts, leaving the machine in an unusable state until there is a hard 
reboot (the machine is responsive but any access, shell or otherwise, is 
impossible without the filesystem).  While I do not have much debugging 
information available, this happens to me about once every 6-7 days in 
my pool of seven machines, so I can probably get debugging info.  Since 
the disk is offline and I can't get remote console, I don't have any 
details except something similar to Dave Lloyd's post, below.

The only thing that the machines with these failures seem to have in 
common is the fact that they are almost exclusively writes - they are 
slave database machines with large memory and pretty much just 
replicate.  The read/write machines seem to have less failures.

I am happy to help provide debugging information in any reasonable way.  
In the mean time, if there are any known suggestions or workarounds for 
the problem, I would be grateful for the guidance.

Here are what details on the controller.  If you want additional info, 
let me know exactly what you need and I will do what I can to get it to 
you.:

Product Name    : PERC 5/i Integrated
Serial No       : 12345
FW Package Build: 5.0.1-0030
FW Version      : 1.00.01-0088
BIOS Version    : MT23
Ctrl-R Version  :1.02-007

B-


Subject 	RE: MegaRaid 8408E goes out to lunch with nr_requests > 8
Date 	Thu, 13 Jul 2006 09:25:09 -0600
>From 	"Patro, Sumant" <>

Hello Dave,

	I tried to duplicate the issue with 2.6.18rc1 but did not see
the issue. From the message it looks like the Firmware has stopped
processing cmds. Could you please let us know the Firmware version of
the controller ? 

Thanks,

Sumant

-----Original Message----- 
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Dave Lloyd
Sent: Wednesday, July 12, 2006 7:47 AM
To: linux-kernel@vger.kernel.org; Berkley Shands
Subject: MegaRaid 8408E goes out to lunch with nr_requests > 8
This happens both on 2.6.17 and 2.6.18rc1 using the megaraid, mptsas and
mptscsih drivers supplied with the kernel.

While writing data to raid0 devs on a LSI MegaRaid 8408E controller, the
devices will hang after somewhere between 4-7gb of data written.  If I
dial the nr_requests back from the default down to 8, the hang will not
occur.  The hang does occur at 16.  I haven't tested values between the
two, but I'm not too optimistic.  From what I can see, it looks like 8
should be a magic number to make the queue look congested more often
than not.

Here are the messages I get when the devices go out to lunch:
Jul 11 14:13:34 systemname kernel: sd 4:2:0:0: megasas: RESET -40213
cmd=2a
Jul 11 14:13:34 systemname kernel: megasas: [ 0]waiting for 256 commands
to complete
Jul 11 14:13:39 systemname kernel: megasas: [ 5]waiting for 256 commands
to complete
Jul 11 14:13:44 systemname kernel: megasas: [10]waiting for 256 commands
to complete
Jul 11 14:13:49 systemname kernel: megasas: [15]waiting for 256 commands
to complete

[...]

Jul 11 14:16:35 systemname kernel: megasas: [175]waiting for 256
commands to complete
Jul 11 14:16:35 systemname kernel: megasas: failed to do reset
Jul 11 14:16:35 systemname kernel: sd 4:2:1:0: megasas: RESET -40216
cmd=2a
Jul 11 14:16:35 systemname kernel: megasas: cannot recover from previous
reset failures
Jul 11 14:16:35 systemname kernel: sd 4:2:0:0: megasas: RESET -40213
cmd=2a
Jul 11 14:16:35 systemname kernel: megasas: cannot recover from previous
reset failures
Jul 11 14:16:35 systemname kernel: sd 4:2:0:0: megasas: RESET -40213
cmd=2a
Jul 11 14:16:35 systemname kernel: megasas: cannot recover from previous
reset failures
Jul 11 14:16:35 systemname kernel: sd 4:2:0:0: scsi: Device offlined -
not ready after error recovery
Jul 11 14:16:36 systemname last message repeated 13 times

Interestingly, the machine will hang on shutdown and requires a hard
reset to reboot.  Bummer!

My next step is to try and reproduce and dig into this some in KDB.

Has anyone else seen this and/or does anyone have some suggestions for
further debugging info?

-- 
Dave Lloyd
Test Engineer, Exegy, Inc.
314.450.5342
dlloyd@exegy.com


