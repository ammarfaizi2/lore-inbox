Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbVJGRXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbVJGRXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030519AbVJGRXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:23:39 -0400
Received: from ns.suse.de ([195.135.220.2]:4325 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030516AbVJGRXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:23:39 -0400
From: Andi Kleen <ak@suse.de>
To: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Subject: Re: [PATCH] Fix hotplug cpu on x86_64
Date: Fri, 7 Oct 2005 19:25:30 +0200
User-Agent: KMail/1.8
Cc: "Brian Gerst" <bgerst@didntduck.org>,
       "lkml" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D9E@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D9E@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510071925.30859.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 October 2005 18:42, Protasevich, Natalie wrote:

> You know Andi, I was imagining something like bitmap or linked list of
> all per_cpu vars (dynamically updated) and just going through this
> list... Or something like that (maybe some registration mechanism).
> There are not too many of them - about two dozens, mostly all sorts of
> accounting.

Finding them is no problem. We have NR_CPUS arrays for this (or other
per CPU mechanisms).

The problem is initializing them correct. There are currently two ways to do 
this: 

- (easier one, used by most subsystems) at startup set up state for 
all possible CPUs.
- (complex one) register a CPU notifier and watch for CPU_UP/DOWN

Because of the first way the per cpu data is currently preallocated for
all hotplug CPUs. You cannot copy the state later because it might be 
undefined then.

To make dynamic changes of possible map work would require to convert all 
users to the second more complex way. Probably a lot of work.

>
> > I think it is better to try to figure out how many hotplug
> > CPUs are supported, otherwise use a small default.
>
> Exactly - such as on ES7000, it can support 32, 64, 128 etc. processors
> depending on what configuration the customer actually ordered :)... it
> should be something for that, then NR_CPUS could be either defined as
> boot parameter or belong to subarchs.

ACPI/mptables has the concept of "disabled" CPUs.  I just bent that a bit
and use it as the number of possible CPUs.

-Andi

