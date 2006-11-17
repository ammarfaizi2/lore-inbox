Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755530AbWKQHU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbWKQHU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbWKQHU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:20:56 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:16337 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1753182AbWKQHU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:20:56 -0500
Message-ID: <455D62D1.6040203@qumranet.com>
Date: Fri, 17 Nov 2006 09:20:49 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       uril@qumranet.com
Subject: Re: [PATCH 3/3] KVM: Expose MSRs to userspace
References: <455CA70C.9060307@qumranet.com>	<20061116180422.0CC9325015E@cleopatra.q> <20061116170214.b7785bd0.akpm@osdl.org>
In-Reply-To: <20061116170214.b7785bd0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Nov 2006 07:20:55.0400 (UTC) FILETIME=[EBBEEE80:01C70A18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 16 Nov 2006 18:04:22 -0000
> Avi Kivity <avi@qumranet.com> wrote:
>
>   
>> +static int kvm_dev_ioctl_set_msrs(struct kvm *kvm, struct kvm_msrs *msrs)
>> +{
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm_msr_entry *entry, *entries;
>> +	int rc;
>> +	u32 size, num_entries, i;
>> +
>> +	if (msrs->vcpu < 0 || msrs->vcpu >= KVM_MAX_VCPUS)
>> +		return -EINVAL;
>> +
>> +	num_entries = ARRAY_SIZE(msrs_to_save);
>> +	if (msrs->nmsrs < num_entries) {
>> +		msrs->nmsrs = num_entries; /* inform actual size */
>> +		return -EINVAL;
>> +	}
>> +
>> +	vcpu = vcpu_load(kvm, msrs->vcpu);
>> +	if (!vcpu)
>> +		return -ENOENT;
>> +
>> +	size = msrs->nmsrs * sizeof(struct kvm_msr_entry);
>> +	rc = -E2BIG;
>> +	if (size > 4096)
>> +		goto out_vcpu;
>>     
>
> Classic mutiplicative overflow bug.  

Right, will fix.  The 4096 limit is arbitrary anyway, and can be 
replaced by an arbitrary limit on nmsrs.


> Only msrs->nmsrs doesn't get used
> again, so there is no bug here.  Yet.
>
>   

But why isn't it used again?  Looks like the kernel is forcing the user 
to send at least num_entries for no good reason, and ignoring any 
entries beyond num_entries.

>> +	rc = -ENOMEM;
>> +	entries = vmalloc(size);
>> +	if (entries == NULL)
>> +		goto out_vcpu;
>> +
>> +	rc = -EFAULT;
>> +	if (copy_from_user(entries, msrs->entries, size))
>> +		goto out_free;
>> +
>> +	rc = -EINVAL;
>> +	for (i=0; i<num_entries; i++) {
>> +		entry = &entries[i];
>> +		if (set_msr(vcpu, entry->index,  entry->data))
>> +			goto out_free;
>> +	}
>> +
>> +	rc = 0;
>> +out_free:
>> +	vfree(entries);
>> +
>> +out_vcpu:
>> +	vcpu_put(vcpu);
>> +
>> +	return rc;
>> +}
>>     
>
> This function returns no indication of how many msrs it actually did set. 
> Should it?
>   

It can't hurt.  Is returning the number of msrs set in the return code 
(ala short write) acceptable, or do I need to make this a read/write ioctl?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

