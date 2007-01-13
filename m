Return-Path: <linux-kernel-owner+w=401wt.eu-S1161304AbXAMHW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161304AbXAMHW3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 02:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161303AbXAMHW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 02:22:29 -0500
Received: from 1wt.eu ([62.212.114.60]:1932 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161304AbXAMHW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 02:22:28 -0500
Date: Sat, 13 Jan 2007 08:22:18 +0100
From: Willy Tarreau <w@1wt.eu>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: tuning/tweaking VM settings for low memory (preventing OOM)
Message-ID: <20070113072217.GW24090@1wt.eu>
References: <D7BBB18A-F5D4-4FE0-903F-3683333D957C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7BBB18A-F5D4-4FE0-903F-3683333D957C@kernel.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 03:58:08PM -0600, Kumar Gala wrote:
> I'm working on an embedded PPC setup with 64M of memory and no swap.   
> I'm trying to figure out how best to tune the VM for an OOM situation  
> I'm running into.
> 
> I'm running a 2.6.16.35 kernel and have a bittorrent app that appears  
> to be initializing a large file for it to download into.  What I see  
> before running the app:
> 
> /bigfoot/usb_disk # cat /proc/meminfo
> MemTotal:        62520 kB
> MemFree:         49192 kB
> Buffers:          8240 kB
> Cached:            740 kB
> SwapCached:          0 kB
> Active:           8196 kB
> Inactive:         1236 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:        62520 kB
> LowFree:         49192 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> Dirty:               0 kB
> Writeback:           0 kB
> Mapped:            916 kB
> Slab:             2224 kB
> CommitLimit:     31260 kB
> Committed_AS:     1704 kB
> PageTables:         88 kB
> VmallocTotal:   933872 kB
> VmallocUsed:      9416 kB
> VmallocChunk:   923628 kB
> 
> after the OOM:
> 
> /bigfoot/usb_disk # cat /proc/meminfo
> MemTotal:        62520 kB
> MemFree:          1608 kB
> Buffers:          8212 kB
> Cached:          42780 kB
> SwapCached:          0 kB
> Active:           6228 kB
> Inactive:        45176 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:        62520 kB
> LowFree:          1608 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> Dirty:           35208 kB
> Writeback:        5616 kB
> Mapped:            892 kB
> Slab:             7788 kB
> CommitLimit:     31260 kB
> Committed_AS:     1704 kB
> PageTables:         88 kB
> VmallocTotal:   933872 kB
> VmallocUsed:      9416 kB
> VmallocChunk:   923628 kB
> 
> Which makes me think that we aren't writing back fast enough.  If I  
> mount the drive "sync" the issue clearly goes away.
> 
> It appears from an strace we are doing ftruncate64(5, 178257920) when  
> we OOM.
> 
> Any ideas on VM parameters to tweak so we throttle this from occurring?

Take a look at /proc/sys/vm/bdflush. There are several useful parameters
there (doc is in linux-xxx/Documentation). For instance, the first column
is the percentage of memory used by writes before starting to write on
disk. When using tcpdump intensively, I lower this one to about 1%.

Willy

