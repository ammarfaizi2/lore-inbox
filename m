Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWERCeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWERCeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 22:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWERCeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 22:34:07 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:16569 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751213AbWERCeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 22:34:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ikowvbkXGYEpkQMl3OXuAsXxrMMpnCbyEACeR1DavfofUXxnPOG7UdN4+hS+rcQs7NL9wyLRKZZV3PaeCXeGz4CCHaAf6E2NgYyBdadOFG14REwPRDvvLDTEaVw+rHRmhTxqOLdvhpHSuazptKa5Slbc4Y3WpD59h8IenABjbxc=
Message-ID: <446BD8F2.10509@gmail.com>
Date: Thu, 18 May 2006 11:16:18 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jan Wagner <jwagner@kurp.hut.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: support for sata7 Streaming Feature Set?
References: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi> <4466D6FB.1040603@gmail.com> <Pine.LNX.4.58.0605162126520.31191@kurp.hut.fi>
In-Reply-To: <Pine.LNX.4.58.0605162126520.31191@kurp.hut.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Wagner wrote:
> Hi and thanks for your response,
> 
> On Sun, 14 May 2006, Tejun Heo wrote:
>>> anyone know if the now already somewhat old Streaming Feature Set of
>>> ATA/ATAPI 7 is going to be implemented in the kernel ata functions?
>>>
>>> According to one web site that contains hdreg.h
>>> http://www.koders.com/c/fidCD7293464D782E48F93EEF8A71192F1BF28FC205.aspx
>>> there's at least some kind of mention in that include file about streaming
>>> feature set, kernel 2.6.10. However in 2.6.16 it seems to be gone again.
>>> Any ideas if this will be implemented, or how to use it with e.g. hdparm
>>> right now?
>> I don't think streaming feature set is something to be supported at
>> kernel driver level.  The usage model doesn't fit with block interface.
> 
> I'm definitely not a kernel guru or into its internals, but IMHO ATA/ATAPI
> specifications should all also be supported in the kernel or kernel
> module, for compliance, or?

No, not really.  If things can be done outside of kernel, we like to 
keep them there.  e.g.  SMART is implemented in the userland and it fits 
there.  Kernel only has to provide mechanisms to enable such implementation.

> The block device's ioctl could have a "data reliability setting"
> extension, specifying either the error recovery time limits or for
> enabling continuous read/write control (used to return/use partially
> correct data) which are part of the ATA Streaming Feature Set.
> 
> I.e. an adjustable minimum acceptable data reliability level for block
> devices, which can e.g. be relaxed down from a default 100%.

Streaming / relaxed reliablity is a very specialized feature requiring 
very specialized software to drive it.  I can't think of much use in the 
generic vm/fs/block framework.  So, I don't see it happening in the kernel.

>>   If you want to use it, the best way would be issuing commands directly
>> using sg.
> 
> Maybe yes, that, or hdparm, but it seems like a horrible hack :) And sg
> being for generic SCSI, I'm not sure how well ATA-7 fits in. At least,
> the current debian sg-tools, and commands like 'sg_opcodes /dev/sda'
> return "Fixed format, current;  Sense key: Illegal Request", "Additional
> sense: Invalid command operation code" for those SATA disks I tried.
> Doesn't look good for sg useability, AFAICT.

No, it's not a horrible hack.  Again, no one thinks smartd is a horrible 
hack.  Even core things like irqbalancing and CPU speeding down are 
controlled from userland.  Being in the userland is a good thing - it's 
much safer & more convenient/flexible out there.

>> What are you gonna use it for?
> 
> To record or play back real-time continuous streamed data that is not
> error-critical but delay critical, from/to a bidirectional data
> aquisition card at ~1Gbit/s over longer time spans.

One thing to think about before supporting streaming from/to harddisks 
from userland is how to make data flow efficiently from userland to 
kernel and back.  But, no matter what, kernel <-> userland usually 
involves one data copy, so I don't think making sg similarly efficient 
would be too difficult (it might be already).

> Direct kernel device support for the feature set could also be very useful
> for linux projects like the Digital Video Recorder and Video Disk
> Recorder. And seek/stutter free video playback from DVD/ATAPI (scratched
> disks, for example) or video editing. Etc.

Why direct kernel device support necessary for such things?  What kind 
of interface are you proposing?  I can't think of anything better than 
libatastreaming (or whatever, just focus on the leading 'lib'), which 
uses sg to issue commands and manage everything.

-- 
tejun
