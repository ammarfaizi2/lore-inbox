Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUAMSof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUAMSoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:44:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55185 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264903AbUAMSoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:44:19 -0500
Message-ID: <40043C75.6040100@pobox.com>
Date: Tue, 13 Jan 2004 13:44:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Long <scott_long@adaptec.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Proposed enhancements to MD
References: <40033D02.8000207@adaptec.com>
In-Reply-To: <40033D02.8000207@adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Long wrote:
> I'm going to push these changes out in phases in order to keep the risk
> and churn to a minimum.  The attached patch is for the partition
> support.  It was originally from Ingo Molnar, but has changed quite a
> bit due to the radical changes in the disk/block layer in 2.6.  The 2.4
> version works quite well, while the 2.6 version is fairly fresh.  One
> problem that I have with it is that the created partitions show up in
> /proc/partitions after running fdisk, but not after a reboot.

You sorta hit a bad time for 2.4 development.  Even though my employer 
(Red Hat), Adaptec, and many others must continue to support new 
products on 2.4.x kernels, kernel development has shifted to 2.6.x (and 
soon 2.7.x).

In general, you want a strategy of "develop on latest, then backport if 
needed."  Once a solution is merged into the latest kernel, it 
automatically appears in many companies' products (and perhaps more 
importantly) product roadmaps.  Otherwise you will design various things 
into your software that have already been handled different in the 
future, thus creating an automatically-obsolete solution and support 
nightmare.

Now, addressing your specific issues...

> hile MD is fairly functional and clean, there are a number of enhancements to it that we have been working on for a while and would
> like to push out to the community for review and integration.  These
> include:
> 
> - partition support for md devices:  MD does not support the concept of
>   fdisk partitions; the only way to approximate this right now is by
>   creating multiple arrays on the same media.  Fixing this is required
>   for not only feature-completeness, but to allow our BIOS to recognise
>   the partitions on an array and properly boot them as it would boot a
>   normal disk.

Neil Brown already done a significant amount of research into this 
topic.  Given this, and his general status as md maintainer, you should 
definitely make sure he's kept in the loop.

Partitioning for md was discussed in this thread:
http://lkml.org/lkml/2003/11/13/182

In particular note Al Viro's response to Neil, in addition to Neil's own 
post.

And I could have _sworn_ that Neil already posted a patch to do 
partitions in md, but maybe my memory is playing tricks on me.


> - generic device arrival notification mechanism:  This is needed to
>   support device hot-plug, and allow arrays to be automatically
>   configured regardless of when the md module is loaded or initialized.
>   RedHat EL3 has a scaled down version of this already, but it is
>   specific to MD and only works if MD is statically compiled into the
>   kernel.  A general mechanism will benefit MD as well as any other
>   storage system that wants hot-arrival notices.

This would be via /sbin/hotplug, in the Linux world.  SCSI already does 
this, I think, so I suppose something similar would happen for md.


> - RAID-0 fixes:  The MD RAID-0 personality is unable to perform I/O
>   that spans a chunk boundary.  Modifications are needed so that it can
>   take a request and break it up into 1 or more per-disk requests.

I thought that raid0 was one of the few that actually did bio splitting 
correctly?  Hum, maybe this is a 2.4-only issue.  Interesting, and 
agreed, if so...


> - Metadata abstraction:  We intend to support multiple on-disk metadata
>   formats, along with the 'native MD' format.  To do this, specific
>   knowledge of MD on-disk structures must be abstracted out of the core
>   and personalities modules.

> - DDF Metadata support: Future products will use the 'DDF' on-disk
>   metadata scheme.  These products will be bootable by the BIOS, but
>   must have DDF support in the OS.  This will plug into the abstraction
>   mentioned above.

Neil already did the work to make 'md' support multiple types of 
superblocks, but I'm not sure if we want to hack 'md' to support the 
various vendor RAIDs out there.  DDF support we _definitely_ want, of 
course.  DDF follows a very nice philosophy:  open[1] standard with no 
vendor lock-in.

IMO, your post/effort all boils down to an open design question:  device 
mapper or md, for doing stuff like vendor-raid1 or vendor-raid5?  And it 
is even possible to share (for example) raid5 engine among all the 
various vendor RAID5's?

	Jeff


[1] well, developed in secret, but published openly.  Not quite up to 
Linux's standards, but decent for the h/w world.

