Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264249AbTDPGpc (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 02:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264250AbTDPGpc 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 02:45:32 -0400
Received: from sj-core-1.cisco.com ([171.71.177.237]:35571 "EHLO
	sj-core-1.cisco.com") by vger.kernel.org with ESMTP id S264249AbTDPGpb 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 02:45:31 -0400
Message-Id: <5.1.0.14.2.20030416162813.03b1b6e8@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 16 Apr 2003 16:56:16 +1000
To: Jurjen Oskam <jurjen@quadpro.stupendous.org>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Booting from Qlogic qla2300 fibre channel card
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030416061830.GA30423@quadpro.stupendous.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 08:18 AM 16/04/2003 +0200, Jurjen Oskam wrote:
>At work, we are looking to deploy several Linux boxes on our SAN. The
>machines will be IBM eServer xSeries 345 with Qlogic qla2340 Fibre Channel
>cards, and no internal disks.
>
>The storage array is an EMC Symmetrix model 8530. EMC created a document
>where they explain how to make such a configuration work. When they mention
>booting from a Symmetrix-provided volume, they mention the following:
>
>"If Linux loses connectivity long enough, the disks disappear from the
>system. [...] For [this reason], EMC recommends that you do not boot a
>Linux host from the EMC storage array."

in general, all OSes get rather upset if disks disappear under 
them.  particularly if those disks contain swap -- exactly how is the 
machine meant to recover from that?

some recommendations:
  - run with the Matthew Jacob's "feral" driver rather than QLogic's driver
    it has much better error recovery
  - you may want to increase the delay of SCSI_TIMEOUT in drivers/scsi/scsi.h

in my lab here, i do a ton of work on Fibre Channel & iSCSI.
the best setup i've found is that i end up using ramfs as my root and 
having lots of things in there.  sure, its burns a bit of ram, but i can be 
sure if i'm doing anything that could impact the i/o path, its on less 
system-critical stuff.  since its a lab and the things running on the hosts 
aren't RAM hongs, i don't have swap either.  you probably can't get away 
with that, so i'd recommend doing some extensive testing pulling cables out 
and seeing what happens and tuning timers to cope with it accordingly.

>When making an online configuration change on the Symmetrix (such as
>remapping volumes), it is possible for the attached hosts to experience
>a temporary error while accessing a storage array volume. For example,

are you sure this tech note will still apply with the DMX?
i'd imagine that there are still bin file changes that can cause this kind 
of thing, but its something i believe EMC was addressing with the DMX.

>when changing the Symmetrix configuration, it is not uncommon for the
>RS/6000s (also attached to the SAN) to log one or two temporary
>SCSI-errors. They don't cause any problems at all, the AIX volume manager
>never notices a problem.

on RS/6000's, the rules were somewhat different.  the HBAs that IBM had for 
RS6Ks typically only tried to issue FLOGIs once every 30 seconds - so you 
would be more likely to see timeout errors if you impacted the flow of 
traffic temporarily.


cheers,

lincoln.

