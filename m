Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130706AbQJ1P6c>; Sat, 28 Oct 2000 11:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130914AbQJ1P6X>; Sat, 28 Oct 2000 11:58:23 -0400
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:1972 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S130699AbQJ1P6O>; Sat, 28 Oct 2000 11:58:14 -0400
Message-ID: <39FAF5BE.C79801A2@didntduck.org>
Date: Sat, 28 Oct 2000 11:50:22 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
In-Reply-To: <Pine.LNX.4.21.0010270945510.13233-200000@panoramix.bitwizard.nl> <39F96BE1.B9C97C20@uow.edu.au> <20001028141518.A2272@parcelfarce.linux.theplanet.co.uk> <39FAD698.2FF9C8C8@didntduck.org> <20001028145312.B2272@parcelfarce.linux.theplanet.co.uk> <39FADAC9.DC1255D1@didntduck.org> <20001028160537.C2272@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Rumpf wrote:
> 
> On Sat, Oct 28, 2000 at 09:55:21AM -0400, Brian Gerst wrote:
> > Yes, but they can be called (and sleep) with module refcount == 0.  This
> > is because the file descripter used to perform the ioctl isn't directly
> > associated with the network device, thereby not incrementing the
> > refcount on open.
> 
> According to my proposal, it is perfectly safe to call a function in a module
> while the module's use count is 0.  This function would typically look like this:
> 
> foo()
> {
>         MOD_INC_USE_COUNT;
> 
>         copy_*_user() (or anything else that sleeps);
> 
>         MOD_DEC_USE_COUNT;
> 
>         return bar;
> }
> 
> The only difference to the "old" module scheme is that the above currently isn't
> safe on SMP systems.

This will only work while the kernel is not preemptable.  Once the
kernel thread can be rescheduled, all bets are off.

With or without your patch, the network ioctls are unsafe, since they
don't currently do refcounting at all.  Adding it in the layer above the
driver is the easier and cleaner solution.

-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
