Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWESShE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWESShE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWESShE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:37:04 -0400
Received: from citi.umich.edu ([141.211.133.111]:24657 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S964777AbWESShD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:37:03 -0400
Message-ID: <446E104F.3060900@citi.umich.edu>
Date: Fri, 19 May 2006 14:37:03 -0400
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Center for Information Technology Integration
User-Agent: Thunderbird 1.5.0.2 (Macintosh/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: cel@netapp.com, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 1/6] nfs: "open code" the NFS direct write rescheduler
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>	<20060519180020.3244.75979.stgit@brahms.dsl.sfldmi.ameritech.net> <20060519111054.1842ccfb.akpm@osdl.org>
In-Reply-To: <20060519111054.1842ccfb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Chuck Lever <cel@netapp.com> wrote:
>> +	 * Prevent I/O completion while we're still rescheduling
>> +	 */
>> +	dreq->outstanding++;
>> +
> 
> No locking.
> 
>>  	dreq->count = 0;
>> +	list_for_each(pos, &dreq->rewrite_list) {
>> +		struct nfs_write_data *data =
>> +			list_entry(dreq->rewrite_list.next, struct nfs_write_data, pages);
>> +
>> +		spin_lock(&dreq->lock);
>> +		dreq->outstanding++;
>> +		spin_unlock(&dreq->lock);
> 
> Locking.
> 
> Deliberate?

Yes.  At the top of the loop, there is no outstanding I/O, so no locking 
is needed while updating "outstanding."  Inside the loop, we've 
dispatched some I/O against "dreq" so locking is needed to ensure 
outstanding is updated properly.

-- 
corporate:	cel at netapp dot com
personal:	chucklever at bigfoot dot com
