Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTFFKxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 06:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbTFFKxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 06:53:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34026 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261151AbTFFKxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 06:53:09 -0400
Date: Fri, 06 Jun 2003 04:04:10 -0700 (PDT)
Message-Id: <20030606.040410.54190551.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2) 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306061100.h56B08sG024506@ginger.cmf.nrl.navy.mil>
References: <20030606.023618.13768006.davem@redhat.com>
	<200306061100.h56B08sG024506@ginger.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Fri, 06 Jun 2003 06:58:20 -0400

   In message <20030606.023618.13768006.davem@redhat.com>,"David S. Miller" writes:
   >Read the comment above dev_base in drivers/net/Space.c to see what
   >the intended locking model is.
   
   yeah, i already read that.  it has a bit of a typo (rtln indeed).
   it looks like rtnl_lock() is also used to protect dev_ioctl's
   (thus my usage in atm_ioctl) and protect lookup's like __dev_get_by_name.

RTNL also protects the rest of all networking administrative
via being acquired in the recvmsg() loop of rtnetlink.c

Basically it protects all networking administrative actions, add an
address for a device, up a device, down a device, add a route, attach
a packet scheduler to dev, etc. etc.

   i didnt get rid of atm_dev_lock, i just dont use it unless writing
   or if i couldnt safely use rtnl when a reader is iterating (like
   atm_dev_hold() which could be called at interrupt--though no one does).
   i thought this was the idea.
   
Hmmm, this is not how RTNL works on netdevs.  The SMP lock is held
around all walking, and at the very precise moment where we are
doing the actual device unlink from dev_base.  rtnl is acquired at
top-level when we will change something.

This is very different from how you are using the lock+rtnl scheme
for your ATM stuff.

