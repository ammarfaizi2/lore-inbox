Return-Path: <linux-kernel-owner+w=401wt.eu-S1422685AbWLUIL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWLUIL3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422832AbWLUIL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:11:29 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:33680 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422812AbWLUIL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:11:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=xl9R830pXf+mvaOc+LQOoGMHgmKL7uTV5paBhFZoUqyhIZ/f2VdSkF8XdOWtD+aotSAVkSjuIW4b1E5mENtROmTK0XMWqB4lOE1/5K7TwOB80hBWmb9xaterW7tICcxHIiXEWYQECyrNNpB2KoVNXacJyH6Lfe5mvT/y+FGwFjM=  ;
X-YMail-OSG: 0YGuwKMVM1noZK9LxS2Q61YJSrDtzZT6gupBgTxnQQqobGV47d2j2mz1IipeV8w18rwS55XNza0L1dGqac4dlVx5SgmDA3mIH6HL7bgaFTTTubCHd1MSBLvAdmU_ObNu7IJqAJB09Qnfr2ZOVQsJZH1TZo5HfPGNdWM1E12Dn7o7F1vtxjewq9WloY0e
From: David Brownell <david-b@pacbell.net>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Network drivers that don't suspend on interface down
Date: Thu, 21 Dec 2006 00:11:24 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Matthew Garrett <mjg59@srcf.ucam.org>
References: <200612202125.10865.david-b@pacbell.net> <458A32FF.1010700@osdl.org>
In-Reply-To: <458A32FF.1010700@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612210011.25229.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 December 2006 11:08 pm, Stephen Hemminger wrote:
> David Brownell wrote:
> > Hmm, this reminds me of a thread from last summer, following up on
> > some PM discussions at OLS.  Thread "Runtime power management for
> > network interfaces", at the end of July.
> >
> >
> >   
> >> 2) Network device infrastructure should make it easier for devices:
> >>     bring interface down on suspend and bring it up after resume
> >>     (if it was running when suspended). This would allow many devices to
> >>     have no suspend/resume hook; except those that have some better power
> >>     control over hardware.
> >>     
> >
> > The _intent_ of the class suspend() and resume() methods is to let
> > infrastructure (the network stack was explicitly mentioned!) handle
> > pretty much everything except putting the hardware in low power
> > modes ... which last step might, for PCI devices at least, most
> > naturally be done in suspend_late().  That way it'd be decoupled
> > cleanly from anything else.
> >   
> The class methods don't work right for that because the physical class 
> (PCI) gets called before the virtual class  (network devices).

I'd say they don't work just now because the virtual class code just
doesn't get called ... at least, without someone setting up a field
(device.class) that's flagged as "optional" and might be disappearing.

But if you read the PM code, you'll observe that the class suspend
method gets called BEFORE the bus/device suspend method.  And that's
how it's documented in Documentation/power/devices.txt too.


... However notice that "interface down" operations won't have that
particular problem, they have net_device.class_dev.dev already ready
for whatever PM operation is appropriate.

- Dave


> > Now, I recently tried refreshing a patch that used those class
> > suspend() and resume() methods, and for some reason they're not
> > getting called.  I believe they used to get called, although it's
> > true their parameter wasn't very useful ... it was called with the
> > underlying device, not the class_device holding state that the
> > class driver manages.
> >
> > I just wanted to point out that yes, this ground has been covered
> > before, with some agreement on that approach.  It'd be good to see
> > it pursued.  :)
> >
> > - Dave
> >
> >   
> 
