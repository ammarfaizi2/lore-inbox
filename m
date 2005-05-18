Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVERMji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVERMji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 08:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVERMhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 08:37:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33244 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261426AbVERMgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 08:36:54 -0400
Message-ID: <428B3664.7030906@redhat.com>
Date: Wed, 18 May 2005 08:34:44 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reproducible 2.6.11.9 NFS Kernel Crashing Bug!
References: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain> <1116341217.21388.145.camel@localhost.localdomain> <Pine.LNX.4.63.0505172036020.2028@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0505172036020.2028@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:

> And I am using UDP, not TCP.
>
> NFS Version 3.


You may able to specify rsize and wsize of 65536 with NFS Version 3 running
over UDP, but it is guaranteed not to work if either the client or the 
server attempts
a 64K transfer.

The problem is that UDP is limited to a 64K datagram.  This datagram 
must hold
the data, some NFS protocol data structures, and some RPC data 
structures.  This
exceeds the 64K limit.  RPC over UDP will not allow the use of multiple UDP
datagrams, so RPC over UDP is limited to less than 64K payloads.  RPC over
TCP will allow larger operations because there is no such single 
datagram limit.

You could specify 56K or 60K transfer sizes if you wanted to stay at a 
multiple
of 8K or 4K, but there doesn't seem to be much point.  The 32K number was
chosen because it was the largest power of 2 below 64K and seems to work
pretty well in most circumstances.

In general, I wouldn't recommend mucking with the read/write transfer sizes
unless you really know what you are doing and understand the target 
environment
very well.

       ps
