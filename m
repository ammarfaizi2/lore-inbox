Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVA0ACX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVA0ACX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVA0ABT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:01:19 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:6503 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262289AbVAZUWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 15:22:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=W1GUACcdnzJiKDNXilD+33j+gRg1MAl43vGgjxHZHjxfL+FZic7fEinmex+eWqMfWvz7uZS3ZKs8kEuFI4uFhGY8zItkv1005wvjoqTF+kk+tpRn6ealIaBgEkY6rybW27A4x4+JfKbrNFNMquYsxT0qyrbYfkyXo44Z39gVPd4=
Message-ID: <d120d50005012612226401eed2@mail.gmail.com>
Date: Wed, 26 Jan 2005 15:22:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: 2.6.11-rc2-mm1
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050126230712.1dd63589@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <1106751547.5257.162.camel@uganda>
	 <d120d5000501260726714e8251@mail.gmail.com>
	 <1106754848.5257.189.camel@uganda>
	 <d120d500050126082515bd68f9@mail.gmail.com>
	 <1106757974.5257.229.camel@uganda>
	 <d120d50005012608556ab05a96@mail.gmail.com>
	 <1106761176.5257.246.camel@uganda>
	 <d120d5000501261026700e37c0@mail.gmail.com>
	 <20050126230712.1dd63589@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 23:07:12 +0300, Evgeniy Polyakov
<johnpol@2ka.mipt.ru> wrote:
> 
> Chip driver provides access methods to the attached logical devices.
> It probes and activates them, if appropriate module is loaded.
> 
> Your example again is not suitable for superio case.
> 
> With superio you have several identical logical devices, access to which
> is absolutely standard in second level(logic befind access),
> but in first one(physicall access) it can differ.
> 
> So here is the real example of superio usage:
> 
>     userspace
>        |
>    superio core
>      ......
> 
>       GPIO
>  |----|  |--|
> pc87366     sc1100
>  |----| |---|
>       WDT
> 
> Logical device GPIO is accessed by read/write methods, which only have
> pin number(it is not how this methods are exactly implemeted though)
> as parameter.
> 
> For example userspace accesses GPIO at sc1100 - it will be translated
> into read methods called from appropriate superio chip with appropriate
> parameters.
> 
> When we have multiple GPIO logical devices(each in it's own superio chip)
> it is more convenient to use just the same object.

I take an exception to that. I think useroace is not concerned with
topology and ownership of logical devices, the data is more important.
I.e. you need to know that some pin respons to CPU temperature but you
don't really care that it connected to it87 as opposed to some other
chip. Therefore I think that ldev should translate to exactly the same
underlying object. Consider the picture below:

        GPIO0     GPIO1   GPIO2 GPIO3
          |         |       |     |
       pc87266   sc1100     blah123
          |         |
         WDT0      WDT1

This will allow:
- map every hardware piece (not entire chip, separate functions) to a
device file to userspace can use standard read/write/select/poll if
choses so.
- easily represent them in sysfs and also allow userspace access to
individual bits through sysfs attributes.
- will not give headaches with poer management when half of device is
powered down and half is active.
- provided that there are alternative interfaces outlined above
superio can be decoupled from the connector.

I wonder if it should be called "gpio" bus as opposed to superio
because only chips are "super", the bus consists of very simple
devices and drivers.

> I did not understand you from the beginning...

We are getting there I believe ;) 

-- 
Dmitry
