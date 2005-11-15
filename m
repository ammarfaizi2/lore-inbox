Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVKONnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVKONnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVKONnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:43:35 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:44183 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932500AbVKONne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:43:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=G0dSaA8Ay21jMG/s4nmE2QeTaeCs/4G3wDc16m0FQmMf8AWxFprYB33eNzyNZ7jqVANdBV91D2W5iEhc9/B5o9ZDw+oEAibm+5WMlqrBygrkaKCG5q1CcoSXxwB0AkqK2RAR8JIAOtBKBMeTfIgTwveTiSSYOxTvMXJrY1kwgpA=
Message-ID: <4379E5F7.6000107@gmail.com>
Date: Tue, 15 Nov 2005 22:43:19 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com>
In-Reply-To: <4379AA5B.1060900@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> TUR fails for me, too.  It triggers the EH code, which is why I wound up 
> needing to fix it :)
> 
> Have you dumped the D2H FIS returned by the drive, when the TUR fails? 
> What does it look like?  What does the D2H FIS look like after REQUEST 
> SENSE?
> 
> I bet there is some "clear error" actions we need to take on sil24, 
> before it work there.
> 

Okay, I finally got my SATA dvd writer working and successfully mounted 
a debian cdrom (with some number of gloss hacks).  I had to do the 
following to get this thing to work.

* prb->fis doesn't contain proper signature after phy reset.  I just 
forced DEV_ATAPI as a temporary measure.  In the original sii driver 
where SRST is used instead of PHY RESET, my ATAPI drive registered 
correct signature but my harddisk's signature didn't show up.

* As all commands hang after failed TUR, which BTW fails rightfully with 
06h (UNIT ATTENTION due to prior reset) and then 02h's (NOT READY), I 
avoided TUR failures by issuing REQUEST SENSE first, which returns NO 
SENSE but does clear UA condition, and then waiting for more than 10secs 
to give the drive time to become ready.

* With above two changes, no command fails and I can mount the cdrom.

------------------

And here are things that I've found out so far....

* ATAPI commands without data (TEST_UNIT_READY, ALLOW_MEDIUM_REMOVAL...) 
work happily with any prb->ctrl flag (no flag, PRB_CTRL_PACKET_READ or 
PRB_CTRL_PACKET_WRITE).

* Currently, sil24_reset_controller() is called on every error interrupt 
to make sure the controller is ready for further operation. 
Unfortunately, the current reset_controller() seems to reset PHY too. 
The drive becomes NOT READY after reset_controller().  So, when TUR 
fails, it falls into TUR, fail with NOT READY, reset which makes the 
drive NOT READY again cycle.

* Wihtout sil24_reset_controller(), no further command can be issued. 
The controller doesn't seem to be operating normally after DEV_ERR.

--------------------

So, what we need to know to make sil24 work happily with ATAPI devices.

* How to get device signature on initialization.

* How to make the controller operational again after a DEV_ERR without 
affecting the attached device.

-- 
tejun
