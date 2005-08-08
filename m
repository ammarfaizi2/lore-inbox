Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVHHVCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVHHVCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVHHVCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:02:15 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:12160 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S932227AbVHHVCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:02:15 -0400
Message-ID: <42F7C853.90901@ammasso.com>
Date: Mon, 08 Aug 2005 16:02:11 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Reply-To: linux-kernel@vger.kernel.org
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about multiple modules talking to one adapter
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a PCI adapter that supports three different APIs / interfaces.  The adapter is an
OpenIB device, a regular 10GB ethernet Netdev device, and there's also a proprietary
interface called CCIL that we invented.  The CCIL interface is really just a bunch of
custom IOCtls.

The problem we have is that our adapter appears as just one PCI device, so it has one
memory buffer and one IRQ.  All three interfaces need access to adapter memory and need an
ISR.

We're going to have a separate module for each interface.  For simplicity sake, I'll call
these openib.ko, netdev.ko, and ccil.ko.  openib.ko will be in the drivers/inifiniband
directory. netdev.ko will be in the drivers/network directory.  I don't know yet where
we'll put ccil.ko.

The way I see it, there are four different ways to implement these drivers, and I would
like to know which method the Linux community would prefer:

1) Each driver registers its own ISR and has its own mapping the adapter memory.  This is
the simplest approach, but the problem is that every time an ISR is called, it does a read
across the PCI bus to determine whether the interrupt is for it.  Believe it or not, this
is actually pretty expensive in terms of performance.  If anyone has an idea on how to
cleanly solve that particular problem, then this is the approach we'll take.  Otherwise,
we'd rather do implement one of the other two methods.

2) Create a single driver which does nothing but register an ISR and map the kernel
memory.  Let's call this the CRM driver.  The other three drivers can then use XXXXXX to
provide callbacks for the ISR and obtain the address of the mapping.  The ISR will then
query the adapter and call the appropriate callback.

3) A variation on #2: Instead of having a separate driver with the CRM code, one of the
three modules will have that code.  The other two modules will then have a dependency on
that first module.  The problem is that I don't know which of the three modules should
have the CRM.  Plus, this creates an artificial dependency.

4) Another variation on #2: Each module has a copy of the CRM code, but only the CRM in
the first module that's loaded is used.  As each module loads, it tries to find one of the
other two modules.  If it does find one of the other modules, it uses that other module's
CRM instead of its own.  Otherwise, it exports its own CRM entry points.

Thanks.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13

--
Kernelnewbies: Help each other learn about the Linux kernel.
Archive:       http://mail.nl.linux.org/kernelnewbies/
FAQ:           http://kernelnewbies.org/faq/


