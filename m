Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTLOWuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTLOWuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:50:08 -0500
Received: from fmr99.intel.com ([192.55.52.32]:63384 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S264265AbTLOWt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:49:28 -0500
Message-ID: <3FDE3A51.7060802@intel.com>
Date: Tue, 16 Dec 2003 00:48:49 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PCI Express support for 2.4 kernel
References: <12InT-wQ-5@gated-at.bofh.it> <135Nw-5gv-3@gated-at.bofh.it>	<137wc-q1-23@gated-at.bofh.it> <m3fzflpwxs.fsf@averell.firstfloor.org>
In-Reply-To: <m3fzflpwxs.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

My fist intention was exactly same as yours, but if all access were done 
through pci_dev...
Unfortunately, you can't store ioremap()'ed address for 4k within 
pci_dev and then simply use it.
In all places around, config accessed through (bus,dev,fn) indexes.

If you want to keep virt. addr. footprint small, the only alternative to 
fixmap is some kind of LRU cache for dozen of devices.
When choosing between fixmap and LRU cache, I would choose fixmaps. It 
is very simple and clear, low virt. addr. and comparable overhead.

Vladimir.

Andi Kleen wrote:

>Vladimir Kondratiev <vladimir.kondratiev@intel.com> writes:
>  
>
>>As alternative between 1 page and 256M, I see also lazy allocation on
>>per-bus basis: when bus is first accessed, ioremap 1Mb for it. On real
>>system, it is no more then 3-4 buses. This way, we will end with
>>several 1MB mappings. Finer granularity do not looks feasible, since
>>bus scanning procedure tries to access all devices.
>>    
>>
>
>For bus scanning fixmaps are fine, but for the normal use of the
>config space in the driver just doing ioremap once (e.g. at
>pci_enable_device time) and caching it is preferable.  The number of
>PCI-E devices in a given system should be bounded, so e.g. when you
>have 100 devices you will only lose 400kB of vmalloc space this way
>which is quite reasonable.
>
>I don't think dynamic fixmaps at each access would be a good idea.
>
>-Andi
>  
>

