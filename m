Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTFGGvo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTFGGvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:51:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16259 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262584AbTFGGvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:51:42 -0400
Date: Sat, 07 Jun 2003 00:02:33 -0700 (PDT)
Message-Id: <20030607.000233.115915549.davem@redhat.com>
To: wa@almesberger.net
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030606221100.L3232@almesberger.net>
References: <20030606211005.H3232@almesberger.net>
	<200306070057.h570vtsG003449@ginger.cmf.nrl.navy.mil>
	<20030606221100.L3232@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Fri, 6 Jun 2003 22:11:00 -0300
   
   When a driver's "close" function returns, the driver must have
   released all externally visible resources (e.g. VPI/VCI) that
   belong to the VCC, and ideally all invisible resources (e.g.
   buffers). There must be no more calls to "push".
   
   In return, the stack must not make any other calls for that
   VCC after invoking "close".

This is exactly how netdevice's WON'T be acting anymore.

All netdevice objects are allocated dynamically, and unregister
just means "disconnect" not "free".  It marks the device as
dead, and NULLs out all the callbacks in the netdevice struct.

Any further attempt to use the device (via some PROCFS file I/O
or whatever) will just error out.

So we return long before all references go away, and the final
netdevice reference put does the de-allocation of the netdevice
struct.

Totally asynchronous, and it just works.
