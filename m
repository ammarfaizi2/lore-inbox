Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTIOPg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTIOPg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:36:58 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:35264 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261464AbTIOPgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:36:55 -0400
Message-ID: <3F65DDC5.9090608@pacbell.net>
Date: Mon, 15 Sep 2003 08:41:57 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: "M.S. Lucas" <mslucas@taos-it.nl>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       apcupsd-devel@apcupsd.com
Subject: Re: [linux-usb-devel] [USB] control queue full when using 2.6.0-test5
 and apcupsd
References: <006e01c37b98$6580a140$0301a8c0@bpo.nl>
In-Reply-To: <006e01c37b98$6580a140$0301a8c0@bpo.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M.S. Lucas wrote:
> Hello,
> 
> I'm having problems with my APC UPS using an USB cable and the 2.6.0-test5
> kernel
> 
> I hope somebody can help me?
> 
> ...

So it looks like it enumerated OK, but then the HID code misbehaved.


> root@orion:/etc/apcupsd $ /etc/init.d/apcupsd-devel start
> Starting APC UPS power management: apcupsd-devel.
> This is in my logfiles
> Sep 15 16:00:06 orion apcupsd[21908]: apcupsd 3.10.6 (05 August 2003) debian
> startup succeeded
> Sep 15 16:00:07 orion kernel: drivers/usb/input/hid-core.c: control queue
> full
> Sep 15 16:00:38 orion last message repeated 148089 times
> Sep 15 16:00:53 orion last message repeated 84977 times
> Sep 15 16:00:53 orion kernel: drivers/usb/input/hid-core.c: control queue
> full
> Sep 15 16:00:53 orion last message repeated 3163 times
> ...etc

Actually the HID code isn't doing control queueing very intelligently.

As of 2.6, it no longer needs to avoid passing multiple control requests
to the same device ... the HCDs now queue them like any other kind of
transfer(*).  So the "good" fix there would be to the HID code, getting
rid of a fixed size queue.  Or, you could make a "dirty" fix and just
increase the queue size again ... it's already huge (so that it'll
handle some MGE UPSes), make it even more so.

- Dave

(*) However there's still a patch pending to fix a bug in the UHCI driver,
     where it inappropriately patches up data toggles in control transfers
     in certain cases with queue length greater than one URB.  You're using
     OHCI (or EHCI), and should have no problem with 2.6.0-test5 kernels.




