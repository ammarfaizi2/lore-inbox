Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbVD3Abx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbVD3Abx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbVD3Abw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:31:52 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:41439 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263089AbVD3Abo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:31:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OkSRVz7TfGs+5tCkyDhABz5PKPwoLGKk5ftKEnSTXMt/2u6ob1342HzWvCZ4sfJ7ItYre8iQzNappyO/hQdfYe4eV3M5/wT6vFHFtO5wQG93TdcxFHBSyrcikEg4diZ/03ZHh2g0oApNBG/NgOgl3PLVzrtXS91tQ9SUqLiRvQw=
Message-ID: <469958e00504291731eb8287c@mail.gmail.com>
Date: Fri, 29 Apr 2005 17:31:44 -0700
From: Caitlin Bestler <caitlin.bestler@gmail.com>
Reply-To: Caitlin Bestler <caitlin.bestler@gmail.com>
To: Libor Michalek <libor@topspin.com>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Cc: Bill Jordan <woodennickel@gmail.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Timur Tabi <timur.tabi@ammasso.com>
In-Reply-To: <20050429100425.A13041@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050425173757.1dbab90b.akpm@osdl.org>
	 <20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com>
	 <20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com>
	 <426EA220.6010007@ammasso.com> <20050426133752.37d74805.akpm@osdl.org>
	 <5ebee0d105042907265ff58a73@mail.gmail.com>
	 <469958e005042908566f177b50@mail.gmail.com>
	 <20050429100425.A13041@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/05, Libor Michalek <libor@topspin.com> wrote:

> 
>   However, you have a potential problem with registered buffers that
> do not begin or end on a page boundary, which is common with malloc.
> If the buffer resides on a portion of a page, and you mark the vm
> which contains that entire page VM_DONTCOPY, to ensure that the parent
> has access to the exact physical page after the fork, the child will
> not be able to access anything on that entire page. So if the child
> expects to access data on the same page that happens to contain the
> registered buffer it will get a segment violation.
> 
> The four situations we've discussed are:
> 
>   1) Physical page does not get used for anything else.
>   2) Processes virtual to physical mapping remains fixed.
>   3) Same virtual to physical mapping after forking a child.
>   4) Forked child has access to all non-registered memory of
>      the parent.
> 
> The first two are now taken care of with get_user_pages, (we use to
> use VM_LOCKED for the second case) third case is handled by setting
> the vm to VM_DONTCOPY, and on the fourth case we've always punted,
> but the real answer is to break partial pages into seperate vms and
> mark them ALWAYS_COPY.
> 
> -Libor
> 
> 
Attempting to provide *any* support for applications that fork children
after doing RDMA registrations is a ratshole best avoided. The general
rule that application developers should follow is to do RDMA *only*
in the child processes.

Keep in mind that it is not only the memory regions that must be dealt
with, but control data invisible to the user (the QP context, etc.). This
data frequently is interlinked between kernel residente and user resident
data (such as a QP context has the PD ID somewhere on-chip or in
kernel, which the Send Queue ring needs to be in user memory). Having
two different user processes that both think they have the user half to
this type of split data structure is just asking for trouble, even if you 
manage to get the copy on write bit timing problems all solved.

All of this can be avoided by a simple rule: don't fork after opening
an RDMA device.
