Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWDZWzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWDZWzt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 18:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWDZWzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 18:55:49 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:40607 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S964879AbWDZWzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 18:55:48 -0400
Subject: Re: [dm-devel] [RFC] dm-userspace
From: Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: device-mapper development <dm-devel@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87u08g553l.fsf@caffeine.beaverton.ibm.com>
References: <87u08g553l.fsf@caffeine.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 18:55:28 -0400
Message-Id: <1146092129.14129.333.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just curious, will the speed be a problem here? considering each time it
needs to contact user space for mapping a piece of data. and the size
unit is per sector in dm?

do u have any benchmark results about overhead?

ming


On Wed, 2006-04-26 at 15:45 -0700, Dan Smith wrote:
> Xen needs to be able to directly access disk formats such as QEMU's
> qcow, VMware's vmdk, and possibly others.  Most of these formats are
> based on copy-on-write ideas, and thus have a base image and a bunch
> of modified blocks stored elsewhere.  Presenting this to a virtual
> machine transparently as a normal block device would be ideal.  The
> solution I propose is to use device-mapper for redirecting block
> accesses to the appropriate locations within either the base image or
> the COW space, with the following constraints:
> 
> 1. The block-allocation algorithm and formatting scheme should not be
>    in the kernel.  This gives the most flexibility and puts the
>    complexity in userspace.
> 2. Actual data flow should happen only in the kernel, and userspace
>    should be able to control it without the blocks being passed back
>    and forth.
> 
> So, I developed a generic device-mapper target called dm-userspace
> which allows a userspace application to control the block mapping in a
> mostly generic way.  With the functionality it provides, I was able to
> write a userspace daemon that handles the mapping of blocks such that
> a qcow file could be presented as a single block device, mounted and
> accessed as if it were a normal disk.  If/when VMware releases their
> vmdk spec under the GPL, adding support for it would be relatively
> simple.  This would give us a unified block device to export to the
> virtual machine, that would be backed by a complex format such as vmdk
> or qcow.
> 
> In addition to providing support for the above scenario, dm-userspace
> could be used for other things as well.  It's possible that new
> device-mapper targets could be developed in userspace using a special
> application that used dm-userspace to simulate the kernel
> environment.  Additionally, filesystem debuggers may be able to use
> dm-userspace to provide interactive control and logging of disk
> writes. 
> 
> A patch against 2.6.16.9 to add dm-userspace to the kernel is
> available here:
> 
>   http://static.danplanet.com/dm-userspace/dmu-2.6.16.9.patch
> 
> After you have a patched kernel, you can build the (very tiny) helper
> library and example program, available here:
> 
>   http://static.danplanet.com/dm-userspace/libdmu-0.1.tar.gz
> 
> Comments would be appreciated :)
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel

