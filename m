Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266037AbUEUWEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266037AbUEUWEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266040AbUEUWEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:04:48 -0400
Received: from [141.156.69.115] ([141.156.69.115]:14504 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S266037AbUEUWEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:04:46 -0400
Message-ID: <40AE7CFE.5060805@infosciences.com>
Date: Fri, 21 May 2004 18:04:46 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com>
In-Reply-To: <40AE7829.9060105@infosciences.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nardelli wrote:
> Greg KH wrote:
> 
> 
>>> @@ -456,7 +460,8 @@ static void visor_close (struct usb_seri
>>>         return;
>>>     
>>>     /* shutdown our urbs */
>>> -    usb_unlink_urb (port->read_urb);
>>> +    if (port->read_urb)
>>> +        usb_unlink_urb (port->read_urb);
>>
>>
>> I really do not think these extra checks for read_urb all of the place
>> need to be added.  We take care of it in the open() call, right?
>>
> 
> Yes - less clutter and more efficient too.
> 


Maybe I spoke too soon here.  We have 1 bulk in, 2 bulk out, and 1 interrupt
in endpoint, which by the logic in usb-serial, translates to 2 ports.  Only
one of those ports can have a read_urb associated with it, unless we want to
do some really fancy juggling.  This means that we're going to have a port
that does not have a valid read_urb associated with it, even after open().
In this case, any attempt to read from /dev/ttyUSB0 (even if it is useless)
would result in a null pointer access violation unless there is some
form of protection around it.  Not permitting reads on this port would get
around this, but putting 'if' checks around access to read_urb is probably
much simpler.

I'm at a loss why this device has an uneven number of bulk in and bulk out
endpoints.

Any thoughts?

-- 
Joe Nardelli
jnardelli@infosciences.com
