Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTFCSUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbTFCSUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:20:31 -0400
Received: from dm4-167.slc.aros.net ([66.219.220.167]:39305 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S262139AbTFCSUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:20:30 -0400
Message-ID: <3EDCEA14.2000407@aros.net>
Date: Tue, 03 Jun 2003 12:33:56 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.70 add_disk(disk) re-registering disk->queue->elevator.kobj (bug?!)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What am I missing (or is something in the block handling code actually 
seriously wrong)?

In linux-2.5.70/drivers/block/genhd.c the add_disk(disk) logic seems 
wrong because if disk->queue is shared by a few disk's, then that shared 
queue's elevator is re-registered via the call to 
elv_register_queue(disk) which calls down to 
kobject_register(disk->queue->elevator.kobj). Or perhaps the block 
handling logic was changed such that disks don't share the same 
request_queue anymore. If so, then a few drivers (like nbd) need to be 
updated to use a seperate request_queue per disk. If the block handling 
code wasn't however changed this way though and struct gendisk objects 
can still share the same request_queue then it seems a lot of other 
logic todo with elv_register_queue() is also scrogged. Like shouldn't 
disk->kobj.parent be set to kobject_get(&disk->queue->elevator.kobj) 
instead of the reverse that the 2.5.70 code does? If so, then all the 
deallocation code (called from del_gendisk(disk)) needs to be reversed 
and changed around too. Seems like so much wrong logic that it's my 
reading of the code that's at fault instead. Help!?

CC me on any email as I don't read the lkml regularly. ldl@aros.net

Thanks!!

Louis D. Langholtz

