Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWJLVz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWJLVz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWJLVz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:55:26 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:8069 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751120AbWJLVzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:55:25 -0400
Message-ID: <452EB9C5.4000404@us.ibm.com>
Date: Thu, 12 Oct 2006 14:55:17 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Eric Sandeen <esandeen@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
       Eric Sandeen <sandeen@sandeen.net>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
References: <20061009225036.GC26728@redhat.com>	<20061010141145.GM23622@atrey.karlin.mff.cuni.cz>	<452C18A6.3070607@redhat.com>	<1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com>	<452C4C47.2000107@sandeen.net>	<20061011103325.GC6865@atrey.karlin.mff.cuni.cz>	<452CF523.5090708@sandeen.net>	<20061011142205.GB24508@atrey.karlin.mff.cuni.cz>	<1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com>	<452DAA26.6080200@redhat.com>	<20061012122820.GK9495@atrey.karlin.mff.cuni.cz> <20061012094036.e1a3f9f1.akpm@osdl.org> <452EA06F.4060701@redhat.com>
In-Reply-To: <452EA06F.4060701@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:
> Andrew Morton wrote:
>
>   
>> On Thu, 12 Oct 2006 14:28:20 +0200
>> Jan Kara <jack@suse.cz> wrote:
>>
>>   
>>     
>>> Where can we call
>>> journal_dirty_data() without PageLock?
>>>     
>>>       
>> block_write_full_page() will unlock the page, so ext3_writepage()
>> will run journal_dirty_data_fn() against an unlocked page.
>>
>> I haven't looked into the exact details of the race, but it should
>> be addressable via jbd_lock_bh_state() or j_list_lock coverage
>>     
> I'm testing with something like this now; seem sane?
>
> journal_dirty_data & journal_unmap_data both check do 
> jbd_lock_bh_state(bh) close to the top... journal_dirty_data_fn has checked 
> buffer_mapped before getting into journal_dirty_data, but that state may
> change before the lock is grabbed.  Similarly re-check after we drop the lock.
>
>   
This is exactly  the solution I proposed earlier (to check 
buffer_mapped() before calling submit_bh()).
But at that time, Jan pointed out that the whole handling is wrong.

But if this is the only case we need to handle, I am okay with this band 
aid :)

Thanks,
Badari

