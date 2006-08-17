Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWHQODb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWHQODb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWHQODa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:03:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:6090 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965010AbWHQOD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:03:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vqw+xbKFSOFWC5S2eFuWGUPhg5vLa03nUexui9ot2qOoRZdmY2rnKYZTrS/1w/1OKOWxUm/Bl61h+/aySGwWrlqpu0nDkacc/ZTHXPJXvzS38cFJP+/CaDZDcSNH0O2yloBbAFr9xvgxSWQfjnjD9XTcXSr+Jd0ojTEX9aeQohM=
Message-ID: <b0943d9e0608170703u7ead4a58pd9190ac2a7942385@mail.gmail.com>
Date: Thu, 17 Aug 2006 15:03:27 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Mauricio Lin" <mauriciolin@gmail.com>
Subject: Re: Some issues about the kernel memory leak detector: __scan_block() function
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3f250c710608170659l3d0f92c7qfe2503ce8ab58dd5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3f250c710608161519o54433300heb1c79de6cbf6ce5@mail.gmail.com>
	 <b0943d9e0608170128l5f9cec1ej3d46ac797c4c4738@mail.gmail.com>
	 <3f250c710608170659l3d0f92c7qfe2503ce8ab58dd5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/06, Mauricio Lin <mauriciolin@gmail.com> wrote:
> On 8/17/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > On 16/08/06, Mauricio Lin <mauriciolin@gmail.com> wrote:
> > > Let's suppose the a kmalloc() was executed without storing the
> > > returned pointer to the memory area and its fictitious returned value
> > > would be the address 0xb7d73000 as:
> > >
> > > kmalloc(32, GFP_KERNEL);  // Cause memory leak
> > >
> > > Is there any possibility the __scan_block() scans a memory block that
> > > contains the memory area allocated by the previous kmalloc?
> >
> > That's what the memleak-test module does.
> >
> > Yes, there is a chance and this is called a false negative. If there
> > is a (non-)pointer location having this value (especially the stack),
> > it won't be reported. However, these locations might change and at
> > some point you will get the leak reported.
>
> Do you mean that the (non-)pointer location might be moved to another
> memory location?

No, I mean that the value at that location might be changed. Let's say
you have a location in the data section or in another kmalloc'ed block
(which is trackable from the data section) which has value 0xb7d73000.
If this just happened to be random data, there is a chance that it
will be modified to something else and a new scan won't find it
anymore.

-- 
Catalin
