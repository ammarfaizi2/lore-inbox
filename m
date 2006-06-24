Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWFXKUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWFXKUM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 06:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933376AbWFXKUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 06:20:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:49361 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932348AbWFXKUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 06:20:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z7ubIjkugbf6NsG2sjbA1ym0PXe2RW+a6pJQWx0aAp0vNG9QiOMvqzC0FJkTrx51XxXlRQR58bcLSC+T5LtLbgC0dp9/5ocWJ3KZu7JFsvm8lkEMv8jM4u8s4snmpgqC9HW6AaUbIRN6uFmZ0cG3qIrb8kw+rOv9P5ukh9htCuA=
Message-ID: <b0943d9e0606240320h1727639cv36a4fe399dddd767@mail.gmail.com>
Date: Sat, 24 Jun 2006 11:20:09 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On 12/06/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 6/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > There are allocations for which the main pointer cannot be found but they
> > are not memory leaks. This patch fixes some of them.
>
> Can we fix this by looking for pointers to anywhere in the allocated
> memory block instead of just looking for the start?

I eventually got some spare time to continue the investigation on this.

I did some statistics with using a priority radix tree for pointer
detection. This would eliminate the container_of hack and the
memleak_padding calls. The statistics on qemu x86 (with just a prompt,
no X or other applications started and unaligned values ignored) look
like this:

allocated/detected pointers = 30433
detected via aliases = 6355

locations scanned = 1654781
pointer like values = 476145
values found in the radix tree = 157011
values found in the prio tree = 283283

>From the scanned values, 9.5% were found in the radix tree (current
implementation). There is a total of 28.8% values that look like
pointers. This means that 67% of the values that look like pointers
aren't pointing to any block (the other 33% are pointing to a block
start or to certain offsets inside the block).

However, using a priority radix tree, 17% from the scanned values
would match allocated blocks (almost double compared to the current
method). 41% of the values that look like pointers would not be found
pointing to a block or somewhere inside one. This means that an
additional 26% of the values that look like pointers (compared to the
radix tree method) have the potential of creating false negatives.

My opinion is not to implement the "anywhere inside a block" method as
it would increase the risk of false negatives with a little benefit
(removing some false positive notifications, probably less than 30).

To the other extreme is Ingo's suggestion of using exact type
identification but I don't think this would be acceptable for the
kernel as it would to modify all the memory alloc calls in the kernel
to either pass an additional parameter (the type id) or another
post-allocation call to kmemleak to update the id.

A compromise would be to use the "sizeof" type approximation for both
incoming and outgoing pointers (kmemleak currently does this for
incoming pointers). This would require an external tool for scanning
all the structure definitions in the kernel and generate
sizeof-pointer_offset pairs. It could also compare whether the size of
the dereferenced outgoing pointer is the same as that of the detected
memory block. I think this method would add the need of additional
false-positives covering in the kernel.

Anyway, the current implementation (I'll update it for 2.6.17) detects
real memory leaks. I suspect that a wide range of leaks would be
covered if it is used on different platforms and different conditions.

-- 
Catalin
