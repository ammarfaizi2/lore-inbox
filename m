Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSKTPGo>; Wed, 20 Nov 2002 10:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSKTPGo>; Wed, 20 Nov 2002 10:06:44 -0500
Received: from almesberger.net ([63.105.73.239]:60170 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261286AbSKTPGm>; Wed, 20 Nov 2002 10:06:42 -0500
Date: Wed, 20 Nov 2002 12:05:51 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: suparna@in.ibm.com, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@provisioning.fibertel.com.ar>,
       Dave Hansen <haveblue@provisioning.fibertel.com.ar>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7 -- Success Story!
Message-ID: <20021120120551.O17062@almesberger.net>
References: <m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp> <m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp> <m1k7jb3flo.fsf_-_@frodo.biederman.org> <m1el9j2zwb.fsf@frodo.biederman.org> <m11y5j2r9t.fsf_-_@frodo.biederman.org> <1037668241.10400.48.camel@andyp> <20021120141925.A2524@in.ibm.com> <m1smxwzjlb.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1smxwzjlb.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Wed, Nov 20, 2002 at 02:17:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> The needed hooks are there.  You can make certain an appropriate
> ->shutdown()/reboot_notifier method is present, or you can fix the driver
> so it can initialize the device from any random state.  

In the case of a crash, you may not be able to use the normal
shutdown, but there may still be pending bus master accesses, e.g.
from an on-going transfer, or free buffers that will eventually
(i.e. there's no use in "waiting for the operation to finish") get
used.

Initializing the device from any state is certainly a good feature,
and it will cure the most visible symptoms, but problems may still
occur if the device decides to scribble over memory after leaving
the original kernel, and before the reset has occurred under the
new kernel. (Or did you mean to initialize before invoking kexec ?)

I see several possible approaches for this:

 0) do as bootimg did, and ignore the problem :-)
 1) try to call the regular device shutdown. In the case of a
    crash, this may hang, or corrupt the system further.
 2) add a new callback that just silences the device, without
    trying to clean things up. This is probably the best
    long-term solution.
 3) if there's a way to just reset some or all devices on the
    PCI bus without knowing what they are, this should have the
    desired effect, while being relatively easy to implement.
    (This probably still leaves things like AGP, multi-level PCI
    bus structures, non-PCI, etc.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
