Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbREQQeX>; Thu, 17 May 2001 12:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262030AbREQQeN>; Thu, 17 May 2001 12:34:13 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:38785 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S262019AbREQQdy>; Thu, 17 May 2001 12:33:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Subject: Re: LANANA: To Pending Device Number Registrants
Date: Thu, 17 May 2001 18:34:18 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <047801c0dd95$231331e0$6800000a@brownell.org> <990079966.25105.1.camel@agate> <01051714073800.01598@idun>
In-Reply-To: <01051714073800.01598@idun>
Cc: David Brownell <david-b@pacbell.net>, lkml <linux-kernel@vger.kernel.org>,
        Miles Lane <miles@megapathdsl.net>
MIME-Version: 1.0
Message-Id: <01051718341800.00784@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 May 2001 14:07, you wrote:
> For identifying this is probably the right approach. However identifying is
> not enough, as the ioctl discussion has shown. Capabilities are needed. How
> can the device registry provide that information ? 

The device registry provides you with device's capabilities and has different 
meachanisms for different needs:

- each device node has a type that describes the API (read/write format, 
ioctls) of the node. The type is set when you call devfs_register2 (a new 
version of devfs_register, set sets the node type and a connection to the 
physical device). So when you want to play pcm sound and your app supports 
OSS you search for the type "sound/oss/dsp"
- each physical device gets a type that is intended to be shown to the user 
and may be simplified. It can be used for things like selecting a appropriate 
icon for a device. It is not guaranteed to be correctly and some devices may 
not have a type.
- each bus subsystem and driver is free to add its own information. For 
example the PCI subsystem adds things like the interrupt, memory space and so 
on. User-space apps that dont know about it are required to ignore it. 


> If we register it together with the device, we might spend a lot of 
> resources needlessly and can't deal with devices whose capabilities 
> change dynamically.

No, the device and bus-subsystem information is generated on-demand, the type 
isnt guaranteed to be correct (and can be changed at any time) and the API of 
your device nodes hopefully doesnt change or otherwise you will really 
confuse the apps.


> In addition how do we export the information ? Proc ? Device nodes (bad for
> network devices) ?

The last version used a large XML file, but the next will expose the 
information in a (very) large number of proc files, each containing a single 
value. This required some changes in the proc API, but unfortunately I did 
not get a single comment on my patch 
(http://www.uwsg.indiana.edu/hypermail/linux/kernel/0105.1/1041.html)..

bye...

