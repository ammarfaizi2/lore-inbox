Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316611AbSGBEu4>; Tue, 2 Jul 2002 00:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSGBEuz>; Tue, 2 Jul 2002 00:50:55 -0400
Received: from rj.SGI.COM ([192.82.208.96]:19151 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S316611AbSGBEuz>;
	Tue, 2 Jul 2002 00:50:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal 
In-reply-to: Your message of "Tue, 02 Jul 2002 00:08:55 -0400."
             <3D212757.5040709@quark.didntduck.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Jul 2002 14:53:15 +1000
Message-ID: <32193.1025585595@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jul 2002 00:08:55 -0400, 
Brian Gerst <bgerst@quark.didntduck.org> wrote:
>Keith Owens wrote:
>> 1) Do the reference counting outside the module, before it is entered.
>>    Not only does this pollute all structures that contain function
>>    pointers, it introduces overhead on every function dereference.  All
>>    of this just to cope with the relatively low possibility that a
>>    module will be removed.
>
>Only "first use" (ie. ->open) functions need gaurding against unloads. 
>Any subsequent functions are guaranteed to have a reference to the 
>module, and don't need to bother with the refcount.  I have a few ideas 
>to optimize the refcounting better than it is now.

Also the close routine, otherwise there is a window where the use count
is 0 but code is still executing in the module.

Network operations such as SIOCGIFHWADDR take an interface name and do
not call any 'open' routine.  The only lock I can see around dev_ifsioc
is dev_base_lock, AFAICT that will not protect against a module being
unloaded while SIOCGIFHWADDR is running.  If dev_base_lock does protect
against module unload, it is not clear that it does so.

For netfilter, the use count reflects the number of packets being
processed.  Complex and potentially high overhead.

All of this requires that the module information be passed in multiple
structures and assumes that all code is careful about reference
counting the code it is about to execute.  There has to be a better
way!

