Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422933AbWBOBGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422933AbWBOBGc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 20:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422932AbWBOBGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 20:06:32 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:4508 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422929AbWBOBGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 20:06:31 -0500
Message-ID: <43F27E9F.9030005@jp.fujitsu.com>
Date: Wed, 15 Feb 2006 10:06:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Yasunori Goto <y-goto@jp.fujitsu.com>
CC: Dave Hansen <haveblue@us.ibm.com>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [RFC/PATCH: 002/010] Memory hotplug for new nodes
 with pgdat allocation. (Wait table and zonelists initalization)
References: <20060211125941.D35C.Y-GOTO@jp.fujitsu.com> <43EDC35B.5060106@jp.fujitsu.com> <20060214221413.ECF3.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20060214221413.ECF3.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto wrote:
> +	if (system_state == SYSTEM_RUNNING){
> +		unsigned long queue_head_size = 1;
> +		while (queue_head_size < sizeof(wait_queue_head_t))
> +		       queue_head_size <<= 1;
> +
> +		pages = (1 << (PAGE_SHIFT + 3)) / queue_head_size;
> +	}
> +
we have to kmalloc() wait_table after this.
I don't think we always succeed to alloc multiple contiguous pages by kmalloc().
How about allocating wait_table like this ?
==
size = 4096; /* 4096 is maximum size */
while(size) {
	waittable = kmalloc(size * sizeof(wait_queue_head_t), GFP_KERNEL):
	if (wait_table)
		break;
	size = size >> 1;
}
zone->wait_table_size = size;
zone->wait_table_bits = wait_table_bits(zone->wait_table_size);
zone->wait_table = wait_table;
==


-- Kame



