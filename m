Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTLBNPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 08:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTLBNPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 08:15:34 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:30901 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S262070AbTLBNP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 08:15:29 -0500
Message-ID: <3FCC906C.5040907@backtobasicsmgmt.com>
Date: Tue, 02 Dec 2003 06:15:24 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Linux-raid maillist <linux-raid@vger.kernel.org>, linux-lvm@sistina.com
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
References: <3FCB4AFB.3090700@backtobasicsmgmt.com> <20031201141144.GD12211@suse.de> <3FCB4CFA.4020302@backtobasicsmgmt.com> <20031201155143.GF12211@suse.de> <3FCC0EE0.9010207@backtobasicsmgmt.com> <20031202082713.GN12211@suse.de> <20031202211002.C2009778@wobbly.melbourne.sgi.com>
In-Reply-To: <20031202211002.C2009778@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:

> One thing that might be of interest - XFS does tend to pass
> variable size requests down to the block layer, and this has
> tripped up md and other drivers in 2.4 in the distant past.
> 
> Log IO is typically 512 byte aligned (as opposed to block or
> page size aligned), as are IOs into several of XFS' metadata
> structures.

Hey, thanks for the pointer! I think we're getting somewhere now. Here's 
a recap of the tested combinations:

XFS on raw disk: OK
XFS on LVM2 on single disk: OK
XFS on LVM2 on RAID-5: fails
ext2 on LVM2 on RAID-5: OK

I just tested XFS on LVM2 on RAID-5 using "-l sunit=8" while creating 
the filesystem to force log writes be block-sized and block-aligned; 
this seems to work :-) I have not been able to force a failure using my 
test script, although ATM the system is still running a RAID-5 resync of 
the array, but that should only make the problem more likely, not less.

So, this does appear to be an md/dm stacking problem, that is exposed by 
XFS sending non-block-sized and/or non-block-aligned IOs.

