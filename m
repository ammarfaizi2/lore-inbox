Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWFFSNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWFFSNw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWFFSNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:13:52 -0400
Received: from rtr.ca ([64.26.128.89]:60387 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750729AbWFFSNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:13:51 -0400
Message-ID: <4485C5D8.5070907@rtr.ca>
Date: Tue, 06 Jun 2006 14:13:44 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb device problem
References: <44859A9B.6080202@gmail.com> <4485A299.7070007@rtr.ca> <4485A855.1020602@gmail.com> <4485C446.2040203@rtr.ca>
In-Reply-To: <4485C446.2040203@rtr.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jiri Slaby wrote:
>> Mark Lord napsal(a):
>>> Jiri Slaby wrote:
..
>>>> ---
>>>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>>>> end_request: I/O error, dev sdb, sector 1575
..
> The 0x1007000 is broken down as:
> 
> 07 == "host byte"   = DID_ERROR = "internal error"
> 10 == "driver byte" = SUGGEST_RETRY
..
>>> I have a patch to fix this behaviour (in sd.c), but it has not yet
>>> been decided whether to go upstream with it or not.
>>
>> Could you post me a copy, please?
> 
> Probably tomorrow.  I haven't ported it forward yet (from a much older 
> kernel).
> But I don't think it will help here now, as these errors
> don't really look like bad media -- gotta look inside the usb-storage 

Mmm.. okay, a quick glance at the USB storage code revealed one instance:

        /* Did we transfer less than the minimum amount required? */
        if (srb->result == SAM_STAT_GOOD &&
                        srb->request_bufflen - srb->resid < srb->underflow)
                srb->result = (DID_ERROR << 16) | (SUGGEST_RETRY << 24);

        return;

So I suppose this *could* be the driver thinking it had a bad sector,
but it really looks like it's guessing.  The code also appears to be
instrumented for some kind of USB tracing.. If you can figure out how
to turn that on, then the trace will probably tell us what is really
going on there. 

Look for a file called "usbmon.txt" in the Documentation/usb/ subdir
of your kernel source tree.  It describes how to do the tracing.

I'll also CC: you when I send out the SCSI error-recovery draft patch.

Cheers
