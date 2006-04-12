Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWDLPry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWDLPry (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 11:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWDLPry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 11:47:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36757 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750909AbWDLPry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 11:47:54 -0400
To: vgoyal@in.ibm.com
Cc: Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] Kexec: Common alloc
References: <20060412083402.25911.56088.sendpatchset@cherry.local>
	<20060412141838.GA5550@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 12 Apr 2006 09:46:16 -0600
In-Reply-To: <20060412141838.GA5550@in.ibm.com> (Vivek Goyal's message of
 "Wed, 12 Apr 2006 10:18:38 -0400")
Message-ID: <m1acaq94qf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Wed, Apr 12, 2006 at 05:33:02PM +0900, Magnus Damm wrote:
>> Kexec: Common alloc
>> 
>> This patch reduces code redundancy by introducing a new function called
>> kimage_common_alloc() which is used to set up image->control_code_page.
>> 
>> Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
>> ---
>> 
>> Applies on top of linux-2.6.17-rc1-git5 + "Kexec: Remove duplicate rimage"
>> 
>>  kexec.c |   51 ++++++++++++++++++++-------------------------------
>>  1 files changed, 20 insertions(+), 31 deletions(-)
>> 
>> --- 0004/kernel/kexec.c
>> +++ work/kernel/kexec.c	2006-04-12 16:30:34.000000000 +0900
>> @@ -205,34 +205,36 @@ out:
>>  
>>  }
>>  
>> -static int kimage_normal_alloc(struct kimage **rimage, unsigned long entry,
>> -				unsigned long nr_segments,
>> -				struct kexec_segment __user *segments)
>> +static int kimage_common_alloc(struct kimage *image)
>>  {
>> -	int result;
>> -	struct kimage *image;
>> -
>> -	/* Allocate and initialize a controlling structure */
>> -	image = NULL;
>> -	result = do_kimage_alloc(&image, entry, nr_segments, segments);
>> -	if (result)
>> -		goto out;
>> -
>>  	/*
>> -	 * Find a location for the control code buffer, and add it
>> +	 * Find a location for the control code buffer, and add
>>  	 * the vector of segments so that it's pages will also be
>>  	 * counted as destination pages.
>>  	 */
>> -	result = -ENOMEM;
>>  	image->control_code_page = kimage_alloc_control_pages(image,
>>  					   get_order(KEXEC_CONTROL_CODE_SIZE));
>>  	if (!image->control_code_page) {
>>  		printk(KERN_ERR "Could not allocate control_code_buffer\n");
>> -		goto out;
>> +		return -ENOMEM;
>
> Ok. So effectively call to the the function kimage_alloc_control_pages() and
> its return code handling is being wrapped in another function. This function
> is called at only two places. Not quite convinced that this duplication is
> significant enough that we introduce another function to wrap a function
> call.

Agreed.

Eric

