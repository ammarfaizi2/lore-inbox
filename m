Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSK0HPj>; Wed, 27 Nov 2002 02:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSK0HPj>; Wed, 27 Nov 2002 02:15:39 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:55007 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261318AbSK0HPj>; Wed, 27 Nov 2002 02:15:39 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 26 Nov 2002 23:22:34 -0800
Message-Id: <200211270722.XAA23313@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Modules with list
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
>In message <200211260649.WAA22216@adam.yggdrasil.com> you write:
>> >This would only happen if someone says "rmmod --wait".

>As I realized last night after I wrote this, there is a bug in
>module.c.  If O_NONBLOCK is specified, we shouldn't drop the module
>sempaphore at all, for exactly this reason.  A bug I introduced while
>"cleaning up" the "--wait" path.

>Sorry for the confusion.

	Then if you do "rmmod --wait" on some module that is in use,
every lsmod, insmod and rmmod will hang while attempting to acquire
module_mutex until the reference count on the module that you're
waiting to remove drops to zero, and there is no guarantee that that
will ever happen.  Some program might have to decide to close a file
descriptor or unmount a file system.  I think what you want is to
release the mutex before blocking and then reacquire it when you
continue.  Of course, you'll again have the scenario that I described.

	However, if you get rid of this idea of a blocking rmmod or
change it so that it does not make the module as "dead" if it is going
to block, then your idea of locking should work in the cases where
try_get_module() failure is handled by doing a request_module() and
retrying (because the insmod that request_module causes will acquire
module_mutex, so it will block until that module unload that was
causing the problem completes).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

