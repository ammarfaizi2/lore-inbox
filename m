Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263979AbUGUTkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUGUTkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 15:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUGUTkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 15:40:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57759 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263979AbUGUTku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 15:40:50 -0400
To: Mike Snitzer <snitzer@gmail.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [Fastboot] [ANNOUNCE] [PATCH] 2.6.8-rc1-kexec1 (ppc & x86)
References: <20040719181115.86378.qmail@web52302.mail.yahoo.com>
	<m1y8le3cto.fsf@ebiederm.dsl.xmission.com>
	<170fa0d2040720180741cfa783@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Jul 2004 13:40:18 -0600
In-Reply-To: <170fa0d2040720180741cfa783@mail.gmail.com>
Message-ID: <m1d62p2lp9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Snitzer <snitzer@gmail.com> writes:


> In preparation for kexec to be viable for 2.6 inclusion it would
> appear that some effort will need to go in to making sure all drivers
> in the kernel actually let go of their resources.  Should there be an
> audit to verify all device drivers have a shutdown()?

Right this is a janitorial type task that needs to done.

- First there are a lot of devices that don't need a shutdown
  method.  Mostly either because they are not stateful or
  their initialization method can bring them out of whatever
  state they are in.

Although if the kexec stuff gets in this might just happen
with a pile of bug reports like yours.

> Another option is to call each module's remove() iff the module
> doesn't have shutdown().  This would require changing
> drivers/base/power/shutdown.c device_shutdown() to include ... else if
> (dev->driver && dev->driver->remove) ... As a side-effect it would
> make drivers like the e1000 safe for use with kexec.

Last time I had this conversation it was not wanted to merge
shutdown() and remove() because shutdown is just required to touch
the hardware and not to clean up the kernel data structures.  Which
if you machine is in an unstable state already could be an advantage.

But calling shutdown on device remove is perfectly legitimate.
And it should help ensure the code path gets tested.

Ah... Looking more closely there is a method for testing
the shutdown method and the related power management states.
Details are in documentation/power/devices.txt
But in short there is a "detach_state" file for each file
in sysfs.  If you do "echo 4 > detach_state" it the shutdown
method should be called on device removal.  Other low power
states can be handles the same way.

I still think drivers will want to call their shutdown method
from their remove method if there is any work to do.  But at
least there is now a way to test the code path.  

Eric





