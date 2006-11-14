Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966363AbWKNVSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966363AbWKNVSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966361AbWKNVSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:18:17 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:37982 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966363AbWKNVSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:18:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=E4bOHeDBc7UQLKHTqp1Qho9NcOFNduaZBJcrGG1v0tZTh5Rbqb0/TzNbnca1oqed5ULae+jz94JuqG128FuCFo4tNmeEatGUEwGPSPoL2uQAUKuTR0Dr9fcdEkCBoP4KlXFm6+o6ewazAs/402FzUf2PoUNC4iSjVh2anZlrT1M=  ;
X-YMail-OSG: 2_paQrsVM1mG0yQpJ26AQ6msr1HcOlx7v05hHULqD85AFRkCR2NE5FjF09PuWzPthHnKJOlYXcB2twD_GOnftC1qRymBWSE7v36ySJ4AtAKX6HgNICYR2fAlqyS5Ad7f75qn5VFz56vqVRLatL90H9.Bx9HKRg98IBY-
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI wakeup via sysfs
Date: Tue, 14 Nov 2006 13:18:10 -0800
User-Agent: KMail/1.7.1
Cc: arvidjaar@mail.ru, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0611131202290.2390-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0611131202290.2390-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141318.11080.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 9:15 am, Alan Stern wrote:
> On Mon, 13 Nov 2006, David Brownell wrote:
> 
> > It's a *driver model* API, which is also accessible from sysfs ... to support
> > per-device policies, for example the (a) workaround.  The mechanism exists
> > even on kernels that don't include sysfs ... although on such systems, there
> > is no way for users to do things like say "ignore the fact that this mouse
> > claims to issue wakeup events, its descriptors lie".
> 
> Yes, it is separate from sysfs -- but it is _tied_ to the sysfs API.

I can't agree.  If you deconfigure sysfs, it still works.
Since it's independent like that, there's no way it's "tied".


> > > and therefore administrative  
> > > in nature, but now you say it's also being used to record hardware quirks.
> > 
> > No; I'm saying the driver model is used to record that the hardware mechanism
> > isn't available.   The fact that it's because of an implementation artifact
> > (bad silicon, or board layout, etc) versus a design artifact (silicon designed
> > without that feature) is immaterial ... in either case, the system can't use
> > the mechanism.
> 
> But the information is being recorded in the wrong spot.  The correct test
> should use device_can_wakeup, not device_may_wakeup.  The can_wakeup flag
> is the one which records whether or not the hardware mechanism is actually
> available.

Go look again.  "may" implies (i) can , and (ii) should.  So if there's a
hardware quirk registered, (i) always fails.  And in the not-uncommon case
where the device misbehavior isn't known to the kernel, userspace has the
option of making (ii) kick in (the workaround mentioned above).  This is a
generic approach, it works on all wakeup-capable devices.

So "may" is correct, and "can" is insufficient.



> Okay.  I'll write a patch to eliminate autostop and those routines when
> CONFIG_PM is off.
> 
> But that doesn't answer the question above: Should autostop check 
> device_can_wakeup rather than device_may_wakeup?

See above, and the definition of may_wakeup().


> Also: Does the quirk/bug detection logic clear can_wakeup, as it should?  
> Or does it only affect may_wakeup?

See above.  Quirks directly recognized by the kernel clear can_wakeup.
Ones that are reported via userspace clear should_wakeup.  Either suffices
to ensure that the may_wakeup() predicate fails.

- Dave
