Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423029AbWJYGB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423029AbWJYGB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 02:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423043AbWJYGB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 02:01:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:13017 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423029AbWJYGB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 02:01:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pLO2OoAETK8/kPAr1OeJjwdqbgBEFuGAf77YONnjflFBYeW/0EKSx/JhgVSoDb+QmsHhZQjAHuro6Kq+cGUl25zp3h5gZZ7YlC3P9VJCeQ+IPVdOW27aAA4y4LZ20Wpt/qUMRA9jpKmakB41MljRpIqwzBvdC8jZX7zpu47JrWE=
Message-ID: <86802c440610242301te23d733g9d73402303c76135@mail.gmail.com>
Date: Tue, 24 Oct 2006 23:01:24 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "David Rientjes" <rientjes@cs.washington.edu>
Subject: Re: [PATCH] x86_64 irq: reset more to default when clear irq_vector for destroy_irq
Cc: "Andi Kleen" <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64N.0610242140140.20151@attu3.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA412D75C@ssvlexmb2.amd.com>
	 <86802c440610242046g6ef06fcexf8776b5009cea23@mail.gmail.com>
	 <Pine.LNX.4.64N.0610242140140.20151@attu3.cs.washington.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cut the code paste the lines from __assign_irq_vector().

It seems we need to change
    if (old_vector >= 0) {
in __assign_irq_vector with this one to
    if (old_vector > 0) {
later.   Eric?

YH




> The two conditionals don't complement each other; in fact, only one
> conditional is required since the test for old_vector equality to zero
> will never be satisfied.  Also note that irq_vectors are u8 on x86_64 and
> not ints.
>
>         static void __clear_irq_vector(int irq)
>         {
>                 u8 old_vector = irq_vector[irq];
>                 if (old_vector > 0) {
>                         cpumask_t old_mask;
>                         int old_cpu;
>                         cpus_and(old_mask, irq_domain[irq], cpu_online_map);
>                         for_each_cpu_mask(old_cpu, old_mask)
>                                 per_cpu(vector_irq, old_cpu)[old_vector] = -1;
>                 }
>                 irq_vector[irq] = 0;
>                 irq_domain[irq] = CPU_MASK_NONE;
>         }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
