Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUDUKvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUDUKvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 06:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbUDUKvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 06:51:31 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:58573 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264534AbUDUKv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 06:51:28 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: arjanv@redhat.com
Date: Wed, 21 Apr 2004 20:48:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16518.20890.380763.581386@cse.unsw.edu.au>
Cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       Andrew Morton <akpm@osdl.org>, Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       b-gruber@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
In-Reply-To: message from Arjan van de Ven on Monday April 19
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
	<Pine.GSO.4.58.0404191124220.21825@stekt37>
	<20040419015221.07a214b8.akpm@osdl.org>
	<xb77jwci86o.fsf@savona.informatik.uni-freiburg.de>
	<1082372020.4691.9.camel@laptop.fenrus.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday April 19, arjanv@redhat.com wrote:
> 
> > No.   That's not  a  problem  specific with  my  touchscreen.  It's  a
> > general  problem  with   the  design  of  the  input   layer.   It  is
> > implementing  *policies*  (on how  to  interpret  data  read from  the
> > PS2/AUX port), instead of providing  a *mechanism* to access (read and
> > write) that port.
> 
> well, it's the kernels job to abstract hardware. You don't also expose
> raw scsi and ide devices to userspace, you abstract them away and
> provide a uniform "block device" interface to userspace.
> The input layer tries to do the same wrt HID devices and imo it makes
> sense. Why should userspace care if a mouse is attached to the USB port
> or via the USB->PS/2 connector thingy to the PS/2 port. Requiring
> different configuration for both cases, and potentially even requiring
> different userspace applications for each type make it sound like
> abstracting this away from userspace does have merit. 

I agree that it is good for the kernel to provide hardware
abstractions, and that "mouse" is an appropriate device to provide an
abstract interface for.

It does not follow that all drivers below that abstraction should live
in the kernel.

Some drivers should live in the kernel, some shouldn't.  Issues such
as performance and multiple access tend to suggest whether a driver
needs to be in the kernel.

I don't believe that the driver for a mouse device needs to be in the
kernel for performance reasons or for shared access reasons.

The input layer has a "uinput" module that allows a user-space program
to act as an input-layer device.

I have a userspace program that talks to my ALPS touchpad (through a
hacked /dev/psaux that talks direct to the psaux port) and converts
taps etc into "input layer" messages that are passed back into
/dev/input/uinput.

Thus "user-space" - my X server - just reads from /dev/input/mice and
doesn't care what sort of mouse there is, as you suggest.

But "user-space" - my ALPS touchpad handler - does care that my
"mouse" is an ALPS dual-point touchpad and does the appropriate thing.

I did consider writing a kernel driver for the ALPS touchpad, but due
to the dearth of documentation and the fact that it seemed very hard
to automatically detect it, I decided that such a driver would be too
hard to support.

So here is my vote in favour of "Let's make /dev/psaux a clean channel
to the PS/AUX device" - at least conditionally.

NeilBrown
