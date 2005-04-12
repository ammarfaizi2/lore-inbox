Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVDLFer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVDLFer (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVDLFeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:34:36 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:59847 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262022AbVDLFYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:24:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=gff0AEpvyuaDfbeKSguAQzfygYIcMtaw0ZtyUCou1qqs+XxPZ1CQwY5s2H0vSYHHpE+60uTKsG9MVvwHiEFDFqIKxmxyH4xTZUBBb4S2ncbeWPFCtk8vCH2R2CElEtWc/Mh0Xhv+qDISZpA0dUBe1XJFWlUeBd1y6JyrrkLoRx0=
Message-ID: <9b7ca6570504112224dc532eb@mail.gmail.com>
Date: Tue, 12 Apr 2005 14:24:24 +0900
From: Daniel Ann <ktdann@gmail.com>
Reply-To: Daniel Ann <ktdann@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: alloc_skb called nonatomically from interrupt
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya folks

I'm trying to get a feel of notifier_call_chain(), but with no luck.
This is basically what I've done.

On 2.4.21, I've added dev_sample() function which I've declared and
implemented in include/linux/netdevice.h and net/core/dev.c
respectively.

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
int dev_sample(struct net_device *dev)
{
    notifier_call_chain(&netdev_chain, NETDEV_SAMPLE, dev);
    return 0;
}
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Of course, I've defined NETDEV_SAMPLE in include/linux/notifier.h

Now up to this stage, its fine. Problem is when I try to call
dev_sample() from driver/net/natsemi.c (my network device driver).

natsemi.c has check_link function which runs periodically and checks
to see if cable is out. So I've placed my dev_sample() in this
function and have it called whenever status of cable changes. But as
soon as the status change, machine dies with "alloc_skb called
nonatomically from interrupt c00ba700", with some printk's I was able
to find out notifier_call_chain() was getting called. But it happens
when it traverses the &netdev_chain. (at the very first one in fact)

I've tried wrapping the dev_sample() with rtnl_lock and unlock but
with no luck. It looks to me its to do with accessing resource at a
wrong time, but I have no idea where to go from here.

Any suggestion would be appreciated.
Cheers,

-- 
Daniel
