Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbTIIAlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbTIIAlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:41:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35820 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263839AbTIIAlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:41:44 -0400
Message-ID: <3F5D21BC.9020808@pobox.com>
Date: Mon, 08 Sep 2003 20:41:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: fedor@karpelevitch.net, abz@frogfoot.net, linux-kernel@vger.kernel.org
Subject: Re: possibly bug in 8139cp? (WAS Re: BUG: 2.4.23-pre3 + ifconfig)
References: <20030904180554.GA21536@oasis.frogfoot.net>	<200309071217.03470.fedor@karpelevitch.net>	<20030907191552.GA26123@oasis.frogfoot.net>	<200309080943.26254.fedor@karpelevitch.net>	<20030908172641.GB21226@gtf.org>	<20030908133220.66676107.akpm@osdl.org>	<3F5D17EA.4010502@pobox.com> <20030908170902.66f85c38.akpm@osdl.org>
In-Reply-To: <20030908170902.66f85c38.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> The only thing it can break is tg3, which appears to be placing a competing
> interpretation upon the handling of this flag.


Right, so, don't break tg3 :)  The patch I posted doesn't do the 
_and_set, which tg3 needs.  netif_poll_{enable,disable} control whether 
the net stack may call the dev->poll() function.  tg3 asynchronously 
disables polling, resets the phy and/or hardware, then enables polling 
again.

I thought I had a check in there for when it was contending with 
dev_close(), but I'll look again.  The hardware/phy reset should 
continue to occur regardless of dev_close() -- that's ok.  During this 
event, all rx/tx is already stopped anyway.  So we can let ifdown/ifup 
events occur in parallel... carefully.  :)

Ideally we want to present a machine that's asynchronously managing its 
power state and various functions.  dev->open() and dev->close() events 
become just two more "major events."

	Jeff



