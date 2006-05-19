Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWESSqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWESSqd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWESSqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:46:33 -0400
Received: from citi.umich.edu ([141.211.133.111]:12990 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S964792AbWESSqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:46:33 -0400
Message-ID: <446E1287.4070200@citi.umich.edu>
Date: Fri, 19 May 2006 14:46:31 -0400
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Center for Information Technology Integration
User-Agent: Thunderbird 1.5.0.2 (Macintosh/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: cel@netapp.com, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH 5/6] nfs: check all iov segments for correct memory access
 rights
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>	<20060519180036.3244.70897.stgit@brahms.dsl.sfldmi.ameritech.net> <20060519112231.5ed3d565.akpm@osdl.org>
In-Reply-To: <20060519112231.5ed3d565.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Chuck Lever <cel@netapp.com> wrote:
>> +static ssize_t check_access_ok(int type, const struct iovec *iov, unsigned long nr_segs)
>> +{
>> +	ssize_t count = 0;
>> +	ssize_t retval = -EINVAL;
>> +	unsigned long seg;
>> +
>> +	for (seg = 0; seg < nr_segs; seg++) {
>> +		void __user *buf = iov[seg].iov_base;
>> +		ssize_t len = (ssize_t) iov[seg].iov_len;
>> +
>> +		if (len < 0)		/* size_t not fitting an ssize_t .. */
>> +			goto out;
> 
> do_readv_writev() already checked for negative iov_len, and that's the more
> appropriate place to do it, rather than duplicating it in each filesystem
> (or forgetting to!)
> 
> So is this check really needed?

Ok, didn't see that function before.  Badari, is this checking still needed?

>> +		if (unlikely(!access_ok(type, buf, len))) {
>> +			retval = -EFAULT;
>> +			goto out;
>> +		}
> 
> Now what's up here?  Why does NFS, at this level, care about the page's
> virtual address?  get_user_pages() will handle that?

Interesting point.  That may be a historical artifact that can be 
removed.  I'll take a look.

-- 
corporate:	cel at netapp dot com
personal:	chucklever at bigfoot dot com
