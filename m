Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbULJJ3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbULJJ3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 04:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbULJJ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 04:29:04 -0500
Received: from mout.alturo.net ([212.227.15.20]:30682 "EHLO mout.alturo.net")
	by vger.kernel.org with ESMTP id S261152AbULJJ27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 04:28:59 -0500
Message-ID: <41B94A27.2010801@informatik.uni-bremen.de>
Date: Fri, 10 Dec 2004 08:03:03 +0100
From: Arne Caspari <arnem@informatik.uni-bremen.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Dennedy <dan@dennedy.org>
CC: Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       Daniel Drake <dsd@gentoo.org>, Christoph Hellwig <hch@lst.de>,
       Adrian Bunk <bunk@stusta.de>, Damien Douxchamps <ddouxcha@is.naist.jp>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Jesper Juhl <juhl-lkml@dif.dk>, Philippe De Muyter <phdm@macqel.be>,
       linux-kernel@vger.kernel.org
Subject: Re: linux1394 patches merged
References: <1102556231.3714.14.camel@kino.dennedy.org>
In-Reply-To: <1102556231.3714.14.camel@kino.dennedy.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Dennedy wrote:

>Hi folks,
>Just a shout out to let you know I have synced our subversion tree
>against bitkeeper linux-2.6, and I applied many patches you have
>submitted to the linux1394-devel mailing list over the past few months.
>Thank you for your patience, and I will help Ben Collins as much as I
>can to keep it current. We hope to get these changes into the 2.6.10
>release.
>  
>

Hi,

I know I am a bit late to join this discussion. But I have not had the 
time to dig into some issues I had and to continue development on my new 
driver.

There is an issue with the recent hotplug patches ( and not only the 
recent ones ) which define hotplug matches for devices. The problem is 
that "raw1394" and "video1394" define matches for devices ( in my case 
the IIDC-1394 cameras; spec_id = 0xa02d, version = 0x100|0x102|0x103 ) 
to get loaded by the hotplug scripts. As far as I can see, defining such 
a match causes the first driver loaded to get the device object for the 
matched device. Subsequent matches do not get a device object.

Since neither "raw1394" nor "video1394" are drivers specific to the 
devices they define matches for, no other ( specialized ) driver can 
ever get a device object. I am developing a v4l2 driver for the IIDC 
cameras which is based on the "video-2-1394" driver which again is 
designed around the device object and the callbacks of the ieee1394 bus 
driver. This driver never gets loaded since "raw1394" is the first match 
for the device signature and I had to patch "raw1394" and "video1394" 
not to match on anything.

Both mentioned drivers are generic protocol drivers for the IEEE-1394 
bus so in my opinion, if they define a match at all it should be the 
IEEE-1394 bus ( or an OHCI1394 card ) but never a match for a specific 
device ( since the drivers do not know anything about the device and 
therefore never need the device object ).

The only other solution I would see is if the kernel would assign a 
device object to EVERY module that defines a match for a device. But I 
think that not matching the generic drivers would be the cleaner solution.

 -Arne

