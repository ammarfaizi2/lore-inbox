Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWHQI2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWHQI2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWHQI2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:28:06 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:3435 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932329AbWHQI2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:28:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pM9/HukxOSFoqbWggx1p9EwGV2DJhXLDG/u8KCP9fmIuv0RvMc+6khKuZ7eUVM/Dx/+4i3gfZygD0PMto3R2J4rCi4h15hRnFYDyHcIYFrOD/1IBQezrMqIadZr0WMYXi0i9DKRq4ofGOlkNaK7TiX6jY3EafO522fW4t817ncQ=
Message-ID: <b0943d9e0608170128l5f9cec1ej3d46ac797c4c4738@mail.gmail.com>
Date: Thu, 17 Aug 2006 09:28:03 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Mauricio Lin" <mauriciolin@gmail.com>
Subject: Re: Some issues about the kernel memory leak detector: __scan_block() function
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3f250c710608161519o54433300heb1c79de6cbf6ce5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3f250c710608161519o54433300heb1c79de6cbf6ce5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauricio,

On 16/08/06, Mauricio Lin <mauriciolin@gmail.com> wrote:
> Let's suppose the a kmalloc() was executed without storing the
> returned pointer to the memory area and its fictitious returned value
> would be the address 0xb7d73000 as:
>
> kmalloc(32, GFP_KERNEL);  // Cause memory leak
>
> Is there any possibility the __scan_block() scans a memory block that
> contains the memory area allocated by the previous kmalloc?

That's what the memleak-test module does.

Yes, there is a chance and this is called a false negative. If there
is a (non-)pointer location having this value (especially the stack),
it won't be reported. However, these locations might change and at
some point you will get the leak reported.

To reduce the false negatives, I'll have to eliminate the stacks
scanning completely (and make sure there are no false positives
reported for pointers on the stack). Another improvement is to only
look at the places that would have pointers in a structure (both
Ingo's ideas). The latter is a bit more complicated but I could use
the compiler-generated data (-fdump-translation-unit) to identify the
structures and their members. It also requires some API changes to
allow exact type identification.

Anyway, I'll look into implementing the above after I sort out some
locking issues (which might cause deadlocks on SMP systems) with the
kmemleak re-entrancy.

-- 
Catalin
