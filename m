Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTLQUCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 15:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTLQUCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 15:02:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:32242 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264534AbTLQUCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 15:02:08 -0500
Message-ID: <3FE0B9D6.2070902@us.ibm.com>
Date: Wed, 17 Dec 2003 12:17:26 -0800
From: Janet Morgan <janetmor@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel McNeil <daniel@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Suparna Bhattacharya <suparna@in.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
References: <3FCD4B66.8090905@us.ibm.com>	 <1070674185.1929.9.camel@ibm-c.pdx.osdl.net>	 <1070907814.707.2.camel@ibm-c.pdx.osdl.net>	 <1071190292.1937.13.camel@ibm-c.pdx.osdl.net>	 <1071624314.1826.12.camel@ibm-c.pdx.osdl.net>	 <20031216180319.6d9670e4.akpm@osdl.org> <1071689105.1826.46.camel@ibm-c.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil wrote:

>On Tue, 2003-12-16 at 18:03, Andrew Morton wrote:
>
>>Daniel McNeil <daniel@osdl.org> wrote:
>>
>>>I have found something else that might be causing the problem.
>>>filemap_fdatawait() skips pages that are not marked PG_writeback.
>>>However, when a page is going to be written, PG_dirty is cleared
>>>before PG_writeback is set (while the PG_locked is set).  So it
>>>looks like filemap_fdatawait() can see a page just before it is
>>>going to be written and not wait for it.  Here is a patch that
>>>makes filemap_fdatawait() wait for locked pages as well to make
>>>sure it does not missed any pages.
>>>
>>This filemap_fdatawait() behaviour is as-designed.  That function is only
>>responsible for waiting on I/O which was initiated prior to it being
>>invoked.  Because it is designed for fsync(), fdatasync(), O_SYNC, msync(),
>>sync(), etc.
>>
>>Now, it could be that this behaviour is not appropriate for the O_DIRECT
>>sync function - the result of your testing will be interesting.
>>
>
>My tests still failed overnight.  I was thinking that maybe a
>non-blocking do_writepages() was happening at the same time as
>the filemap_fdatawrite()/filemap_fdatawait(), so even though the
>page was dirty before the filemap_fdatawrite(), it was missed.
>
>Daniel
>
>
I'm wondering if processing in generic_file_direct_IO() shouldn't look 
more like
sys_fsync()?  When I add to generic_file_direct_IO() a call to 
f_op->fsync() between the calls to filemap_fdatawrite() and 
filemap_fdatawait(), the test Daniel and I have been running no longer 
fails for me.  This change would also seem consistent with 2.4, but I 
could be way off base.

-Janet

