Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268686AbUJPInL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268686AbUJPInL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 04:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUJPInL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 04:43:11 -0400
Received: from services.exanet.com ([212.143.73.102]:40610 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S268686AbUJPInH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 04:43:07 -0400
Message-ID: <4170DF18.50004@exanet.com>
Date: Sat, 16 Oct 2004 10:43:04 +0200
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040930
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <jlbec@evilplan.org>
CC: Yasushi Saito <ysaito@hpl.hp.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       Janet Morgan <janetmor@us.ibm.com>
Subject: Re: [PATCH 1/2]  aio: add vectored I/O support
References: <416EDD19.3010200@hpl.hp.com> <20041016031301.GC17142@parcelfarce.linux.theplanet.co.uk> <4170AF35.7030806@exanet.com> <20041016053721.GD17142@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041016053721.GD17142@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2004 08:43:06.0093 (UTC) FILETIME=[27E579D0:01C4B35C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:

>On Sat, Oct 16, 2004 at 07:18:45AM +0200, Avi Kivity wrote:
>  
>
>>It is a huge performance win, at least on the 2.4-based RHEL kernel. 
>>Large reads (~256K) using 4K iocbs are very slow on a large RAID, while 
>>after I coded a similar patch I got a substantial speedup.
>>    
>>
>
>	I'd think we should fix the submission path instead.  Why create
>iovs _and_ iocbs when we only need to create one?  And even if we
>decided aio_readv() was still nice to keep, we'd want to fix this
>inefficiency in io_submit().
>
>  
>
Using IO_CMD_READ for a vector entails

- converting the userspace structure (which might well an iovec) to iocbs
- copying all those iocbs to the kernel
- merging the iocbs
- generating multiple completions for the merged request
- copying the completions to userspace
- coalescing the multiple completions in userspace to a single completion

error handling is difficult as well. one would expect that a bad sector 
with multiple iocbs would only fail one of the requests. it seems to be 
non-trivial to implement this correctly.

IO_CMD_PREADV, by contrast, is very simple, intuitive, and efficient.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

