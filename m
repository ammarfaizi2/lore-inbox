Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266326AbUBEC4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 21:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266431AbUBEC4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 21:56:35 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41401 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266326AbUBEC4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 21:56:24 -0500
Message-ID: <4021B07E.8030700@us.ibm.com>
Date: Wed, 04 Feb 2004 18:54:54 -0800
From: Janet Morgan <janetmor@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Daniel McNeil <daniel@osdl.org>, pbadari@us.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: Re: [PATCH 2.6.2-rc3-mm1] DIO read race fix
References: <3FCD4B66.8090905@us.ibm.com>	<1070674185.1929.9.camel@ibm-c.pdx.osdl.net>	<1070907814.707.2.camel@ibm-c.pdx.osdl.net>	<1071190292.1937.13.camel@ibm-c.pdx.osdl.net>	<20031230045334.GA3484@in.ibm.com>	<1072830557.712.49.camel@ibm-c.pdx.osdl.net>	<20031231060956.GB3285@in.ibm.com>	<1073606144.1831.9.camel@ibm-c.pdx.osdl.net>	<20040109035510.GA3279@in.ibm.com>	<1075945198.7182.46.camel@ibm-c.pdx.osdl.net> <20040204180754.28801410.akpm@osdl.org>
In-Reply-To: <20040204180754.28801410.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Daniel McNeil <daniel@osdl.org> wrote:
>  
>
>>I have found (finally) the problem causing DIO reads racing with
>>buffered writes to see uninitialized data on ext3 file systems 
>>(which is what I have been testing on).
>>    
>>
>
>What kernel?  If -mm, is this the only remaining buffered-vs-direct
>problem?
>
>  
>
I think there was consensus on two other patches along the way:

    http://marc.theaimsgroup.com/?l=linux-kernel&m=107286971311559&w=2
    http://marc.theaimsgroup.com/?l=linux-aio&m=107291089712224&w=2

-Janet

>>The problem is caused by the changes to __block_write_page_full()
>>and a race with journaling:
>>
>>journal_commit_transaction() -> ll_rw_block() -> submit_bh()
>>	
>>ll_rw_block() locks the buffer, clears buffer dirty and calls
>>submit_bh()
>>
>>A racing __block_write_full_page() (from ext3_ordered_writepage())
>>
>>	would see that buffer_dirty() is not set because the i/o
>>        is still in flight, so it would not do a bh_submit()
>>
>>	It would SetPageWriteback() and unlock_page() and then
>>	see that no i/o was submitted and call end_page_writeback()
>>	(with the i/o still in flight).
>>
>>This would allow the DIO code to issue the DIO read while buffer writes
>>are still in flight.  The i/o can be reordered by i/o scheduling and
>>the DIO can complete BEFORE the writebacks complete.  Thus the DIO
>>sees the old uninitialized data.
>>    
>>
>
>ow.  How'd you work this out?
>
>  
>
>>Here is a quick hack that fixes it, but I am not sure if this the
>>proper long term fix.
>>    
>>
>
>The problem is that ext3 and the VFS are using different paradigms.  VFS is
>all page-based, but ext3 is all block-based.  One or the other needs to do
>something nasty.
>
>One approach would be to change the JBD write_out_data_locked loop to use
>block_write_full_page(bh->b_page) instead of buffer_head operations.  But
>that could get hairy with blocksize < PAGE_SIZE.
>
>Thanks for working this out.  Let me ponder it for a bit.
>
>  
>


