Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTLLCRs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 21:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTLLCRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 21:17:48 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:7657 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264455AbTLLCRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 21:17:47 -0500
Message-ID: <3FD92632.50200@pacbell.net>
Date: Thu, 11 Dec 2003 18:21:38 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: Alan Stern <stern@rowland.harvard.edu>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <Pine.LNX.4.44L0.0312081127080.1043-100000@ida.rowland.org> <200312081859.03773.baldrick@free.fr>
In-Reply-To: <200312081859.03773.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PS: Here is the patch that fixed the original usbfs Oops, but gained the new
> one Vince reported:

Good -- more locks vanishing from usbcore; it's about time!
This is a case where fewer locks are better.

My main patch feedback here would be that it should merge
most of the usbfs patch I sent (second URL below).  There's
a driver model locking requirement that you didn't know about,
it needs to bubble up (subsys.rwsem writelock must be held if
you're going to change driver bindings).  And there were a
few other rough spots, which I think you've mentioned (and
I don't think they were new issues).

The more I think about it, the more I like your idea of
changing device->serialize to be an rwsem.  Changing config,
or resetting the device, would get the writelock.  All other
uses should share, with readlocks -- that's the right model.

Likely not before 2.6.1 though ... ;)

- Dave

[1] http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107100212612153&w=2
[2] http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107102580404037&w=2


