Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbTHZFVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbTHZFVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:21:15 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:34822 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S262630AbTHZFVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:21:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] raceless request_region() fix (was Re: Linux 2.6.0-test4)
Date: Tue, 26 Aug 2003 08:20:13 +0300
X-Mailer: KMail [version 1.4]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org> <200308260026.47994.insecure@mail.od.ua> <3F4A86B8.9080404@pobox.com>
In-Reply-To: <3F4A86B8.9080404@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308260820.13205.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[de-cc'ing Linus]

On Tuesday 26 August 2003 00:59, Jeff Garzik wrote:
> Is it a race if noone cares?  :)
>
> The code does
>
> 	if (!request_region(...))
> 		fail
> 	touch hardware
> 	release_region
> 	if (!request_region(...))
> 		fail
>
> If the HIGHLY UNLIKELY event of another ISA driver claiming this region
> occurs, the system continues working just fine.

Yes, this particular driver is fine. My patch just eliminate back-to-back
 	release_region(...)
 	if (!request_region(...)) fail;
pair.

I just have a feeling that if I am going to replace check_region with
request_region, I can close race window altogether.

BTW, it all started when I tried to get rid of check_region in de4x5.c.
That's a bit worse. For example:
        barrier();
        request_region(iobase, (lp->bus == PCI ? DE4X5_PCI_TOTAL_SIZE :
                                DE4X5_EISA_TOTAL_SIZE),
                       lp->adapter_name);
        lp->rxRingSize = NUM_RX_DESC;
-- 
vda
