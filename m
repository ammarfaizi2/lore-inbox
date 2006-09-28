Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031325AbWI1Bsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031325AbWI1Bsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031324AbWI1Bsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:48:47 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:2003 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965181AbWI1Bsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:48:45 -0400
Message-ID: <451B29FA.7020502@garzik.org>
Date: Wed, 27 Sep 2006 21:48:42 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Illustration of warning explosion silliness
References: <20060928005830.GA25694@havoc.gtf.org> <20060927183507.5ef244f3.akpm@osdl.org>
In-Reply-To: <20060927183507.5ef244f3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 27 Sep 2006 20:58:30 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> The following patch (DO NOT APPLY) illustrates why
>> device_for_each_child() should not be marked with __must_check.
>>
>> The function returns the return value of the actor function, and ceases
>> iteration upon error.
>>
>> However, _every_ case in drivers/scsi has a hardcoded return value,
>> illustrating how it is quite valid to not check the return value of this
>> function.
>>
> 
> What does "has a hardcoded return value" mean?

Reference the sentence before that.  The return value of the actor 
passed to device_for_each_child() is always either zero (for some 
actors) or one (for another actor).  In all cases, it is never variable.


> AFICT the problem here is that (for example) (going up the call stack in
> the callee->caller direction):
> 
> scsi_internal_device_block() returns an error code
> 
> but device_block() drops that on the floor
> 
> so target_block() drops it on the floor too
> 
> so scsi_target_block() drops it on the floor too
> 
> 
> It's a small matter of (correct kernel) programming to correctly propagate
> the scsi_internal_device_block() error code all the way back out of
> scsi_target_block().
> 
> It all looks rather sloppy?

Quite sloppy.  But that doesn't change the fact that 
device_for_each_child()'s actor _may_ hardcode the return value.  It's a 
valid usage model for that function.

If you are doing a simple collection of data -- adding items to a 
preallocating list or bitmap -- or doing a search, as with 
__remove_child() in drivers/scsi/scsi_sysfs.c, the return value can be 
quite useless.

The usage model should not be _forced_ upon the caller, since it might 
not be needed.

	Jeff


