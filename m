Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWEBSUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWEBSUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWEBSUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:20:45 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:47775 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S964949AbWEBSUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:20:43 -0400
Message-ID: <4457A2E4.8070900@am.sony.com>
Date: Tue, 02 May 2006 11:20:20 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: michael@ellerman.id.au
CC: "Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specificfil
 es
References: <1146528809.27495.21.camel@localhost.localdomain>
In-Reply-To: <1146528809.27495.21.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> On Mon, 2006-05-01 at 15:51 -0700, Geoff Levand wrote:
>> Segher, a problem with your suggestion is that our
>> makefiles don't have as rich a set of logical ops as the
>> config files.  Its easy to express 'build A if B', but not
>> so easy to do 'build A if not C'.  To make this work
>> cleanly I made PPC_CELL denote !SOME_HYPERVISOR_THING,
>> so I can have constructions like this in the makefile:
>> 
>> obj-$(CONFIG_PPC_CELL)	+= ...
> 
> Hi Geoff,
> 
> I've been ignoring this discussion, but now that I read it I think this
> is all kinda backwards.
> 
> PPC_CELL should not denote !SOME_HYPERVISOR, it should just mean "basic
> cell support", ie. PPC_CELL gets you platforms/cell built in.


Yes, that's the way I originally made it, and I switched it back
to that in the latest patch.


> Then we can have SOME_HYPERVISOR which _adds_ support for that
> hypervisor. And PPC_CELL_BLADE which selects things which are actually
> specific to that hardware, like SPIDERNET etc.
> But SOME_HYPERVISOR should not remove support for running on bare metal,
> it should just give you the option of running on the hypervisor. Yes
> that may require testing things at runtime, that's what
> firmware_has_feature() is for.


I feel you're missing one thing though, we need PPC_CELL_NATIVE.  We
don't want to build that in if we don't need it.  Here's what I setup:

PPC_CELL = make descends into platforms/cell
PPC_CELL_NATIVE = add bare metal support
PPC_IBM_CELL_BLADE = add blade device drivers, etc.


> The goal should be that we have one kernel which can boot on all Cell
> implementations. In fact the ultimate goal is to have one kernel that
> can boot any platform under powerpc, that's a way off still, but we
> don't want to start going backwards.


Yes, that's the whole idea of this patch.  It comes from my patch set
'cell: support multi-platform image'...  But we also need to be able
to build in only the support needed.  This is an important requirement
for consumer products, to reduce the image size.

In a certain class of products the kernel image and read-only parts
of the file system are stored on flash.  A smaller kernel means more
space for applications.  Also, a smaller kernel image loads faster.
Device startup time is very important for many consumer products.


-Geoff



