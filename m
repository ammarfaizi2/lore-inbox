Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129435AbQJ1Npk>; Sat, 28 Oct 2000 09:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbQJ1NpV>; Sat, 28 Oct 2000 09:45:21 -0400
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:9176 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129435AbQJ1NpU>; Sat, 28 Oct 2000 09:45:20 -0400
Message-ID: <39FAD698.2FF9C8C8@didntduck.org>
Date: Sat, 28 Oct 2000 09:37:28 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
CC: Andrew Morton <andrewm@uow.edu.au>,
        Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
In-Reply-To: <Pine.LNX.4.21.0010270945510.13233-200000@panoramix.bitwizard.nl> <39F96BE1.B9C97C20@uow.edu.au> <20001028141518.A2272@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Rumpf wrote:
> 
> On Fri, Oct 27, 2000 at 10:49:53PM +1100, Andrew Morton wrote:
> > Look, this modules stuff is really bad.  Phillip Rumpf proposed
> > a radical alternative a while back which I felt was not given
> 
> While it might be a "radical alternative", it doesn't require any changes
> to the subsystems that have been fixed so far.  At this time, applying the
> patch would basically fix the rest of the subsystems as well (if the
> drivers use MOD_{INC,DEC}_USE_COUNT, that is).
> 
> > sufficient consideration.  The idea was to make sys_delete_module()
> > grab all the other CPUs and leave them spinning on a flag while
> > the unload was proceeding.  This was very similar to
> > arch/i386/kernel/apm.c:apm_power_off().
> 
> The idea here is other CPUs don't have to deal with the kernel going
> through a number of inconsistent states while a module is unloaded.  At
> any point in time, for any module, exactly one of the following is true:
> 
> 1. you're in the module_exit function
> 2. the module is (being) loaded
> 3. the module isn't loaded.
> 
> > As far as I can recall, the only restriction was that you are
> > not allowed to call module functions when the module refcount
> > is zero if those functions can call schedule().
> 
> There are other restrictions which shouldn't really matter:
> 
>  - you can't schedule() and hope you end up on a particular CPU (you can
> use smp_call_function though)
> 
>  - you can't copy_(from|to)_user in the module exit function (which would
> be copies from/to rmmod anyway)

Unfortunately, you need to be able to use copy_*_user() from the network
ioctls, and this is the center of the current issue.

-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
