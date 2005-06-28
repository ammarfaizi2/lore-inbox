Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVF1SsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVF1SsF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVF1SsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:48:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39583 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S261181AbVF1Sr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:47:56 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <42C19B40.3080500@s5r6.in-berlin.de>
Date: Tue, 28 Jun 2005 20:47:28 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
CC: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Problems with Firewire and -mm kernels
References: <20050626040329.3849cf68.akpm@osdl.org> <42BE99C3.9080307@trex.wsi.edu.pl> <20050627025059.GC10920@ime.usp.br> <20050627164540.7ded07fc.akpm@osdl.org> <20050628010052.GA3947@ime.usp.br> <20050627202226.43ebd761.akpm@osdl.org> <42C0FF50.7080300@s5r6.in-berlin.de> <20050628081815.GA21412@ime.usp.br>
In-Reply-To: <20050628081815.GA21412@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: (-1.554) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito wrote:
> On Jun 28 2005, Stefan Richter wrote:
>>But again, I don't see how -mm and the stock kernel should differ to that
>>respect.
> 
> Well, I can only say that this problem is 100% reproducible with my
> enclosure.
> 
> Perhaps more data is needed here? The 2.6.12 kernel is able to see the
> drive without any problems while the -mm kernels aren't. I can provide
> anything that you guys want.

What we know is:
  - With -mm, your machine started to require the switching of phy IDs
    for a proper cycle master.
  - With -mm, the device formerly sensed by scsi_mod's probe as
    "Direct-Access" device + SCSI rev 06 is allegedly of "Unknown" type +
    SCSI rev 04 now. Vendor and model are still recognized though.

So what we don't know at the moment is:
  - What did change to make the formerly "unlikely to happen" FireWire
    bus reset "extremely likely to happen" now? (That is how I interpret
    the ratio of 0% to 100% which you observed.)
  - Does this reset infuence how the device answers to scsi inquiries?
    So far there were only reports on the linux1394 mailinglists
    indicating that with this reset, devices respond differently to
    config ROM queries from the ieee1394 driver. This is way before sbp2
    and scsi_mod get to know about the device.

My current uneducated guess is that the FireWire bus reset and the SCSI 
probing problem are actually unrelated. The cause for the latter problem 
might be 2.6.12-mm2/broken-out/git-scsi-block.patch. At least that is 
what I think after a look through the -mm2 patch collection.

>>You could load ieee1394 with a new parameter that supresses the "Root 
>>node is not cycle master capable..." routine:
>># modprobe ieee1394 disable_irm=1
>>before ohci1394 and the other 1394 related drivers are loaded.
> 
> Ok, I'll disable hotplug, udev etc and try to boot into single user mode
> for that as soon as I wake up (I'm going to bed right now---had a lot of
> work done for a day).

You do not need to go through all this. Unload all 1394 drivers 
(although this may fail sometimes when scsi does not let go of sbp2), 
then reload ieee1394 with the parameter, then ohci1394. No need to go 
into another runlevel or to mess around with hotplug or udev.

>>>ieee1394: Node changed: 0-01:1023 -> 0-00:1023
>>>ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00010e8]
>>
>>What caused these two messages? Did you disconnect the drive at this
>>point?
> 
> Yes, I did. In both cases, just to see if any messages issued to dmesg were
> different when unplugging the drive.

Then these two messages are OK.
-- 
Stefan Richter
-=====-=-=-= -==- ===--
http://arcgraph.de/sr/
