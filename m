Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTGASuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTGASuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:50:39 -0400
Received: from dm4-186.slc.aros.net ([66.219.220.186]:5256 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S263309AbTGASui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:50:38 -0400
Message-ID: <3F01DB5A.6060106@aros.net>
Date: Tue, 01 Jul 2003 13:04:58 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] should block layer export bd_set_size() or equivalent?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Background:

Several drivers (like drivers/block/nbd.c or drivers/block/rd.c) need to 
be able to update their devices' size after the first open. The way 
fs/block_dev.c is currently implemented (as recently as 2.5.73-mm2) 
however, updating the size as seen by user processes is not possible 
without directly updating the size stored in various locations of the 
struct block_device and the bd_inode as well. As an example, we have the 
code in drivers/block/rd.c rd_open() which essentially calls what 
fs/block_dev.c calls in its bd_set_size() function. But things are 
changing within the block layer still as evidenced by changes to 
bd_set_size() between 2.5.73 and 2.5.73-mm2 and consequently 
drivers/block/rd.c rd_open() may be incorrect now.

Suggestion:

To have fs/block_dev.c share bd_set_size(struct block_device *bdev, 
loff_t size) or something like this to better abstract the block layer 
from drivers and save us from essentially re-writing the code from here.

Next step:

Discuss this. Why isn't it already exported? What are the cons of just 
exporting bd_set_size()? Should we even let drivers change a device's 
size after the first open? An alternative for nbd at least, is to have 
its user space tool (nbd-client) simply close the device after it has 
changed the size and then re-open it before continuing on. This way 
fs/block_dev.c do_open() re-checks the disk capacity and calls 
bd_set_size() again with the new correct size. Also, bd_set_size() is 
very similar to set_blocksize() (the former though changes the byte size 
of the block device which is what's most critical really to nbd at 
least), perhaps these two functions can be rolled into one; at least 
set_blocksize() is already exported.

