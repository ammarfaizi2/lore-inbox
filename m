Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423254AbWKIBBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423254AbWKIBBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423979AbWKIBBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:01:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:26778 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423254AbWKIBBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:01:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nARZ/KIr39wt9056Ovhibies0OZE+qxMlm19PB0htq3nYSWd7gq84r2ihEYkJEEd4ibDzfYMadXuh2jVklB4ISD4gXXqX8ePyCYTF0KccDGO4PtZpFP63v+ZbEQO5UOVtLGq2mPaqzl5xIajczjlRG6NcJoK7a4A6R0iwHwO1vE=
Message-ID: <4807377b0611081701i26ee7ce0k1f822dbbe52c2c8@mail.gmail.com>
Date: Wed, 8 Nov 2006 17:01:44 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
Subject: Re: e1000 driver 2.6.18 - how to waste processor cycles
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>,
       "NetDEV list" <netdev@vger.kernel.org>
In-Reply-To: <45524E3A.7080301@soleranetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45524E3A.7080301@soleranetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

included netdev...

On 11/8/06, Jeff V. Merkey <jmerkey@soleranetworks.com> wrote:
>
> Is there a good reason the skb refill routine in e1000_alloc_rx_buffers
> needs to go and touch and remap skb memory
> on already loaded descriptors/  This seems extremely wasteful of
> processor cycles when refilling the ring buffer.
>
> I note that the archtiecture has changed and is recycling buffers from
> the rx_irq routine and when the routine is called
> to refill the ring buffers, a lot of wasteful and needless calls for
> map_skb is occurring.

we have to unmap the descriptor (or at least do
pci_dma_sync_single_for_cpu / pci_dma_sync_single_for_device) because
the dma API says we can't be guaranteed the cacheable memory is
consistent until we do one of the afore mentioned pci dma ops.

we have to do *something* before we access it.  Simplest path is to
unmap it and then recycle/map it.

If you can show that it is faster to use pci_dma_sync_single_for_cpu
and friends I'd be glad to take a patch.

Hope this helps,
  Jesse
