Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbUBHQxi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUBHQxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:53:38 -0500
Received: from gw0.infiniconsys.com ([65.219.193.226]:64836 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S263805AbUBHQxg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:53:36 -0500
From: "Fab Tillier" <ftillier@infiniconsys.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: "Hefty, Sean" <sean.hefty@intel.com>, "Troy Benjegerdes" <hozer@hozed.org>,
       <infiniband-general@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Sun, 8 Feb 2004 08:51:22 -0800
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB017C1A11@mercury.infiniconsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20040208162946.GA2531@kroah.com>
Importance: Normal
X-OriginalArrivalTime: 08 Feb 2004 16:53:35.0884 (UTC) FILETIME=[17BBF4C0:01C3EE64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Sunday, February 08, 2004 8:30 AM
> 
> On Sun, Feb 08, 2004 at 12:31:56AM -0800, Fab Tillier wrote:
> >
> > I think there is value in allowing the code to be shared between
> > kernel mode and user mode.  Would using a macro that resolve to the
> > native kernel spin lock structure and functions be acceptable?
> 
> Probably not, just use the in-kernel call, and be done with it.  If you
> _really_ want to share code between userspace and the kernel, keep a
> different version of it somewhere else.

Are you suggesting branching the user mode code from the kernel mode code?
Duplication is not the same as sharing code - you have twice the number of
places that require fixing in the event of a bug.  If we can help it, we'd
like to avoid this.

> 
> Why do you want to run your code in both places?  Does this mean that it
> doesn't even really need to be in the kernel as it works just fine in
> userspace?

IBAL provides APIs for accessing InfiniBand resources in both the kernel and
in user-mode.  Those APIs are identical, and many of the files are shared
between user and kernel mode.  In the kernel, storage drivers, network
drivers, and SDP interface to the kernel IBAL driver.  In user mode, the
subnet manager, uDAPL, MPI, and other IB-enabled applications interface to
the user-mode IBAL library.  The reason a user-mode library is provided is
that InfiniBand provides mechanisms to bypass the kernel for speed path
operations - send, receive, and completion processing - similarly to VI.
Bypassing the kernel for these operations helps provide higher bandwidths
and lower latencies to applications.

The user-mode IBAL library depends on the kernel mode IBAL driver to setup
InfiniBand resources for use, and for the operations that can't be
offloaded, like memory registrations.  Further, the kernel IBAL driver
tracks user-mode resources on a per-process basis to ensure they are freed
if an application seg faults.  This is a must so that things like memory
registrations get cleaned up and the associated memory unlocked even in
abnormal application termination situations.

I hope this clears up why code is shared between user-mode and kernel mode.

- Fab

