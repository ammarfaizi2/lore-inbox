Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWBSVEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWBSVEb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWBSVEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:04:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750756AbWBSVEa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:04:30 -0500
Date: Sun, 19 Feb 2006 13:02:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: stern@rowland.harvard.edu, psusi@cfl.rr.com, pavel@suse.cz,
       torvalds@osdl.org, mrmacman_g4@mac.com, alon.barlev@gmail.com,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: Flames over -- Re: Which is simpler?
Message-Id: <20060219130243.52af0782.akpm@osdl.org>
In-Reply-To: <200602192144.57748.oliver@neukum.org>
References: <43F89F55.5070808@cfl.rr.com>
	<Pine.LNX.4.44L0.0602191142290.9165-100000@netrider.rowland.org>
	<20060219120221.1d11cee0.akpm@osdl.org>
	<200602192144.57748.oliver@neukum.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum <oliver@neukum.org> wrote:
>
> Am Sonntag, 19. Februar 2006 21:02 schrieb Andrew Morton:
> > For a), the current kernel behaviour is what we want - make the thing
> > appear at a new place in the namespace and in the hierarchy.  Then
> > userspace can do whatever needs to be done to identify the device, and
> > apply some sort of policy decision to the result.
> 
> How? If you have a running user space the connection to the open files
> is already severed, as any access in that time window must fail.

That's a separate issue, which we haven't discussed yet.  We have a device
which has gone away and which might come back later on.  Presently we will
return an I/O error if I/O is attempted in that window.  Obviously we'll
need to do something different, such as block reads and block or defer writes.

So an overall picture would be something like:

- When device is not present, reads block and writes are deferred or block

- When device appears (at a new point in the namespace) the hotplug
  scripts will go off and will identify it and will apply some policy based
  upon that identification.  That policy could be one of:

  a) accept device at its new address

  b) accept device at its new address, abandon the old address (all
     those blocked reads and writes suddenly return -EIO).

  c) remove device from its new address, splice it back to where it
     used to be, permit those blocked reads and writes to proceed.

- For devices which are absent-and-blocked, provide some ability for both
  a timeout and manual cancellation, to unblock all those readers and
  writers, make them get -EIO.

The number of potential races is, of course, huge.
