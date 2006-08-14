Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932740AbWHNWuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbWHNWuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWHNWuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 18:50:04 -0400
Received: from mail1.cenara.com ([193.111.152.3]:25994 "EHLO
	kingpin.cenara.com") by vger.kernel.org with ESMTP id S932740AbWHNWuB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 18:50:01 -0400
From: Magnus =?iso-8859-1?q?Vigerl=F6f?= <wigge@bigfoot.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       "Dmitry Torokhov" <dtor@insightbb.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Vojtech Pavlik" <vojtech@suse.cz>,
       "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Re: input: evdev.c EVIOCGRAB semantics question
Date: Tue, 15 Aug 2006 00:49:50 +0200
User-Agent: KMail/1.9.1
References: <200608121724.16119.wigge@bigfoot.com> <20060814145848.GA4095@inferi.kami.home> <d120d5000608140815g121a84a3o58919582d5797305@mail.gmail.com>
In-Reply-To: <d120d5000608140815g121a84a3o58919582d5797305@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608150049.50815.wigge@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 17:15, Dmitry Torokhov wrote:
[...]
> > So why not just make EVIOCGRAB mean "don't send events to
> > mousedev but still report data to others opening the device"?
>
> That darn layering thing. We don't want evdev to know about all other
> handlers there are.

Nonono... I think the layers is a good thingy, even in this case..

What if you turn the whole thing around? Let the handler that should not get 
the events in case someone grabs the device (/dev/input/mice, more devices?) 
say it's so. And when the event is forwarded through the input-layer, check 
if the device is grabbed and in that case skip those handlers that shouldn't 
get any.

It would require an additional field in the input_handle struct that should be 
set to non-zero for mousedev and a change in the event-propagation code to 
send events to all handlers except to those with a non-zero value if grabbed 
(I'd estimate it to be less than 5-10 lines that has to be added/changed).

However, this doesn't address the problem I initially described (I think)... 
What if two application open the same device and one of the application do a 
EVIOCGRAB. Should both applications still get events? With the above fix two 
applications that opens /dev/input/mouse2 resp /dev/input/event4 for the same 
hw and the latter grabs the device, both will get events. Using a counter for 
grab (just like the open-counter) on the handler should make them behave the 
same way in both cases I think. Gnnn... I'll make a patch tomorrow (ok today, 
Tuesday) so you can see what I rambling about..

Won't EVIOCGRAB be quite misnamed (not that I propose a change...) if we make 
a change like this though?

 /Magnus
