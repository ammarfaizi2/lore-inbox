Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937320AbWLDTSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937320AbWLDTSm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937321AbWLDTSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:18:42 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:33656 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937320AbWLDTSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:18:41 -0500
In-Reply-To: <000001c717c0$f82b5ea0$2589030a@amr.corp.intel.com>
References: <000001c717c0$f82b5ea0$2589030a@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <28F99581-3A2A-45BD-8F00-B554313E2C26@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] remove redundant iov segment check
Date: Mon, 4 Dec 2006 11:18:44 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 4, 2006, at 8:26 AM, Chen, Kenneth W wrote:

> The access_ok() and negative length check on each iov segment in  
> function
> generic_file_aio_read/write are redundant.  They are all already  
> checked
> before calling down to these low level generic functions.

...

> So it's not possible to call down to generic_file_aio_read/write  
> with invalid
> iov segment.

Well, generic_file_aio_{read,write}() are exported to modules, so  
anything's *possible*. :)

This change makes me nervous because it relies on our ability to  
audit all code paths to ensure that it's correct.  It'd be nice if  
the code enforced the rules.

I wonder if it wouldn't be better to make this change as part of a  
larger change that moves towards an explicit iovec container struct  
rather than bare 'struct iov *' and 'nr_segs' arguments.  The struct  
could have a flag that expressed whether the elements had been  
checked.  A helper could be called by the upper and lower code paths  
which does the checking, marks the flag, and avoids checking again if  
the flag is set.

We've wanted an explicit struct in the past to avoid the multiple  
walks of iovecs that various paths do for their own reasons.  The  
iovec walk that is checking for length wrapping could also be  
building a bitmap of length alignment that O_DIRECT could be using to  
test 512B alignment without having to walk the iovec again.

I started on such a patch set at some point in the murky past.  It  
got kind of gross when it got to paths that want to modify the iovec  
in place.  It's all doable, it'll just take some work.  Christoph and  
I have discussed it in the past, I wonder if he has any thing like  
this going.

- z
