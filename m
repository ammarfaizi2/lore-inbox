Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWGDWY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWGDWY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 18:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWGDWY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 18:24:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:65448 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932321AbWGDWYz (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 18:24:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DBN46yLQA7gfmDHrjGRI3vPOwwVTE4ZdbvgrbiQifUqaAITgGnmOtdmY6/L1vrrlY2z8Y2+abl4+r8hq88eR8lnsonwbUqR1Gb1eGqQHXq4DnYBicJUG+2NNrJOZ9slkAhFKkYDUUGtK0oF1dsmNZyasYSaplEfOa4zUNOe7IHA=
Message-ID: <dda83e780607041524g5ae996fes6e579464a1af56ad@mail.gmail.com>
Date: Tue, 4 Jul 2006 15:24:54 -0700
From: "Bret Towe" <magnade@gmail.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
In-Reply-To: <17578.52643.364026.64265@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <B41635854730A14CA71C92B36EC22AAC06CCF2@mssmsx411>
	 <17578.52643.364026.64265@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/06, Nikita Danilov <nikita@clusterfs.com> wrote:
> Ananiev, Leonid I writes:
>  > Nikita Danilov writes:
>  > > When queue is congested---it is, because meta-data (indirect blocks in
>  > > ext[23] case) have to be read in synchronously before page can be
>  > paged
>  > > out (see comment in mm/vmscan.c:pageout()).
>  >
>  > Actually a queue is congested ---it is, because the queue is too long or
>  > bit BDI_write[read]_congested is set.
>  >
>  > > But much more importantly: when direct reclaim skips writing dirty
>  > pages
>  > > from tail of the inactive list,
>  >
>  > The  direct reclaim does not skip any page in pdflush thread because
>  > may_write_to_queue() returns true
>  > if (current->flags & PF_SWAPWRITE) and: __pdflush() sets this flag:
>  > See pfflush.c: __pdflush() first line
>  > current->flags |= PF_FLUSHER | PF_SWAPWRITE;
>
> Hm.. indeed it is. But this is quite strange. This means, that if some
> device queues are congested, pdflush threads will be stuck waiting for
> these queues to drain, and as there is only limited number of pdflush
> threads in the system, write-out to the non-congested devices will not
> progress too.
>
> Doing large amounts of writeback from pdflush threads makes situation
> only worse: suppose you have more than MAX_PDFLUSH_THREADS devices on
> the system, and large number of writing threads. If some devices become
> congested, then *all* pdflush threads may easily stuck waiting on queue
> congestion and there will be no IO going on against other devices. This
> would be especially bad, if system is a mix of slow and fast devices.
>
> In the original code, threads writing into fast devices are not impacted
> by congestion of slow devices.

are you sure about that? cause that sounded alot like an issue
i saw with slow usb devices (mainly a usb hd on a usb 1.1 connection)
the usb device would fill up with write queue and local io to say /dev/hda
would basicly stop and the system would be rather useless till the usb
hd would finish writing out what it was doing
usally would take several hundred megs of data to get it to do it

ive not tried it in ages so maybe its been fixed since ive last tried it
dont recall the kernel version at the time but it wasnt more than a
year ago

> You can deal with that particular situation in your patch by checking
> return value of
>
>         pdflush_operation(background_writeout, 0);
>
> and falling back to synchronous write-back if it fails to find worker
> thread.
>
>  >
>  > > Wouldn't this interfere with current->backing_dev_info logic?
>  > > Maybe pdflush threads should set this field too?
>  > It is not need to set current->backing_dev_info for pdflush because
>
> Yes, that was silly proposal. I think your patch contains very useful
> idea, but it cannot be applied to all file systems. Maybe
> wait-for-pdflush can be made optional, depending on the file system
> type?
>
>  > PF_SWAPWRITE is set for pdflush.
>  > The proposed patch does not concern of backing_dev_info logic.
>  >
>  > Leonid
>
> Nikita.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
