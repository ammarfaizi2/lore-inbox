Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUJGSqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUJGSqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267537AbUJGSpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:45:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28077 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267808AbUJGSkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:40:00 -0400
Date: Thu, 7 Oct 2004 13:42:21 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Gabor Z. Papp" <gzp@papp.hu>
Cc: Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] 0-order allocation failed
Message-ID: <20041007164221.GD14614@logos.cnet>
References: <200410071318.21091.mbuesch@freenet.de> <20041007151518.GA14614@logos.cnet> <200410071917.40896.mbuesch@freenet.de> <20041007153929.GB14614@logos.cnet> <x67jq2bcy3@gzp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x67jq2bcy3@gzp>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 08:28:04PM +0200, Gabor Z. Papp wrote:
> * Marcelo Tosatti <marcelo.tosatti@cyclades.com>:
> 
> | > > Can you check how much swap space is there available when
> | > > the OOM killer trigger? I bet this is the case.
> | > 
> | > The machine doesn't have swap.
> | 
> | Well then you're probably facing true OOM.
> | 
> | Add some swap.
> 
> There is really no way to run 2.4 without swap?

Nope. Any kernel can't. The thing is the system overcommits 
memory (it allows applications to allocate more memory than the system 
is able to handle).

If there is no place to "save" that memory once you run out of it,
you're dead. Its a physical problem. :)

> I have the same problem with nfsroot and ramdisk based setups after
> 1-2 weeks uptime.

You can try to remove the following lines from mm/vmscan.c::try_to_free_pages_zone() 

        if (likely(current->pid != 1))
                break;
        if (!check_classzone_need_balance(classzone))
                break;

And disable CONFIG_OOM_KILLER. See if that makes a difference.

What will happen is that the kernel will try to free memory and 
never go into the OOM killer. If it can't free memory, the
system will hang forever at certain point.

There's not much to do about it really.

In 2.6 you can decrease swappiness so for it to free pagecache harder, 
but its the same game.
