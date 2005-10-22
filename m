Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVJVKp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVJVKp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 06:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVJVKp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 06:45:26 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:29398 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932216AbVJVKpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 06:45:25 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <435A1793.1050805@s5r6.in-berlin.de>
Date: Sat, 22 Oct 2005 12:42:27 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Luben Tuikov <luben_tuikov@adaptec.com>,
       andrew.patterson@hp.com, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com> <43593884.7000800@adaptec.com> <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com> <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com> <43596F16.7000606@pobox.com>
In-Reply-To: <43596F16.7000606@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.65) AWL,BAYES_50,EXCUSE_3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Luben Tuikov wrote:
>>>> The host template _mixes_ hw, scsi core, and protocol knowlege into
>>>> one ugly blob.
>>>
>>> True.
>>>
>>> If you do not like the current situation, evolve the SCSI core (and 
>>> all drivers) to where you think they should be.
>>
>> While the architecture in my mind is clear, I cannot do this myself
>> (and for all drivers).  Such a change would be gradual, involving more
>> than one developer, for more than one (new) driver, etc.
> 
> Correct.  That's why there is resistance to aic94xx's approach of 
> creating a totally new "strict SAM" path, existing in parallel with the 
> traditional SCSI core.  You need to evolve the existing code to get 
> there.  Such changes are gradual, involving more than one developer, etc.
> 
> We don't need one small set of SCSI drivers behaving differently from 
> the vast majority of existing SCSI drivers.
> 
> Hear me now, and believe me later:  we all largely agree on the points 
> you've raised about legacy crapola in the SCSI core.  James, Christoph, 
> myself, and several others disagree with your assertion that the old 
> SCSI core should exist in parallel with your new SCSI core.
> 
> We differ on the path, not the goal.  As a thought experiment, you could 
> try simply implementing the changes requested, and see where that goes.

I am not familiar with most parts of the SCSI subsystem. However from 
what I understood, some existing concepts in the core need to be removed 
from SCSI core entirely, others need to be cleaned up WRT what they mean 
and how they represent it. It seems to me that a practical path to go 
would be:

A. Post mock-ups and pseudo code about how to change the core, discuss.
B. Set up a scsi-cleanup tree. In this tree,
      1. renovate the core (thereby break all command set drivers and
         all transport subsystems),
      2. update ~2 command set drivers and ~2 transport subsystems
      3. validate the renovated core,
      4. fix the conceptual errors of the renovated core (as well as
         first few discovered bugs in the implementation),
      5. update all other command set drivers,
      6. update all transport subsystems where resources to do so are
         available,
      7. test all command set drivers as far as hardware is accessible,
      8. test the updated transport subsystems as far as hardware is
         accessible,
      9. fix prominent bugs.
C. In mainline,
      i. mark all drivers which cannot be updated in the mid term as
         scheduled for temporary feature removal (i.e. they will be
         broken for an undetermined period),
     ii. mark all drivers which have been updated in scsi-cleanup tree,
         but were not thoroughly tested, as scheduled for temporary
         feature regression (i.e. they will be experimental for an
         undetermined period).
D. Push scsi-cleanup tree to -mm and shake out bugs.
E. Push to mainline.
F. Fix remaining drivers as time goes by, remove drivers which remain
    broken for too long.

Most steps may overlap, some steps may repeat. Step A is fortunately 
already going on for quite some time.

Step 1.-4. could involve much dispute, thus taking much more time than 
technically necessary -or- (and that would be less fortunate) being 
dragged out into later stages when a conceptually stabilized core is 
desirable. Much of that may be prevented in step A.

I doubt that the desired cleanup of the SCSI core could be done 
on-the-go, i.e. without temporary breakage of larger parts of the 
subsystem (out of mainline). But then again, I don't know much of the 
subsystem, so what am I talking about here?

Also, long-term breakage of smaller parts of the SCSI subsystem in 
mainline is to be expected; breakage which is to be announced and scheduled.
-- 
Stefan Richter
-=====-=-=-= =-=- =-==-
http://arcgraph.de/sr/
