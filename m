Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWHCIbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWHCIbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 04:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWHCIbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 04:31:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13696 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932396AbWHCIbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 04:31:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UpQOdorO+S4NCwzqS5eef3F40v+4lIV2qA8GS42iwlJ2yMr4PUiaBGc+SHzVmMr9LXgxYUS53Zpm2o/7UJm8VA+yCTUE0trTYIxFDGTEgcGwtvj8R0F210fuaI2VkRij7dOIw7Ttz5f2vzTyYgtrCBYBKnoM0ljjuCoKl/6JuNE=
Message-ID: <b0943d9e0608030131j71abdc36ybef4c686d3b6d139@mail.gmail.com>
Date: Thu, 3 Aug 2006 09:31:43 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Jakub Jelinek" <jakub@redhat.com>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Ingo Molnar" <mingo@elte.hu>, "Pekka Enberg" <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org, "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060803063230.GY32572@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606240320h1727639cv36a4fe399dddd767@mail.gmail.com>
	 <20060624102248.GA23277@elte.hu> <20060724111554.GA5286@elte.hu>
	 <b0943d9e0607240628n115deac4x3befe5d39037248f@mail.gmail.com>
	 <20060803063230.GY32572@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/06, Jakub Jelinek <jakub@redhat.com> wrote:
> On Mon, Jul 24, 2006 at 02:28:03PM +0100, Catalin Marinas wrote:
> > On 24/07/06, Ingo Molnar <mingo@elte.hu> wrote:
> > >update: there's also a neat gcc extension trick suggested by Arjan:
> > >__builtin_classify_type(). This converts types into integers!
> >
> > It's not really reliable as it doesn't distinguish well between types.
> > All the structures, no matter what they contain, have the same id
> > (which I think only refers to the fact that it is built-in type,
> > pointer or structure, without differentiation).
>
> __builtin_classify_type () doesn't give types unique ID, it only classifies
> them:
[...]
> All structures are given record_type_class, all unions union_type_class,
> all pointers pointer_type_class, etc.

Yes, I noticed this.

> That doesn't mean you can't use it in the kernel as additional source
> of type checking (in addition to e.g. sizeof and __alignof__).

It is useful indeed, especially for identifying which types could
actually be or contain pointers. However, with the current Linux API,
the only information that can be passed to kmemleak via the alloc
functions is the size information.

My plan is to post a kmemleak update (some bug-fixes) this weekend and
get some wider testing (maybe in the -mm tree). Once people are happy
with the current implementation, I'll try to add more precise type
checking and introduce new functions (macros) like kmalloc_typed and
kmem_cache_create_typed together with Ingo's algorithm for unique type
ids.

There is another improvement that could be made to reduce the false
negatives - allocate slab objects larger than the required size and
change the offset every time the object is re-allocated. I think this
would be useful not only for kmemleak but also for catching possible
object alterations after it was re-allocated.

-- 
Catalin
