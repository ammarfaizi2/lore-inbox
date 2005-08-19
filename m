Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVHSFkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVHSFkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 01:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbVHSFkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 01:40:14 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:36474 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932545AbVHSFkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 01:40:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=K22kwXfEgIBgX0z4Yi9zQKvTaM4yLLhJMHbsUseV5T5MBZpJOwloezC2uAB82R4+imPsq+LDyLEjbUyMgvFARAOguGJvtQyGhNTTzKne/V1S3UYPhfQM2xFZcbahMI0R1qQJulCyNsFce620YchH2Vg/MPfULaohxxWCpmN3CCc=
Message-ID: <430570B5.60109@gmail.com>
Date: Fri, 19 Aug 2005 14:40:05 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata error handling
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org> <430556BF.5070004@pobox.com>
In-Reply-To: <430556BF.5070004@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi, Jeff.

Jeff Garzik wrote:
> 
> Tejun,
> 
> In an email I cannot find anymore, you asked why I was interested in 
> converting libata to use the fine-grained EH hooks in the SCSI layer, 
> rather than continued with the current ->eh_strategy_handler() method.
> 
> Several reasons:
> 
> 1) The fine-grained hooks of the SCSI layer are somewhat standard for 
> block devices.  The events they signify -- timeout, abort cmd, dev 
> reset, bus reset, and host reset -- map precisely to the events that we 
> must deal with at the ATA level.

  I genearally agree that the events are somewhat standard for block 
devices but IMHO SCSI EH also has fair amount SCSI-specific assumptions 
and ATA is a bit too different from SCSI to fit cleanly into it.  For 
example, when handling NCQ errors, the whole task set is aborted and the 
status is retrieved with read log page.  This can be worked around in 
one of the hooks and emulate SCSI behavior, but it just doesn't really 
fit well.  And I think that recovering via translation layer is a bit 
too much translation.

  So, my thought is that SCSI EH assumptions are a bit too specific to 
be used as standard for block devices.

> But be warned of false sharing, as I talk about in #2...
> 
> 2) When libata SAT translation layer becomes optional, and libata drives 
> a "true" block device, use of ->eh_strategy_handler() will actually be 
> an obstacle due to false sharing of code paths.  ->eh_strategy_handler() 
> is indeed a single "do it all" EH entrypoint, but within that entrypoint 
> you must perform several SCSI-specific tasks.

  It's true that we must do SCSI specific tasks inside libata if we use 
eh_strategy_handler but I don't think switching to fine-grained EH will 
reduce the amount of SCSI-specific things inside libata.  I think as 
long as we can insulate LLDD's from SCSI layer, either way should be 
okay later.

> 
> 3) ->eh_strategy_handler() has continually proven to be a method of 
> error handling poorly supported by the SCSI layer.  There are many 
> assumption coded into the SCSI layer that this is -not- the path taken 
> by LLD EH code, and libata must constantly work around these assumptions.
> 
> 4) libata is the -only- user of ->eh_strategy_handler(), and oddballs 
> must be stomped out.  It creates a maintenance burden on the SCSI layer 
> that should be eliminated.

  I agree that being the only user does incur difficulties, but my very 
subjective feeling is that the original libata EH implementation was 
just a bit too fragile to start with.  eg. not grabbing host lock on EH 
entrance causing command completion vs. EH handling race and handling 
errors in several different ways.

  Heh... Maybe I'm just reluctant to let go of my patches.  Anyways, 
I'll now stand down and see how things go and try to help.

  Thanks, always.

-- 
tejun
