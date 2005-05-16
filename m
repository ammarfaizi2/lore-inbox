Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVEPQqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVEPQqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 12:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVEPQqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 12:46:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:11420 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261741AbVEPQqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 12:46:20 -0400
Message-ID: <4288CE51.1050703@pobox.com>
Date: Mon, 16 May 2005 12:46:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: akpm@osdl.org, T-Bone@parisc-linux.org, varenet@parisc-linux.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: patch tulip-natsemi-dp83840a-phy-fix.patch added to -mm tree
References: <200505101955.j4AJtX9x032464@shell0.pdx.osdl.net> <42881C58.40001@pobox.com> <20050516050843.GA20107@colo.lackof.org>
In-Reply-To: <20050516050843.GA20107@colo.lackof.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simply ensure that tulip_select_media() is always called from a process 
context. Then can you delay all you want.  Several of the calls are 
already this way, so that leaves two cases:

1) called from timer context, from the media poll timer

2) called from spin_lock_irqsave() context, in the ->tx_timeout hook.

The first case can be fixed by moved all the timer code to a workqueue. 
  Then when the existing timer fires, kick the workqueue.

The second case can be fixed by kicking the workqueue upon tx_timeout 
(which is the reason why I did not suggest queue_delayed_work() use).

See, it's not rocket science :)

	Jeff



