Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVCYUR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVCYUR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVCYUR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:17:27 -0500
Received: from smtpout.mac.com ([17.250.248.89]:52726 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261756AbVCYURS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:17:18 -0500
In-Reply-To: <20050325195826.GC4192@linux-sh.org>
References: <1110414879646@kroah.com> <11104148792069@kroah.com> <20050325180136.GA4192@linux-sh.org> <20050325181014.GA13436@kroah.com> <20050325183534.GB4192@linux-sh.org> <5c0804da3486a6e735a46220d73c9637@mac.com> <20050325195826.GC4192@linux-sh.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d626cecb88be3bfa7c7d820f56869eac@mac.com>
Content-Transfer-Encoding: 7bit
Cc: rmk+lkml@arm.linux.org.uk, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] driver core: Separate platform device name from platform device number
Date: Fri, 25 Mar 2005 15:17:09 -0500
To: Paul Mundt <lethal@linux-sh.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 25, 2005, at 14:58, Paul Mundt wrote:
> On Fri, Mar 25, 2005 at 02:38:22PM -0500, Kyle Moffett wrote:
>> So how would you tell the difference between the following?
>> 	device = "foobar0"
>> 	id = -1
>> 	path = "/sys/devices/platform/foobar0"
>> versus
>> 	device = "foobar"
>> 	id = 0
>> 	path = "/sys/devices/platform/foobar0"
>>
> Easy, we use the delimiter on anything ending with a number at the end 
> of
> the device name.. so for device = "foobar0", this would end up as
> /sys/devices/platform/foobar0.0, whereas in the latter case this would
> end up as /sys/devices/platform/foobar0.

But then you've just created yet another special case that will clutter 
the
interface in both the kernel _and_ all the applications.  Besides, the 
ID
on the first entry isn't 0, it's -1, which indicates it's a singleton.
You'd break existing applications anyways, because you're renaming a 
device
that existed and worked fine until it got renamed.  We should try to fix
the interface properly where it's broken so that we don't have to live 
with
the consequences for the next 3 years.

> The first case is a corner case, and really shouldn't happen that much 
> in
> practice outside of broken drivers.

But a driver ending in a number _isn't_ really a corner case.  Most 
devices
have model numbers, and so we shouldn't twist that case to do something
funny when we shouldn't have to.

> No you don't, it's pretty easy to figure out that if the end of the
> device name is a number that there will be a delimiter between that and
> the id. This should be the exception, not the rule.

But on the first example, there _isn't_ an ID, it's -1, it's a 
singleton.

> We don't go around changing /dev semantics everytime someone decides to
> call their device something silly, I don't see why platform devices
> should be treated differently, better to just fix the broken drivers..

Fix the broken interface to have a unique naming scheme that doesn't 
need
special cases and this problem will be less likely to occur again in the
future.

We all agree that if we were just creating this interface now, we would
use something like this, right?

if (id == -1) {
	snprintf( path, path_len, "/sys/devices/platform/%s", name);
} else {
	snprintf( path, path_len, "/sys/devices/platform/%s.%lu", name, id );
}

So why not do this now?  It's a lot simpler and easier to get right, 
with
no special cases other than the already existing singleton case.  It 
also
only requires a 1-character change to all existing code, the extra ".".

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


