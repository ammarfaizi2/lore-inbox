Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTDPPUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTDPPUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:20:35 -0400
Received: from [203.117.131.12] ([203.117.131.12]:22717 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S264542AbTDPPUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:20:33 -0400
Message-ID: <3E9D7785.5020205@metaparadigm.com>
Date: Wed, 16 Apr 2003 23:32:21 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
Cc: Jurjen Oskam <jurjen@quadpro.stupendous.org>, linux-kernel@vger.kernel.org
Subject: Re: Booting from Qlogic qla2300 fibre channel card
References: <5.1.0.14.2.20030416162813.03b1b6e8@mira-sjcm-3.cisco.com>
In-Reply-To: <5.1.0.14.2.20030416162813.03b1b6e8@mira-sjcm-3.cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/16/03 14:56, Lincoln Dale wrote:
> Hi,
> 
> At 08:18 AM 16/04/2003 +0200, Jurjen Oskam wrote:
> 
>> At work, we are looking to deploy several Linux boxes on our SAN. The
>> machines will be IBM eServer xSeries 345 with Qlogic qla2340 Fibre 
>> Channel
>> cards, and no internal disks.
>>
>> The storage array is an EMC Symmetrix model 8530. EMC created a document
>> where they explain how to make such a configuration work. When they 
>> mention
>> booting from a Symmetrix-provided volume, they mention the following:
>>
>> "If Linux loses connectivity long enough, the disks disappear from the
>> system. [...] For [this reason], EMC recommends that you do not boot a
>> Linux host from the EMC storage array."
> 
> 
> in general, all OSes get rather upset if disks disappear under them.  
> particularly if those disks contain swap -- exactly how is the machine 
> meant to recover from that?
> 
> some recommendations:
>  - run with the Matthew Jacob's "feral" driver rather than QLogic's driver
>    it has much better error recovery

Although this is certainly a matter of opinion. When i tried the feral
driver a month ago - upon unplugging the fibre (and getting loop down)
the SCSI layer started spewing IO errors and the files copied during
this test (on ext3) had invalid checksums. The qlogic driver however
handled this test fine (handling multiple fibre unplugs while copying a
multi gigabyte file). Certainly the qlogic driver has its fair share of
recovery problems such as an abort function that tries to re-init the
hardware but always fails.

I'm currently looking for alternatives to qlogic HBAs after a year of
not being able to find a stable driver combo (one that can stand up
for more than a few weeks). Does any one out there have experience
with the LSI HBAs and Fusion MPT drivers or perhaps Emulex?

We get the following with latest 6.1 qlogic driver and our 2300s about
every 2 weeks (we are about to file a bug report to qlogic).

Apr  2 10:54:13 prodapp3 kernel: qla2x00: Status Entry invalid handle.
Apr  2 10:54:13 prodapp3 kernel: qla2x00: Performing ISP error recovery - ha= c3afc07c.
Apr  2 10:54:13 prodapp3 kernel: qla2x00_abort_isp(2): **** FAILED ****
Apr  2 10:54:13 prodapp3 kernel: qla2x00: Performing ISP error recovery - ha= c3afc07c.
Apr  2 10:54:13 prodapp3 kernel: qla2x00_abort_isp(2): **** FAILED ****
Apr  2 10:54:13 prodapp3 kernel: qla2x00: Performing ISP error recovery - ha= c3afc07c.
Apr  2 10:54:13 prodapp3 kernel: qla2x00_abort_isp(2): **** FAILED ****
Apr  2 10:54:14 prodapp3 kernel: qla2x00: Performing ISP error recovery - ha= c3afc07c.
Apr  2 10:54:14 prodapp3 kernel: qla2x00_abort_isp(2): **** FAILED ****
Apr  2 10:54:15 prodapp3 kernel: qla2x00: Performing ISP error recovery - ha= c3afc07c.
Apr  2 10:54:15 prodapp3 kernel: qla2x00_abort_isp(2): **** FAILED ****
Apr  2 10:54:16 prodapp3 kernel: qla2x00: Performing ISP error recovery - ha= c3afc07c.
Apr  2 10:54:16 prodapp3 kernel: qla2x00_abort_isp(2): **** FAILED ****
Apr  2 10:54:17 prodapp3 kernel: qla2x00: Performing ISP error recovery - ha= c3afc07c.
Apr  2 10:54:17 prodapp3 kernel: qla2x00(2): ISP error recovery failed - board disabled

>  - you may want to increase the delay of SCSI_TIMEOUT in 
> drivers/scsi/scsi.h
> 
> in my lab here, i do a ton of work on Fibre Channel & iSCSI.
> the best setup i've found is that i end up using ramfs as my root and 
> having lots of things in there.  sure, its burns a bit of ram, but i can 
> be sure if i'm doing anything that could impact the i/o path, its on 
> less system-critical stuff.  since its a lab and the things running on 
> the hosts aren't RAM hongs, i don't have swap either.  you probably 
> can't get away with that, so i'd recommend doing some extensive testing 
> pulling cables out and seeing what happens and tuning timers to cope 
> with it accordingly.
> 
>> When making an online configuration change on the Symmetrix (such as
>> remapping volumes), it is possible for the attached hosts to experience
>> a temporary error while accessing a storage array volume. For example,
> 
> 
> are you sure this tech note will still apply with the DMX?
> i'd imagine that there are still bin file changes that can cause this 
> kind of thing, but its something i believe EMC was addressing with the DMX.
> 
>> when changing the Symmetrix configuration, it is not uncommon for the
>> RS/6000s (also attached to the SAN) to log one or two temporary
>> SCSI-errors. They don't cause any problems at all, the AIX volume manager
>> never notices a problem.
> 
> 
> on RS/6000's, the rules were somewhat different.  the HBAs that IBM had 
> for RS6Ks typically only tried to issue FLOGIs once every 30 seconds - 
> so you would be more likely to see timeout errors if you impacted the 
> flow of traffic temporarily.
> 
> 
> cheers,
> 
> lincoln.
> 

