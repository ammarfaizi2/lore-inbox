Return-Path: <linux-kernel-owner+w=401wt.eu-S1422641AbXAER0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbXAER0Q (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbXAER0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:26:15 -0500
Received: from mailgw4.ericsson.se ([193.180.251.62]:33770 "EHLO
	mailgw4.ericsson.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422640AbXAER0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:26:14 -0500
Message-ID: <459E896C.4050309@ericsson.com>
Date: Fri, 05 Jan 2007 17:22:52 +0000
From: Jon Maloy <jon.maloy@ericsson.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jarek Poplawski <jarkao2@o2.pl>
CC: Eric Sesterhenn <snakebyte@gmx.de>, Per Liden <per.liden@ericsson.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "'tipc-discussion@lists.sourceforge.net'" 
	<tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH] tipc: checking returns and Re: Possible Circular Locking
 in TIPC
References: <20061228121702.GA5076@ff.dom.local> <459C396B.1090508@ericsson.com> <20070104122843.GC3175@ff.dom.local> <459D2854.1000405@ericsson.com> <20070105075857.GB1675@ff.dom.local>
In-Reply-To: <20070105075857.GB1675@ff.dom.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2007 17:23:26.0116 (UTC) FILETIME=[357E2E40:01C730EE]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jarek Poplawski wrote:

>
>If you are sure there is no circular locking possible
>between these two functions and this entry->lock here
>isn't endangered by other functions, you could try to
>make lockdep "silent" like this: 
>
>
>        write_lock_bh(&ref_table_lock);
>        if (tipc_ref_table.first_free) {
>                index = tipc_ref_table.first_free;
>                entry = &(tipc_ref_table.entries[index]);
>                index_mask = tipc_ref_table.index_mask;
>                /* take lock in case a previous user of entry still holds it */
>
>-                spin_lock_bh(&entry->lock, );
>+		local_bh_disable();
>+		spin_lock_nested(&entry->lock, SINGLE_DEPTH_NESTING);
>
>                next_plus_upper = entry->data.next_plus_upper;
>                tipc_ref_table.first_free = next_plus_upper & index_mask;
>                reference = (next_plus_upper & ~index_mask) + index;
>                entry->data.reference = reference;
>                entry->object = object;
>                if (lock != 0)
>                        *lock = &entry->lock;
>
>/* may stay as is or: */
>-                spin_unlock_bh(&entry->lock);
>+		spin_unlock(&entry->lock);
>+		local_bh_enable();
>
>        }
>        write_unlock_bh(&ref_table_lock);
>
>
>  
>
Looks like an acceptable solution. I will try this.
Thanks
///Jon

