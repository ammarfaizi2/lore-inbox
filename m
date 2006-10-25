Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbWJYQ5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbWJYQ5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 12:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWJYQ5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 12:57:48 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:5627 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S965128AbWJYQ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 12:57:47 -0400
Message-ID: <453F9555.1050201@wolfmountaingroup.com>
Date: Wed, 25 Oct 2006 10:48:21 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nate Diller <nate.diller@gmail.com>
CC: David Howells <dhowells@redhat.com>, sds@tycho.nsa.gov, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Security issues with local filesystem caching
References: <16969.1161771256@redhat.com> <5c49b0ed0610250952i2fcc64b7t47fb7565cada14c6@mail.gmail.com>
In-Reply-To: <5c49b0ed0610250952i2fcc64b7t47fb7565cada14c6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SELinux support addresses all of these issues for B1 level security 
quite well with mandatory access controls
at the fs layers.  In fact, it works so well, when enabled you cannot 
even run apache on top of an FS unless
configured properly. 

Jeff

Nate Diller wrote:

> On 10/25/06, David Howells <dhowells@redhat.com> wrote:
>
>>
>> Hi,
>>
>> Some issues have been raised by Christoph Hellwig over how I'm handling
>> filesystem security in my CacheFiles module, and I'd like advice on 
>> how to deal
>> with them.
>>
>> CacheFiles stores its cache objects as files and directories in a 
>> tree under a
>> directory nominated by the configuration.  This means the data it is 
>> holding
>> (a) is potentially exposed to userspace, and (b) must be labelled for 
>> access
>> control according to the usual filesystem rules.
>>
>> Currently, CacheFiles temporarily changes fsuid and fsgid to 0 whilst 
>> doing its
>> own pathwalk through the cache and whilst creating files and 
>> directories in the
>> cache.  This allows it to deal with DAC security directly.  All the 
>> directories
>> it creates are given permissions mask 0700 and all files 0000.
>>
>> However, Christoph has objected to this practice, and has said that 
>> I'm not
>> allowed to change fsuid and fsgid.  The problem with not doing so is 
>> that this
>> code is running in the context of the process that issued the 
>> original open(),
>> read(), write(), etc, and so any accesses or creations it does would 
>> be done
>> with that process's fsuid and fsgid, which would lead to a cache with 
>> bits that
>> can't be shared between users.
>
>
> I don't really understand the objection here.  Is it likely to cause
> security breaches?  None of the proposed solutions seem particularly
> elegant, so arguing that the current approach is a hack doesn't hold
> much water with me.
>
>> Another thing I'm currently doing is bypassing the usual calls to the 
>> LSM
>> hooks.  This means that I'm not setting and checking security labels 
>> and MACs.
>> The reason for this is again that I'm running in some random 
>> process's context
>> and labelling and MAC'ing will affect the sharability of the cache.  
>> This was
>> objected to also.
>>
>> This also bypasses auditing (I think).  I don't want the CacheFiles 
>> module's
>> access to the cache to be logged against whatever process was 
>> accessing, say,
>> an NFS file.  That process didn't ask to access the cache, and the 
>> cache is
>> meant to be transparent.
>
>
> Christoph, are you objecting to this behavior as well?  This seems
> like the desired outcome.  Do you think there is buggy behavior here,
> or do you just have issues with David's design?  Can you suggest any
> alternatives of your own?
>
> NATE
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

