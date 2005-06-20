Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVFTTNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVFTTNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVFTTLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:11:44 -0400
Received: from imap.gmx.net ([213.165.64.20]:58559 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261512AbVFTTKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:10:17 -0400
X-Authenticated: #137701
From: Alexander Gretencord <arutha@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Swapping in 2.6.10 and 2.6.11.11 on a desktop system
Date: Mon, 20 Jun 2005 21:09:50 +0200
User-Agent: KMail/1.8.1
References: <200506141653.32093.arutha@gmx.de> <200506151544.17191.arutha@gmx.de> <200506161416.03569.kernel@kolivas.org>
In-Reply-To: <200506161416.03569.kernel@kolivas.org>
Cc: Con Kolivas <kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506202109.51059.arutha@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 June 2005 06:16, you wrote:
> echo 100 > /proc/sys/vm/mapped

Doesn't work either.

What I do to test this is the following:

Start X with KDE, start a Konqueror instance, a firefox, eclipse and vmware. 
This increases memory load to about 250MB. Then I start os inside the vmware 
virtual machine. This increases memory allocation because the guest operating 
system has to exist somewhere and generates IOs while the virtual disk is 
accessed. With mapped=100 it takes longer until the system begins to swap but 
once it has begun swapping I get this:

             total       used       free     shared    buffers     cached
Mem:           503        498          5          0         10        412
-/+ buffers/cache:         75        428
Swap:          494        230        264

It does not matter which patch I am using, once the magical "begin 
swapping"-mark is reached, real ram usage drops to a bare minimum and cache 
usage goes up. The IO cache is probably not even used as there are virtually 
no reusable parts. 

The problem is the kernel thinking in the wrong direction (freeing ram for 
disk cache). Maybe that's ok for a streaming server which uses 10MB of RAM 
for code and internal data and is constantly accessing the same 400MB of 
streaming video data. Or a webserver serving a big amount of static pages 
etc. but it is not ok for my desktop workload where I have about 400MB of 
data belonging to applications and IOs are not repeating very often (disk 
cache efficiency is probably very low).

Any idea why the kernel behaves like this and how I can get expected 
behaviour? Expected behaviour for a desktop would be:

Use as much disk cache as there is free RAM. Once applications start using all 
the ram, only keep a certain percentage/bare minimum of disk cache. What is 
absolutely undesirable is a growing and growing disk cache when there is not 
enough ram to keep applications and/or their data in ram.

> If this tries so hard to avoid swap that you get an out-of-memory condition
> you may also have to disable the hard maplimit with this:
> echo 0 > /proc/sys/vm/hardmaplimit

Yes I get oom conditions with mapped=100 but they are not my real problem, the 
problem is the disk cache usage pattern. I it would help, I still have some 
dmesg output from the oom killer.

Any ideas? Am I just doing something wrong? I don't use any 
special /proc-settings other than the swappiness/mapped test values.


Alex
