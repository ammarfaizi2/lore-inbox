Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbTIYRpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTIYRgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:36:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:54207 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261514AbTIYRa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:30:27 -0400
Date: Thu, 25 Sep 2003 10:26:35 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Steven Dake <sdake@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH} fix defect with kobject memory leaks during del_gendisk
In-Reply-To: <1064444526.13033.355.camel@persist.az.mvista.com>
Message-ID: <Pine.LNX.4.44.0309251023220.947-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Attached is a patch which fixes a few memory leaks in 2.6.0-test5. 
> Comments are welcome as to whether or not this patch is the right
> solution.
> 
> I added the ability to linux MD to generate add and remove hotplug calls
> on RAID START and STOPs.  To achieve this, I use the del_gendisk call
> which deletes the gendisk, delete the children kobjects, and delete the
> parent (in this case, mdX) kobject.
> 
> Unfortunately it appears that del_gendisk uses kobject_del to delete the
> kobject.  If the kobject has a ktype release function, it is not called
> in the kobject_del call path, but only in kobject_unregister.
> 
> This patch changes the functionality so the release function (in this
> case the block device release function in drivers/block/genhd.c) is
> called by changing the kobject_del to kobject_unregister.

It is not the right thing to do, as Christoph pointed out. Gendisks have a 
lifetime longer than the time between add_disk() and del_gendisk(). They 
are created before they are added, and the objects may persist longer 
after they have been removed from view. 

To delete the last reference, the MD layer should be calling put_disk(), 
which will trigger release to happen. 

Your patch will actually cause other bugs, since the final put_disk() of 
other block drivers will now be called on already freed memory.


	Pat

