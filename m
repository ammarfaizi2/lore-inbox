Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424365AbWKPTJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424365AbWKPTJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 14:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424366AbWKPTJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 14:09:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:9681 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1424365AbWKPTJD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 14:09:03 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: kvm-devel@lists.sourceforge.net
Subject: Re: [kvm-devel] [PATCH 3/3] KVM: Expose MSRs to userspace
Date: Thu, 16 Nov 2006 20:08:48 +0100
User-Agent: KMail/1.9.5
Cc: Avi Kivity <avi@qumranet.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       uril@qumranet.com
References: <455CA70C.9060307@qumranet.com> <20061116180422.0CC9325015E@cleopatra.q>
In-Reply-To: <20061116180422.0CC9325015E@cleopatra.q>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611162008.48931.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 19:04, Avi Kivity wrote:
> +struct kvm_msr_entry {
> +       __u32 index;
> +       __u32 reserved;
> +       __u64 data;
> +};
> +
> +/* for KVM_GET_MSRS and KVM_SET_MSRS */
> +struct kvm_msrs {
> +       __u32 vcpu;
> +       __u32 nmsrs; /* number of msrs in entries */
> +
> +       union {
> +               struct kvm_msr_entry __user *entries;
> +               __u64 padding;
> +       };
> +};

ioctl interfaces with pointers in them are generally a bad idea,
though you handle most of the points against them fine here
(endianess doesn't matter, padding is correct).

Still, it might be better not to set a bad example. Is accessing
the MSRs actually performance critical? If not, you could
define the ioctl to take only a single entry argument.

A possible alternative could also be to have a variable length
argument like below, but that creates other problems:

+struct kvm_msrs {
+       __u32 vcpu;
+       __u32 nmsrs; /* number of msrs in entries */
+       struct kvm_msr_entry entries[0]; /* followed by actual msrs */
+};

This would mean that you can't tell the transfer size from the
ioctl number, but you can't do that in your code either, because
you do two separate transfers.

	Arnd <><
