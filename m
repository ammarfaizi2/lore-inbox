Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTJWKn4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 06:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbTJWKn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 06:43:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:33941 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263528AbTJWKnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 06:43:53 -0400
Date: Thu, 23 Oct 2003 16:19:23 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIO testing on 2.6.0-test7-mm1)
Message-ID: <20031023104923.GA11543@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net> <20031020142727.GA4068@in.ibm.com> <1066693673.22983.10.camel@ibm-c.pdx.osdl.net> <20031021121113.GA4282@in.ibm.com> <1066869631.1963.46.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066869631.1963.46.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 05:40:32PM -0700, Daniel McNeil wrote:
> Suparna and Andrew,
> 
> I've been doing more testing using the test programs I wrote to 
> try and hit the AIO verses buffered read race conditions.
> 
> I tested 2.6.0-test8, 2.6.0-test8-mm1+(your first incomplete fix) and
> 2.6.0-test8-mm1+aio-dio-retry patch.  I used my test programs
> (http://developer.osdl.org/daniel/AIO/TESTS/) by doing:
> 
> Run "dirty" program which allocates and writes 0xaa to a file and then
> 	frees the space.
> Run "dio_sparse" or "aiodio-sparse - which creates "file", truncates it
> 	up to 64MB and then writes zeros into the holes (using DIO or
> 	AIO+DIO).  At same time, a forked child is reading the file
> 	looking for non-zero data.
> rm "file"
> 
> On 2.6.0-test8
> ==============
> I hit the race condition and see uninitialized data:
> ~/AIO/TESTS/dio_sparse
> non zero buffer at buf[4] => 0xaaaaaaaa,aaaaaaaa,aaaaaaaa,aaaaaaaa
> non-zero read at offset 24182785
> 
>  ~/AIO/TESTS/aiodio_sparse
> non zero buffer at buf[4] -> 0xaaaaaaaa,aaaaaaaa,aaaaaaaa,aaaaaaaa
> non-zero read at offset 8323062
> 
> 
> On 2.6.0-test8-mm1+1st-direct-io-aio_complete patch and
>    2.6.0-test8-mm1+aio-dio-retry patch
> 
> I never see uninitialized data.

That's good news.

You seem to be able to run test8-mm1 just fine; I have been
running into strange oops on syscall return for io_getevents :(
- haven't seen this before.
What library and header files are you using for libaio ? Do you have
4G-4G turned on in your build ?

> 
> Reading over your description and looking over the code, I'm pretty
> sure I see the races you are talking about but had some questions:
> 
> 1) DIO file extends.  So are you saying that in direct_io_worker()
>    we were dropping i_sem and then waiting for the i/o to complete,
>    but since i_sem was dropped there could be another write exposing
>    the uninitialized data still in process of being written?
>    
>    If yes, then wouldn't the intermediate write be responsible for
>    zeroing all data between the last isize and the new isize?

I think it would have to initialize all the data involved in the 
write but could just leave a hole from the last isize to the 
start of this write. It doesn't expect uninstantiated blocks to 
exist in that hole, so shouldn't have to worry about zeroing 
them.

> 
> 2) aio-dio extends
> 
>    Are you saying that in __generic_file_aio_write_nolock()
>    that generic_file_direct_IO() returns the number of bytes
>    that are being AIO written but not complete and we were updating
>    i_size write after that?  (just trying to understand the code).

Yes. And that leaving uninitialised data exposed.

Regards
Suparna

-
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

