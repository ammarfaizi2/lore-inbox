Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbWHIGAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbWHIGAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbWHIGAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:00:15 -0400
Received: from qb-out-0506.google.com ([72.14.204.237]:12730 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030506AbWHIGAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:00:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g3JVzZ1wmxzSBF4l9nx8ZQoq2UwujiDRQIvGQgf60UVS6pGBOZ4yef0U+6tTsgeCKHTr0qpGUJI8kvJsbqYJXeYJEd4MK5KqJiexyeb7qsgY8s25kqHtLWL//OX6s0MuEzm5lsnYSm5yMbc3/ZQmOmE8PQczLVMOxBjMHEAbkHQ=
Message-ID: <aec7e5c30608082300t3b903e89rff302dc25339c720@mail.gmail.com>
Date: Wed, 9 Aug 2006 15:00:01 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: memory resource accounting (was Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu controller)
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, rohitseth@google.com,
       "Dave Hansen" <haveblue@us.ibm.com>, "Kirill Korotaev" <dev@sw.ru>,
       vatsa@in.ibm.com, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Andrew Morton" <akpm@osdl.org>, mingo@elte.hu, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       pj@sgi.com, "Andrey Savochkin" <saw@sw.ru>
In-Reply-To: <p73d5bao7d9.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060804050753.GD27194@in.ibm.com> <44D6EAFA.8080607@sw.ru>
	 <44D74F77.7080000@mbligh.org> <44D76B43.5080507@sw.ru>
	 <1154975486.31962.40.camel@galaxy.corp.google.com>
	 <1154976236.19249.9.camel@localhost.localdomain>
	 <1154977257.31962.57.camel@galaxy.corp.google.com>
	 <44D798B1.8010604@mbligh.org> <44D89D7D.8040006@yahoo.com.au>
	 <p73d5bao7d9.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Aug 2006 06:33:54 +0200, Andi Kleen <ak@suse.de> wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> writes:
> >
> > - each struct page has a backpointer to its billed container. At the mm
> >    summit Linus said he didn't want back pointers, but I clarified with him
> >    and he isn't against them if they are easily configured out when not using
> >    memory controllers.
>
> This would need to be done at runtime though, otherwise it's useless
> for distributions and other people who want single kernel binary images.
>
> Probably would need a second parallel table, but for that you would
> need to know at boot already if you plan to use them or not. Ugly.

I've been thinking a bit about replacing the mapping and index members
in struct page with a single pointer that point into a cluster data
type. The cluster data type is aligned to a power of two and contains
a header that is shared between all pages within the cluster. The
header contains a base index and mapping. The rest of the cluster is
an array of pfn:s that point back to the actual page.

The cluster can be seen as a leaf node in the inode radix tree.
Contiguous pages in inode space are kept together in the cluster - not
physically contiguous pages. The cluster pointer in struct page is
used together with alignment to determine the address of the cluster
header and the real index (alignment + base index).

Anyway, what has all this to do with memory resource management? It
should be possible to add a per-cluster container pointer in the
header. This way the per-page overhead is fairly small - all depending
on the cluster size of course.

/ magnus
