Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVA0SZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVA0SZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVA0SZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:25:51 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:57740 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262694AbVA0SZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:25:14 -0500
Message-ID: <41F932D7.6040409@tmr.com>
Date: Thu, 27 Jan 2005 13:28:39 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mitch Williams <mitch.a.williams@intel.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] buffer writes to sysfs
References: <20050124213906.GE18933@kroah.com><Pine.CYG.4.58.0501211449410.3364@mawilli1-desk2.amr.corp.intel.com> <Pine.CYG.4.58.0501251519390.2388@mawilli1-desk2.amr.corp.intel.com>
In-Reply-To: <Pine.CYG.4.58.0501251519390.2388@mawilli1-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitch Williams wrote:
> 
> On Mon, 24 Jan 2005, Greg KH wrote:
> 
>>Who is trying to send > 1K to a sysfs file?  Remember, sysfs files are
>>for 1 value only.  If you consider > 1K a "single value" please point me
>>to that part of the kernel that does that.
>>
>>
>>>To the typical user, there's really no difference in behavior, unless
>>
>>you
>>
>>>are writing a ton of data into the file.  Of course, there's the
>>
>>obvious
>>
>>>question of why you'd want to do so...
>>
>>Exactly, you should not be doing that anyway.  So, because of that, I
>>really don't want/like this patch.
> 
> 
> 
> OK, I've had a day to think about this, and I think I have a good answer
> now.
> 
> Leaving aside the issue of how big a 'single object' is, we still have to
> consider the possibility that a user _will_ indeed someday try to write 4K
> (or more) to a sysfs file.  It's just going to happen.  And right now, the
> kernel's behavior in that event is unpredictable, because we don't know
> how the c library is going to buffer this write.
> 
> Right now, on my FC3 box, writing a large amount of data to a sysfs file
> results in multiple writes of 1K to the file.  What my store method sees
> then is multiple calls, each with 1K of data.  Each time, I have to assume
> what I see is the complete contents of the write, and I have to process it
> as such.
> 
> So if my sysfs file contains FOO, and the user writes BAR followed by 3k
> of garbage, I'm not going to end up with FOO, or even BAR, but I'll end up
> with whatever garbage I see at the beginning of the third 1K write.
> 
> The real problem is not that I get wrong values -- my store method should
> handle this -- but that there are no errors returned from this operation.
> The only way the user can tell that something is wrong is if a) I write a
> message to the log telling what I did in my store method, and b) the user
> checks the log.
> 
> My original write buffering patch fixes this problem, and allows up to 4K
> to be consolidated into a single call to the store method.  It doesn't
> seem to affect normal operation of my test system (nor those in our test
> lab), but does hide error code returns from store methods.  And I can see
> why you would be disinclined to accept such a patch.
> 
> While we may want to consider the possibility that a 'single object' may
> someday grow large (crypto key maybe?), I can live without write buffering
> right now.
> 
> But at the very least, we still need to handle this failure case.   I've
> tested the following patch and it does resolve the issue.  However, it now
> limits the size of sysfs writes to the size of the c library's buffer.
> 
> --------------------
> 
> This patch returns an error code if the user trys to write data to a sysfs
> file at any offset other than 0.

Clearly if it doesn't work it should return an error, if there's no 
(current) need to have this work then adding code to make it work is 
probably not justified.

> 
> Signed-off-by:  Mitch Williams <mitch.a.williams@intel.com>
> 
> diff -urpN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
> --- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
> +++ linux-2.6.11/fs/sysfs/file.c	2005-01-25 10:47:15.000000000 -0800
> @@ -232,6 +232,8 @@ sysfs_write_file(struct file *file, cons
>  {
>  	struct sysfs_buffer * buffer = file->private_data;
> 
> +        if (*ppos > 0)
> +            return -EIO;
>  	down(&buffer->sem);
>  	count = fill_write_buffer(buffer,buf,count);
>  	if (count > 0)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
