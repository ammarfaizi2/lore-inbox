Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUBJS0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUBJS0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:26:50 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:19692 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S266090AbUBJS0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:26:25 -0500
Message-ID: <40292246.2030902@backtobasicsmgmt.com>
Date: Tue, 10 Feb 2004 11:26:14 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: ATARAID userspace configuration tool
References: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk> <1076425115.23946.18.camel@leto.cs.pocnet.net>
In-Reply-To: <1076425115.23946.18.camel@leto.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:

> I have a really bad idea :)
> 
> Try to combine it with udev. udev calls the ide script, the ide script
> then calls the ataraid detector. If the device is non-ataraid, go on as
> usual. If it is, build the device-mapper device and symlink (if it
> doesn't already exist) and tell udev to not create anything.

This is not a bad idea, it's the future. The hotplug mechanism is 
exactly what should be used here. When a block-device hotplug ADD event 
occurs, you look at that device to see if it's something you care about. 
If not, just exit and leave it alone.

Now in the ATARAID case, where you need to see multiple devices before 
you can do anything with them, this means you'd need to keep some 
"state" somewhere about the devices you've seen so far, and the partial 
ATARAID devices they represent. When you get the hotplug event for the 
last piece of a particular ATARAID device, you use DM/MD to set up the 
device and make it available.

The wonderful part of this is, when you do that last step, _another_ 
block-device hotplug ADD event occurs for the new device you just 
created, and if the hotplug scripts are set up to run dmpartx or its 
equivalent for new block-devices, you are done. The partition tables 
_inside_ the ATARAID device will be read, more DM calls will be made to 
make those sub-devices available to userspace and everyone is thrilled 
about the elegance of the solution :-)

