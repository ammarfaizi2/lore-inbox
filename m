Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264064AbUDGAlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 20:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUDGAlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 20:41:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:8624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264064AbUDGAlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 20:41:51 -0400
Date: Tue, 6 Apr 2004 17:41:50 -0700
From: Chris Wright <chrisw@osdl.org>
To: Brian King <brking@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: call_usermodehelper hang
Message-ID: <20040406174150.D22989@build.pdx.osdl.net>
References: <4072F2B7.2070605@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4072F2B7.2070605@us.ibm.com>; from brking@us.ibm.com on Tue, Apr 06, 2004 at 01:11:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Brian King (brking@us.ibm.com) wrote:
> I have been running into some kernel hangs due to call_usermodehelper. Looking
> at the backtrace, it looks to me like there are deadlock issues with adding
> devices from work queues. Attached is a sample backtrace from one of the
> hangs I experienced. My question is why does call_usermodehelper do 2 different
> things depending on whether or not it is called from the kevent task? It appears
> that the simple way to fix the hang would be to never have call_usermodehelper
> use a work_queue since it must be called from process context anyway, or
> am I missing something?

It does two different things because it's trying to run from keventd.
In the case that current is not keventd, it schedules the work, so
keventd will pick that work up later to run in it's process context.

How early is this hang?  It looks like init thread adds work and waits
for it's completion while holding a semaphore.  It is never woken up by
keventd which is sleeping waiting for wakeup from semaphore that init
thread took.

Seems troubling to hold the sem while calling call_usermodehelper, as that
could go off for a long time.

swapper							events/0
-------							--------
bus_add_driver()				ipr_worker_thread()
 down_write(&bus->subsys.rwsem) /* here */	 scsi_add_device()
  driver_attach()				  bus_add_device()
   ...						   /* sem is already taken */
   sd_probe()					   down_write(&bus->subsys.rwsem)
    add_disk()					    schedule() /* bye! */
    ...
     call_usermodehelper()
      wait_for_completion() /* never awoken by keventd */

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
