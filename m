Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUGMVOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUGMVOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbUGMVOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:14:00 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:35241 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S265900AbUGMVN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:13:58 -0400
Message-ID: <40F44FFB.80707@pacbell.net>
Date: Tue, 13 Jul 2004 14:11:23 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Will Beers <whbeers@mbio.ncsu.edu>
CC: Olaf Hering <olh@suse.de>, Gary_Lerhaupt@Dell.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Stuart_Hayes@Dell.com
Subject: Re: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
References: <FD3BA83843210C4BA9E414B0C56A5E5C07DD91@ausx2kmpc104.aus.amer.dell.com> <40CF0049.2010307@pacbell.net> <20040713180727.GA11583@suse.de> <40F4457F.2010005@pacbell.net> <40F449BD.2030508@mbio.ncsu.edu>
In-Reply-To: <40F449BD.2030508@mbio.ncsu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Beers wrote:
>  > though maybe 500 msec is too short a period to wait.
>  > See if 5000 msec helps.
> 
> I went all the way up to 20000 msec and it still didn't help.  I'm sure 
> it's a bad idea, but removing that whole if-block below it makes it work 
> (which is effectively what switching the and/or did).  I don't know 
> enough about it to judge whether it's correct, but what exactly is it 
> checking for there?

There are two flags in adjacent bytes of pci config space.
State transitions are shown in the spec [1] (simple state
diagrams), but basically your hardware started out in a
"BIOS owned" mode, and we want Linux to run it instead.
So we change (0,1) to (1,1), then BIOS should get an IRQ
before changing it to (1,0) and ignoring EHCI ... it's not.

Sounds to me like your BIOS may be broken.  But if you're
up for it, you could try using byte access to write that one
flag byte; I could also believe some hardware won't issue the
SMI interrupt without that.  There are also a lot of bits in
the next word, which might let you stomp on on the BIOS in
constructive useful ways.

- Dave

[1] http://www.usb.org/developers/docs/ at the very
     bottom of the page, for that part you won't need
     to know anything else about USB.

