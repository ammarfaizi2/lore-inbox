Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbUCCFMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 00:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbUCCFMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 00:12:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:63384 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261465AbUCCFLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 00:11:55 -0500
Date: Tue, 2 Mar 2004 21:13:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: jbarnes@sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: per-cpu blk_plug_list
Message-Id: <20040302211309.500f43fb.akpm@osdl.org>
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB50211E5C8@scsmsx401.sc.intel.com>
References: <B05667366EE6204181EABE9C1B1C0EB50211E5C8@scsmsx401.sc.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> I don't understand the proposal here.  There is a per-device lock
> already.  But the plugged queue need to be on some list outside itself
> so a group of them can be unplugged later on to flush all the I/O.


here's the proposal:


Regarding this:

 http://www.ussg.iu.edu/hypermail/linux/kernel/0403.0/0179.html

 And also having looked at Miquel's (currently slightly defective)
 implementation of the any_congested() API for devicemapper:

 ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm1/broken-out/queue-congestion-dm-implementation.patch

 I am thinking that an appropriate way of solving the blk_run_queues() lock
 contention problem is to nuke the global plug list altogther and make the
 unplug function a method in struct backing_device_info.

 This is conceptually the appropriate place to put it - it is almost always
 the case that when we run blk_run_queues() it is on behalf of an
 address_space, and the few remaining case can be simply deleted -
 mm/mempool.c is the last one I think.

 The implementation of backing_dev_info.unplug() would have to run the
 unplug_fn of every queue which contributes to the top-level queue (the
 thing which the address_space is sitting on top of).

 We discussed this maybe a year ago with Jens but decided against it for
 complexity reasons, but gee, dm_table_any_congested() isn't complex.  Do we
 forsee any particular problem with this?
