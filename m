Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWGKGtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWGKGtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbWGKGtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:49:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:19691 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965080AbWGKGtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:49:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=lqHCBFbS67x1KJQ1vWkZT/4yPi4voTR2jugpOz122PEcgm1huXAGbnoJia4bjDpQ7sK+O7n0qqYb9JWkoYHsUUsx88UpjtW0M/zMDQJcxCXm1QiWSdV8oFqbvWbWbewv7DNR1WwsE+wAZBUITmX2QXpobWOG4J3HVg0Z3QnE+pA=
Message-ID: <84144f020607102349u62a59b26va0cec06c6d15e178@mail.gmail.com>
Date: Tue, 11 Jul 2006 09:49:47 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 07/10] Remove some of the kmemleak false positives
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060710221037.5191.75356.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <20060710221037.5191.75356.stgit@localhost.localdomain>
X-Google-Sender-Auth: 5261c00933d85f4b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> @@ -166,6 +166,9 @@ struct platform_device *platform_device_
>         struct platform_object *pa;
>
>         pa = kzalloc(sizeof(struct platform_object) + strlen(name), GFP_KERNEL);
> +       /* kmemleak cannot guess the object type because the block
> +        * size is different from the object size */
> +       memleak_typeid(pa, struct platform_object);

AFAICT, we about 300 kmalloc and kzalloc calls in the kernel that
would need this annotation. If we really can't fix the detector to
deal with these, I would prefer we introduce another memory allocator
function such as:

    void *kzalloc_extra(size_t obj_size, size_t nr_extra, gfp_t flags);

That would do the right thing for memleak too.

                                     Pekka
