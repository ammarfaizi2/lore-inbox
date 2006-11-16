Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424201AbWKPTR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424201AbWKPTR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 14:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424366AbWKPTR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 14:17:26 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:48194 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1424201AbWKPTRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 14:17:25 -0500
Message-ID: <455CB93E.4090309@qumranet.com>
Date: Thu, 16 Nov 2006 21:17:18 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org, uril@qumranet.com
Subject: Re: [kvm-devel] [PATCH 3/3] KVM: Expose MSRs to userspace
References: <455CA70C.9060307@qumranet.com> <20061116180422.0CC9325015E@cleopatra.q> <200611162008.48931.arnd@arndb.de>
In-Reply-To: <200611162008.48931.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2006 19:17:24.0643 (UTC) FILETIME=[D8EB1730:01C709B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Thursday 16 November 2006 19:04, Avi Kivity wrote:
>   
>> +struct kvm_msr_entry {
>> +       __u32 index;
>> +       __u32 reserved;
>> +       __u64 data;
>> +};
>> +
>> +/* for KVM_GET_MSRS and KVM_SET_MSRS */
>> +struct kvm_msrs {
>> +       __u32 vcpu;
>> +       __u32 nmsrs; /* number of msrs in entries */
>> +
>> +       union {
>> +               struct kvm_msr_entry __user *entries;
>> +               __u64 padding;
>> +       };
>> +};
>>     
>
> ioctl interfaces with pointers in them are generally a bad idea,
> though you handle most of the points against them fine here
> (endianess doesn't matter, padding is correct).
>
> Still, it might be better not to set a bad example. Is accessing
> the MSRs actually performance critical? If not, you could
> define the ioctl to take only a single entry argument.
>
>   

But then you can't dynamically determine which MSRs are available.

And no, reading/setting MSRs isn't performance critical for the current 
use cases.

> A possible alternative could also be to have a variable length
> argument like below, but that creates other problems:
>
> +struct kvm_msrs {
> +       __u32 vcpu;
> +       __u32 nmsrs; /* number of msrs in entries */
> +       struct kvm_msr_entry entries[0]; /* followed by actual msrs */
> +};
>
> This would mean that you can't tell the transfer size from the
> ioctl number, but you can't do that in your code either, because
> you do two separate transfers.
>
>   

Heh.  That was the original implementation by Uri.  I felt that was 
wrong because _IOW() encodes the size in the ioctl number, bit the 
actual size is different.


> 	Arnd <><
>   


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

