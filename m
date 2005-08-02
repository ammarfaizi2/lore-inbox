Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVHBMeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVHBMeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVHBMeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:34:13 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:33680 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S261486AbVHBMc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:32:28 -0400
Date: Tue, 2 Aug 2005 14:31:55 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
cc: Christoph Hellwig <hch@infradead.org>, Mark Haverkamp <markh@osdl.org>,
       Christoph Hellwig <hch@lst.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Latest Adaptec AACRAID driver doesn't compile on latest kernel
In-Reply-To: <60807403EABEB443939A5A7AA8A7458B01792C1A@otce2k01.adaptec.com>
Message-ID: <Pine.LNX.4.60.0508021359050.5060@kepler.fjfi.cvut.cz>
References: <60807403EABEB443939A5A7AA8A7458B01792C1A@otce2k01.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> -----Original Message-----
>> From: Martin Drab [mailto:drab@kepler.fjfi.cvut.cz]
>> Sent: Monday, August 01, 2005 6:31 PM
>> To: Salyzyn, Mark
>> Subject: Latest Adaptec AACRAID driver doesn't compile on latest kernel
>> 
>> Hi, Mark,
>> 
>> because of the following kernel patch issued in 2.6.13-rc4:
>> 
>> -------------
>> commit 8d115f845a0bd59cd263e791f739964f42b7b0e8
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Sun Jun 19 13:42:05 2005 +0200
>> 
>>     [SCSI] remove scsi_cmnd->state
>> 
>>     We never look at it except for the old megaraid driver that abuses it
>>     for sending internal commands.  That usage can be fixed easily because
>>     those internal commands are single-threaded by a mutex and we can easily
>>     use a completion there.
>> 
>>     Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
>> 
>> -------------
>> 
>> the Adaptec AACRAID driver 1.1.5-2405 that you sent me is unable to
>> compile. Attached patch fixes the problem by simply removing the
>> condition where it is used. It seems to be just some kind of debug info
>> guard. And since there doesn't seem to be any other way to obtain the
>> state we would just have to suffice with this, or remove the debug info
>> printing entirely.
>> 
>> Martin

On Tue, 2 Aug 2005, Salyzyn, Mark wrote:

> Thanks MArtin, I have this change in 1.1.5-2408 wrapped with an ifdef
> for kernels 2.6.13 and higher to permit compile and pending an
> investigation to determine a suitable substitute in the 2.6.13+ tree.

Is it downloadable somewhere? If not, could you please send it to me?
 
> The check is done because when commands are completed, they still reside
> on the device queue and this filters out those that are on the road to
> completion. I am not sure this is still the case in 2.6.13. It is not a
> debug check; it is a means to determine that all the commands have
> quiesced to the adapter. We do this because several conditions that
> cause the tripping of the SCSI bus timeout with this adapter are a
> result of the adapter performing some RAID recovery, flush or build
> tasks and stuffing the adapter with commands during these operations
> only serves to exasperate the situation and cause devices to go offline.
> I have referred to this condition as Adapter reticence.
> 
> The side effect of this change may be that the reset handler will wait
> the full 60 seconds for commands to complete in the adapter rather than
> exiting as soon as they have all completed. This will still serve the
> purpose to alleviate this situation. However, as this code is extending
> the 60 second SCSI timeout, we get nervous that this change will result
> in increased number of servers dropping their network connections.

Hmm. I see. So perhaps you may ask someone (James, Christoph, ...?) to 
revert that patch, because the scsi_cmnd->state is needed here for this 
purpose. It was removed just because nobody else was using it (at least 
thats what the patch description says). So, if you explain that it is 
necessary for this purpose, it could either be reverted, or you may be 
told of a way to get around it. (That's a result of that the driver didn't 
yet make it into the mainline. Before it does, mainline may change to a 
level that it would no longer be possible to apply it. :()

Martin
