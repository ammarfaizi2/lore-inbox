Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSGDUTc>; Thu, 4 Jul 2002 16:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSGDUTb>; Thu, 4 Jul 2002 16:19:31 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:50579 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S313698AbSGDUSh>; Thu, 4 Jul 2002 16:18:37 -0400
Date: Thu, 04 Jul 2002 13:23:54 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: usb storage cleanup
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Message-id: <3D24AEDA.9090100@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3D236950.5020307@colorfullife.com>
 <20020703144329.D8033@one-eyed-alien.net> <3D237870.7010600@colorfullife.com>
 <20020703170521.E8033@one-eyed-alien.net> <3D248208.4060500@colorfullife.com>
 <20020704125012.C17360@one-eyed-alien.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Test case: user pulls out the usb cable while a transfer is in progress. 
>>urb submitted to the device, reply not yet received.
>>Result: storage_disconnect() would hang for 20 seconds until 
>>command_abort() is called.
> 
> 
> No, not quite.   The HCD accelerates the URBs to completion if the device
> is removed with an URB pending on it.  It therefore shouldn't hang for the
> timeout -- if you're seeing this behavior, then the HCD is broken.

Actually all of the interesting work is triggered by khubd,
and then the device driver.

Khubd calls usb_disconnect() for the device.  That disconnects
each driver (which is supposed to wait until all urbs it's
submitted have completed, and not submit any more URBS).

Only at the very end of this does the HCD hear anything about
devices going away.  If there's any URB still submitted at that
point it's not a bug in the HCD at all ... but in a device
driver that didn't implement disconnect() correctly.

- Dave




