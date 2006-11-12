Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWKLSA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWKLSA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 13:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWKLSA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 13:00:26 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:48975 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750939AbWKLSA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 13:00:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=4vDmP4M+8cFr/2fzaT72gu+NICbHWFdAO1VcoaxEZ7o7ieP4VSEQjiFLKUXsgG675TwJ2Eh2nMIu5CVv9RZABKHv1fyoZGiPR87B+R8iKi2uKHxNA8v0rPiQj38kmt2wHngIlcHxdWNW8vA8QxfdcTyn2CMk84Vtc7uKsipZ7jY=  ;
X-YMail-OSG: gFRh.wwVM1mfZp7zkqmysB3tq.5bk6LPr5LEzxYtroo5oQQeNzhY53Yo6vkvoysFRW3mGfjsR2Y1mfojdPt36jGmXnMsFAKsBVEBB_dEMttfJofX6_VAjgX_CCoRlf9BTqsLMc6hV5TUfQAj0stBNNM353H.9AvZk7A-
Date: Sun, 12 Nov 2006 10:00:21 -0800
From: David Brownell <david-b@pacbell.net>
To: stern@rowland.harvard.edu, arvidjaar@mail.ru
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI 
 wakeup via sysfs
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0611121120110.6353-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0611121120110.6353-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061112180021.60DE11C6042@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > 	echo -n disabled >
> > > > /sys/devices/pci0000:00/0000:00:02.0/usb1/power/wakeup
> > >
> > > That's what I meant ... thanks, and sorry for the confusion.
> > 
> > this does not work anymore in current rc5. After writing 
> > cat /sys/devices/pci0000:00/0000:00:02.0/usb1/power/wakeup shows "disabled" 
> > but messages continue to be logged.
> > 
> > Anything I can do to help narrow it down?
>
> Undoubtedly this change in behavior is caused by the "autostop" code I 
> added to ohci-hcd.  It doesn't check the "wakeup" attribute.

That's the basic bug ... it needs to do that, like it does in a 2.6.18
kernel I happen to still have sitting around.


> Dave, is there any clue about exactly what triggers the immediate wakeup?  
> If you could tell me what to test for, I could try writing a patch to fix 
> it.  Perhaps the driver needs a "resume_detect_is_broken" quirk.

It's an implementation bug in some silicon, or in some case some boards.

That's why the original OHCI autosuspend code initialized the "can this
root hub autosuspend" by testing the root hub wakeup flag:

        can_suspend = device_may_wakeup(&hcd->self.root_hub->dev);

and then cleared it if any enabled port wasn't suspended, any schedule
was active, or any deletions were pending.  A quick glance at your new
"autostop" code shows that it only checks whether ports are enabled;
those other important constraints have been removed.

Knowing this is a regression probably explains why that one patch adding
the "broken suspend" board-specific quirk for the Tohsiba Portege 4000
didn't work:  the mechanism it relied on (root hub marked as "can't wakeup")
is broken.

I expect the AMD756 erratum 10 workaround is also broken, since that makes
a point of initializing the root hub so that device_may_wakeup() prevents
the autosuspend mechanism from kicking in.

- Dave

