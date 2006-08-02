Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWHBNSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWHBNSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 09:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWHBNSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 09:18:15 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:6074 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1751022AbWHBNSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 09:18:15 -0400
From: Paul Cameron Davies <pauld@cse.unsw.EDU.AU>
To: Chris Wright <chrisw@sous-sol.org>
Date: Wed, 2 Aug 2006 23:17:58 +1000 (EST)
X-X-Sender: pauld@weill.orchestra.cse.unsw.EDU.AU
cc: Ian Wienand <ianw@gelato.unsw.edu.au>,
       Christoph Lameter <clameter@sgi.com>,
       Paul Davies <pauld@gelato.unsw.edu.au>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Gerd Hoffmann <kraxel@suse.de>, Hollis Blanchard <hollisb@us.ibm.com>,
       Ian Pratt <ian.pratt@xensource.com>, Zachary Amsden <zach@vmware.com>,
       npiggin@suse.de
Subject: Re: [PATCH 1 of 13] Add apply_to_page_range() which applies a function
 to a pte range
In-Reply-To: <20060802065424.GL2654@sequoia.sous-sol.org>
Message-ID: <Pine.LNX.4.64.0608022314520.23202@weill.orchestra.cse.unsw.EDU.AU>
References: <79a98a10911fc4e77dce.1154421372@ezr.goop.org>
 <m1ejw0zmic.fsf@ebiederm.dsl.xmission.com> <20060801211410.GH2654@sequoia.sous-sol.org>
 <Pine.LNX.4.64.0608011421080.19146@schroedinger.engr.sgi.com>
 <1154492211.2570.43.camel@localhost.localdomain>
 <Pine.LNX.4.64.0608012214440.21242@schroedinger.engr.sgi.com>
 <20060802064453.GA10986@cse.unsw.EDU.AU> <20060802065424.GL2654@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006, Chris Wright wrote:

> * Ian Wienand (ianw@gelato.unsw.edu.au) wrote:
>> On Tue, Aug 01, 2006 at 10:18:33PM -0700, Christoph Lameter wrote:
>>> I have not been involved in this issue for a long time now.
>>> You need to contact the people actively working on code like this.
>>> Most important is likely Ian Wienand.
>>
>> Paul Davies <pauld@gelato.unsw.edu.au> is the person actively working
>> on this project.  I might note he has not been doing it un-announced;
>> see
>>
>> http://marc.theaimsgroup.com/?l=linux-mm&m=115276500100695&w=2
>>
>> for the latest patches, or some of the other links Cristoph pointed
>> out.  I'm sure he'd love to talk to anyone about it :)
>
> Well that looks closer to the iterator here than some of the eariler
> links.  The apply_to_page_range is pretty trivial, will have to look at
> Paul's patches to see if there's something we can use.  This is just for
> Xen's use ATM, so we can always revert to keeping it Xen local if Paul's
> changes are heading upstream, and use them once they're in.
>
> thanks,
> -chris
>
Hi Chris

I understand you are looking for a generic iterator to operate on a set
of ptes within a given address range.

Unfortunately just about every iteration in the kernel now varies slightly
(usually at the pte directory level) in such a way that abstracting out
each iteration into generic iterators becomes somewhat problematic.

I classify them into read, build and dual iterators.

READ iterators: read a page table within a range and operate on the ptes
eg: unmap_page_range, change protection, msync ...

BUILD iterators: build a page table in a range while operating on the 
ptes.
eg: vmap_pte_range, remap_pfn_range, ...

DUAL iterators: read and build a page table within a range and operate on 
the ptes.
eg: copy_page_range (src and dst page tables different)
eg: mremap iterator (src and dst page tables the same)

A little over a year ago it was possible to abstract the iterators
into these classes because they were relatively untailored.  During the
last year a fair bit of customisation has occured on many iterators and
some additional iterations added.  Some of these iterators are performance
critical and their tailoring necessary.  The ones that are less important
would need to be tidied up so that abstraction to generic iterators can 
occur.

Because of the continual divergence of the iterators I have removed the
generic iterators where I would pass it a function across the interface
because they became too unweildy.

One possible solution is to have a set of critical and non critical 
iterators. The non critical iterators would comprise a generic read and 
build iterator.

However at this stage the Linux community seems relatively content to
access the page table data structure in an open fashion with tailored cut
and paste iterators.  This method does have its advantages but it makes
changing the page table implementation more difficult.

Cheers

Paul Davies

