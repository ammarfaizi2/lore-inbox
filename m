Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424830AbWKQBCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424830AbWKQBCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424845AbWKQBCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:02:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424830AbWKQBCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:02:21 -0500
Date: Thu, 16 Nov 2006 17:02:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       uril@qumranet.com
Subject: Re: [PATCH 3/3] KVM: Expose MSRs to userspace
Message-Id: <20061116170214.b7785bd0.akpm@osdl.org>
In-Reply-To: <20061116180422.0CC9325015E@cleopatra.q>
References: <455CA70C.9060307@qumranet.com>
	<20061116180422.0CC9325015E@cleopatra.q>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 18:04:22 -0000
Avi Kivity <avi@qumranet.com> wrote:

> +static int kvm_dev_ioctl_set_msrs(struct kvm *kvm, struct kvm_msrs *msrs)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_msr_entry *entry, *entries;
> +	int rc;
> +	u32 size, num_entries, i;
> +
> +	if (msrs->vcpu < 0 || msrs->vcpu >= KVM_MAX_VCPUS)
> +		return -EINVAL;
> +
> +	num_entries = ARRAY_SIZE(msrs_to_save);
> +	if (msrs->nmsrs < num_entries) {
> +		msrs->nmsrs = num_entries; /* inform actual size */
> +		return -EINVAL;
> +	}
> +
> +	vcpu = vcpu_load(kvm, msrs->vcpu);
> +	if (!vcpu)
> +		return -ENOENT;
> +
> +	size = msrs->nmsrs * sizeof(struct kvm_msr_entry);
> +	rc = -E2BIG;
> +	if (size > 4096)
> +		goto out_vcpu;

Classic mutiplicative overflow bug.  Only msrs->nmsrs doesn't get used
again, so there is no bug here.  Yet.

> +	rc = -ENOMEM;
> +	entries = vmalloc(size);
> +	if (entries == NULL)
> +		goto out_vcpu;
> +
> +	rc = -EFAULT;
> +	if (copy_from_user(entries, msrs->entries, size))
> +		goto out_free;
> +
> +	rc = -EINVAL;
> +	for (i=0; i<num_entries; i++) {
> +		entry = &entries[i];
> +		if (set_msr(vcpu, entry->index,  entry->data))
> +			goto out_free;
> +	}
> +
> +	rc = 0;
> +out_free:
> +	vfree(entries);
> +
> +out_vcpu:
> +	vcpu_put(vcpu);
> +
> +	return rc;
> +}

This function returns no indication of how many msrs it actually did set. 
Should it?
