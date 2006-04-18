Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWDRTPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWDRTPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 15:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWDRTPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 15:15:50 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:53004 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932298AbWDRTPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 15:15:49 -0400
Date: Tue, 18 Apr 2006 21:15:46 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [PATCH] i2c-i801: Fix resume when PEC is used
Message-Id: <20060418211546.fa5a76df.khali@linux-fr.org>
In-Reply-To: <20060418170331.GA3915@jupiter.solarsys.private>
References: <20060418140629.7cb21736.khali@linux-fr.org>
	<20060418170331.GA3915@jupiter.solarsys.private>
Reply-To: LM Sensors <lm-sensors@lm-sensors.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> * Jean Delvare <khali@linux-fr.org> [2006-04-18 14:06:29 +0200]:
> > Fix for bug #6395:
> > Fail to resume on Tecra M2 with ADM1032 and Intel 82801DBM
> > 
> > The BIOS of the Tecra M2 doesn't like it when it has to reboot or
> > resume after the i2c-i801 driver has left the SMBus in PEC mode. So we
> > need to add proper .suspend, .resume and .shutdown callbacks to that
> > driver, where we clear and restore the PEC mode bit appropriately.
> 
> NACK: saved_auxctl is uninitialized in this patch (what happened to
> the patch I looked at last night?)

Doh! You're right, and I am so glad you caught it. I tried to refactor
some code from the original patch and one line was lost in the battle :(

> Also, now that I look at it again... wouldn't it be much easier to just
> disable PEC again after every transfer?  That's safer too:  the call-
> backs might not be enough e.g. if the user hits the reset button after
> a PEC transfer.

This is exactly the patch I sent for -stable (as 2.6.16 is affected
too.) This is also what the i2c-i801 driver was doing up to 2.6.15,
inclusive.

However I thought using the proper driver model callbacks would be
better for 2.6.17, for the following reasons:
* Nothing currently prevents the user from suspending or rebooting the
system while there is a transaction in progress. If this happens, the
callbacks are needed to clear and restore the PEC bit; resetting at the
end of the transaction won't work.
* Small performance benefit, although I admit it's a last resort
consideration.

Also note that, even if we disable PEC after each transaction, the user
can still leave the system in a broken state by hitting the reset
button during a transaction. This is less likely to happen than if we
disable PEC in .suspend and .shutdown, but it can still happen. The
only way to fix that is to get the BIOS itself fixed, which is out of
our hands.

Anyway, on second thought I believe you're right, the most simple
approach will be fine for 2.6.17 too. There's little point in trying
to handle suspend/resume if we don't prevent it from happening in the
middle of a transaction. Fixing that is beyond the scope of 2.6.17.

I'll send a new patch soon.

-- 
Jean Delvare
