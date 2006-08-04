Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWHDCwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWHDCwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 22:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWHDCwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 22:52:38 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:53767 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S1030297AbWHDCwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 22:52:37 -0400
Message-ID: <44D2B678.6060400@xensource.com>
Date: Thu, 03 Aug 2006 19:52:40 -0700
From: Jeremy Fitzhardinge <jeremy@xensource.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       xen-devel@lists.xensource.com, simon@xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
In-Reply-To: <20060803200136.GB28537@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Aug 2006 02:53:49.0666 (UTC) FILETIME=[364A3C20:01C6B771]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Aug 03, 2006 at 12:26:16PM -0700, Zachary Amsden wrote:
>   
>> Who said that?  Please smack them on the head with a broom.  We are all 
>> actively working on implementing Rusty's paravirt-ops proposal.  It 
>> makes the API vs ABI discussion moot, as it allow for both.
>>     
>
> So everyone is still skirting the issue, oh great :)
>   

I don't really think there's an issue to be skirted here.  The current 
plan is to design and implement a paravirt_ops interface, which is a 
typical Linux source-level interface between the bulk of the kernel and 
a set of hypervisor-specific backends.  Xen, VMWare and other interested 
parties are working together on this interface to make sure it meets 
everyone's needs (and if you have another hypervisor you'd like to 
support with this interface, we want to hear from you).

Until VMWare proposed VMI, Xen was the only hypervisor needing support, 
so it was reasonable that the Xen patches just go straight to Xen.  But 
with paravirtops the result will be more flexible, since a kernel will 
be configurable to run on any combination of supported hypervisor or on 
bare hardware.

As far as I'm concerned, the issue of whether VMI has a stable ABI or 
not is one which on the VMI side of the paravirtops interface, and it 
doesn't have any wider implications.

Certainly Xen will maintain a backwards compatible hypervisor interface 
for as long as we want/need to, but that's a matter for our side of 
paravirtops.  And the paravirtops interface will change over time as the 
kernel does, and the backends will be adapted to match, either using the 
same ABI to the underlying hypervisor, or an expanded one, or whatever; 
it doesn't matter as far as the rest of the kernel is concerned.

There's the other question of whether VMI is a suitable interface for 
Xen, making the whole paravirt_ops exercise redundant.  Zach and VMWare 
are claiming to have a VMI binding to Xen which is full featured with 
good performance.  That's an interesting claim, and I don't doubt that 
its somewhat true.  However, they haven't released either code for this 
interface or detailed performance results, so its hard to evaluate.  And 
with anything in this area, its always the details that matter: what 
tests, on what hardware, at what scale?  Does VMI really expose all of 
Xen's features, or does it just use a bare-minimum subset to get things 
going?  And how does the interface fit with short and long term design 
goals?

I don't think anybody is willing to answer these questions with any 
confidence.  VMWare's initial VMI proposal was very geared towards their 
particular hypervisor architecture; it has been modified over time to be 
a little closer to Xen's model, in order to efficiently support the Xen 
binding.  But Xen and ESX have very different designs and underlying 
philosophies, so I wouldn't expect a single interface to fit comfortably 
with either.

As far as LKML is concerned, the only interface which matters is the 
Linux -> <something> interface, which is defined within the scope of the 
Linux development process.  That's what paravirt_ops is intended to be.

And being a Linux API, paravirt_ops can avoid duplicating other Linux 
interfaces. For example, VMI, like the Xen hypervisor interface, need 
various ways to deal with time.  The rest of the kernel needn't know or 
care about those interfaces, because the paravirt backend for each can 
also register a clocksource, or use other kernel APIs to expose that 
interface (some of which we'll probably develop/expand over time as 
needed, but in the normal way kernel interfaces chance).

    J
