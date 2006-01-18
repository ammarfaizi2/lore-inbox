Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWARLx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWARLx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWARLx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:53:57 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:1664 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030242AbWARLx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:53:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=OXEQUcH7tJMauMS6pJz/D3sm8sCgxf0NkmO/t6FVMf2dSz7iFY9Z2YDDuBO3zd/pJV7A5btdiJCLHQffOqHm0fYHpcmly3RG/wEeBFuTrmrOQrrItvnFYEih6umeHKZ2HLH6kZjbesJRl8zp8yYKxYbu2IELz0G4zXoeLljs9bY=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
Date: Wed, 18 Jan 2006 12:53:54 +0100
User-Agent: KMail/1.8.3
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <20060118011200.GA28086@kroah.com>
In-Reply-To: <20060118011200.GA28086@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181253.54942.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 02:12, Greg KH wrote:
> > From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso
> > <blaisorblade@yahoo.it>
> >
> > Define a release method for the ubd and network driver so that sysfs
> > doesn't complain when one is removed via:

> What?  No.  The kernel is complaining for a reason, don't try to
> out-smart it.

I'm not trying to ignore the warning.

> > host $ uml_mconsole <umid> remove <dev>

> > Done by Jeff around January for ubd only, later lost, then restored in
> > his tree - however I'm merging it now since there's no reason to leave
> > this here.

> > We don't need to do any cleanup in the new added method, because when
> > hot-unplug is done by uml_mconsole we already handle cleanup in mconsole
> > infrastructure, i.e.  mc_device->remove (net_remove/ubd_remove), which is
> > also the calling method.

> Huh?  You have 2 different release functions for the same object?

Not sure which ones you refer. net_remove and ubd_remove are for different 
devices; mc_device->remove and the sysfs release are in different layers and 
for different things.

> And 
> how do you know which one is correct?  That does not sound right at all.

No, but since we don't have plugs, we get configuration requests to remove 
devices.

And currently, since this existed in already 2.4, the handler of the 
configuration request(mc_device->remove) does all the work to shutdown the 
interface, and then calls into the kobject stuff (with 
platform_device_unregister()); and this complains for the missing ->remove.

If it's better, we may try to move things inside the sysfs ->remove event, 
with care because different stuff has been done.

However, there are a lot of things to look at here... is there anything in 
ubd_remove() smelling awful? Because we have a crash which is caused by us 
harming sysfs data structures, which triggers on ubd_remove().

Bug report:
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=113537479514679&w=2

investigations:
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=113538805406552&w=2

> Please fix this correctly.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
