Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbTENW6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTENW6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:58:50 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:6675
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263020AbTENW6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:58:49 -0400
Message-ID: <3EC2CD23.2030009@rogers.com>
Date: Wed, 14 May 2003 19:11:31 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Riley Williams <Riley@Williams.Name>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] NE2000 driver updates
References: <BKEGKPICNAKILKJKMHCACEOMCPAA.Riley@Williams.Name> <1052910126.2103.3.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1052910126.2103.3.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Wed, 14 May 2003 19:11:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Mer, 2003-05-14 at 08:29, Riley Williams wrote:
>
>  
>
>>If there's going to be any problems, it's with devices claiming the
>>same IOaddr as each other - and certain addresses are far too common
>>where that's concerned - especially 0x0300 through 0x031F which are
>>almost universal in their use !!!!!!!
>>    
>>
>
>This is why you have to get the ordering right. Specifically you have to
>deal with probe unsafe hardware (ie ne2000) early. Once you've checked
>0x300 isnt an NE2000 its generally safe to probe there, before that its
>a very bad idea. Space.c knows about this and a vast amount more.
>  
>
With the patch none of the ordering gets changed, with the following 
exceptions, afaik:

1. When request_region would prevent something from probing over top of 
something else. This is a bug with my current patch, but a tough one to 
avoid because we normally don't request_resource until the probe 
function is called...

2. Any breakage that results from spliting probe1 into detect and setup:
    device on 0x300.
    driver x, and driver y.
    old:
       probe1 from driver x fails late in the routine. (after the place 
where the detect/setup split would occur)
       driver y probe1 succeds and it gets the device

    new:
       driver x detect succeceds.
       all other driver detects at 0x300 thus fail.
       driver x setup fails.
       nobody gets the device.
   
This is a driver issue and as long as the split of probe1 to 
detect/setup is done right there should be no problems.

Also ethX numbering could change because of the alloc/register_netdev is 
happening at module init time and not at autoprobe time.

-Jeff

