Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933793AbWKYAJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933793AbWKYAJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 19:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935014AbWKYAJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 19:09:14 -0500
Received: from smtp-out.google.com ([216.239.45.12]:22375 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S933793AbWKYAJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 19:09:13 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=GJ8rAHSPD6BEYJzQvPNN4/XB3KKJLDQ3XZ1JKJmrd/mTYpECAtuXlUC9FkdBhgDmt
	+zXolJi2LYsLeYLRMLzdA==
Message-ID: <6599ad830611241609r24384d97ic6920f94bc735334@mail.gmail.com>
Date: Fri, 24 Nov 2006 16:09:03 -0800
From: "Paul Menage" <menage@google.com>
To: "Pavel Emelianov" <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 4/13] BC: context handling
Cc: "Kirill Korotaev" <dev@sw.ru>, "Andrew Morton" <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       matthltc@us.ibm.com, hch@infradead.org,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, oleg@tv-sign.ru,
       devel@openvz.org
In-Reply-To: <4566C519.1090902@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C18.4040000@sw.ru> <45535E11.20207@sw.ru>
	 <6599ad830611222348o1203357tea64fff91edca4f3@mail.gmail.com>
	 <45655D3E.5020702@openvz.org>
	 <6599ad830611230053m7182698cu897abe5d19471aff@mail.gmail.com>
	 <456567DD.6090703@openvz.org>
	 <6599ad830611230131w1bf63dc1m1998b55b61579509@mail.gmail.com>
	 <45657030.7050009@openvz.org>
	 <6599ad830611230218w7a6c0c0el9479b497037b0be6@mail.gmail.com>
	 <4566C519.1090902@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/06, Pavel Emelianov <xemul@openvz.org> wrote:
> I've got it! That's what will work:
>
> struct task_struct {
>         ...
>         struct beancounter *exec_bc;
>         struct beancounter *tmp_exec_bc; /* is set to NULL on
>                                           * tsk creation
>                                           */
> };
>
> struct beancounter get_exec_bc(void)
> {
>         if (current->tmp_exec_bc)
>                 return current->tmp_exec_bc;
>         return rcu_dereference(current->exec_bc);
> }

Don't forget that this means all callers need to be in an
rcu_read_lock() section.

>
> I will implement this in the next beancounter patches.

This is looking remarkably like the mechanism in use for my generic
containers patches (inherited from Paul Jackson's cpusets code). In
the last set of patches that I posted on Wednesday night, I included
the example of the beancounters core and numfiles counter implemented
on top of the generic containers - basically pulling out the hash
table, refcounting and most of the configfs code (since that's handled
by the generic containers), and moving the attribute management
configfs code to the use the containerfs filesystem interface instead.
The rest is pretty much unchanged.

I think you could continue to use the tmp_exec_bc idea with this, and
have get_exec_bc() use the tmp_exec_bc if it existed, or else get the
bc pointer via the container system.

I'd appreciate any feedback you had on that approach.

Paul
