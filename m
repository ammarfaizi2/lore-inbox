Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTFFN4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 09:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbTFFN4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 09:56:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38891 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261222AbTFFN4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 09:56:48 -0400
Date: Fri, 06 Jun 2003 07:07:47 -0700 (PDT)
Message-Id: <20030606.070747.48395512.davem@redhat.com>
To: wa@almesberger.net
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030606105753.A3275@almesberger.net>
References: <200306061100.h56B08sG024506@ginger.cmf.nrl.navy.mil>
	<20030606.040410.54190551.davem@redhat.com>
	<20030606105753.A3275@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Fri, 6 Jun 2003 10:57:53 -0300
   
   What should help in the ATM code is that it pushes synchronization
   "down", i.e. "close" functions usually can't return until they are
   truly done (or at least have made sure there is nothing externally
   visible left).
   
If we move over to a more netdevice-based design for ATM,
this will not longer be acceptable.

Unregister of netdevices is %100 asynchronous, even if references
remain (and even if the device is UP!), we close then rip the device
out of the kernel.  As references go away we finally get to zero
and thus can finally kfree() up the netdevice.

This has some problems currently which Al and myself are fixing.  In
the final analysis we'll even handle things like stray SYSFS and
PROCFS references by marking the device "dead" at unregister time
and any post-unregister reference will see this and error out.

This is a much better model than synchronizing everything, you tie
your hands when you do it that way and it tends to lead to module
unload deadlocks.
