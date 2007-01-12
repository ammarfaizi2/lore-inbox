Return-Path: <linux-kernel-owner+w=401wt.eu-S1161108AbXALV6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbXALV6v (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbXALV6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:58:51 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:6129 "EHLO
	nommos.sslcatacombnetworking.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161108AbXALV6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:58:50 -0500
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Transfer-Encoding: 7bit
Message-Id: <D7BBB18A-F5D4-4FE0-903F-3683333D957C@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: Linux Kernel list <linux-kernel@vger.kernel.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: tuning/tweaking VM settings for low memory (preventing OOM)
Date: Fri, 12 Jan 2007 15:58:08 -0600
X-Mailer: Apple Mail (2.752.2)
X-PopBeforeSMTPSenders: kumar-chaos@kgala.com,kumar-statements@kgala.com,kumar@kgala.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on an embedded PPC setup with 64M of memory and no swap.   
I'm trying to figure out how best to tune the VM for an OOM situation  
I'm running into.

I'm running a 2.6.16.35 kernel and have a bittorrent app that appears  
to be initializing a large file for it to download into.  What I see  
before running the app:

/bigfoot/usb_disk # cat /proc/meminfo
MemTotal:        62520 kB
MemFree:         49192 kB
Buffers:          8240 kB
Cached:            740 kB
SwapCached:          0 kB
Active:           8196 kB
Inactive:         1236 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        62520 kB
LowFree:         49192 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:            916 kB
Slab:             2224 kB
CommitLimit:     31260 kB
Committed_AS:     1704 kB
PageTables:         88 kB
VmallocTotal:   933872 kB
VmallocUsed:      9416 kB
VmallocChunk:   923628 kB

after the OOM:

/bigfoot/usb_disk # cat /proc/meminfo
MemTotal:        62520 kB
MemFree:          1608 kB
Buffers:          8212 kB
Cached:          42780 kB
SwapCached:          0 kB
Active:           6228 kB
Inactive:        45176 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        62520 kB
LowFree:          1608 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:           35208 kB
Writeback:        5616 kB
Mapped:            892 kB
Slab:             7788 kB
CommitLimit:     31260 kB
Committed_AS:     1704 kB
PageTables:         88 kB
VmallocTotal:   933872 kB
VmallocUsed:      9416 kB
VmallocChunk:   923628 kB

Which makes me think that we aren't writing back fast enough.  If I  
mount the drive "sync" the issue clearly goes away.

It appears from an strace we are doing ftruncate64(5, 178257920) when  
we OOM.

Any ideas on VM parameters to tweak so we throttle this from occurring?

- k
