Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266752AbUG1WwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266752AbUG1WwB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUG1WwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:52:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:64914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267164AbUG1WjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:39:14 -0400
Date: Wed, 28 Jul 2004 15:42:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ebiederm@xmission.com, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org, jbarnes@engr.sgi.com
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-Id: <20040728154230.11d658af.akpm@osdl.org>
In-Reply-To: <1091044742.31698.3.camel@localhost.localdomain>
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com>
	<25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Mer, 2004-07-28 at 21:33, Andrew Morton wrote:
> > We really don't want to be calling driver shutdown functions from a crashed
> > kernel.
> 
> Then at the very least you need to disable bus mastering and have
> specialist recovery functions for problematic devices. The bus
> mastering one is essential otherwise bus masters will continue to
> DMA random data into your new universe.

But they're welcome to do that: the memory for the DMA transfer has
already been allocated and our new universe will not be touching it.

What we need to do is to ensure that the new kexec-ed kernel appropriately
whacks the devices to stop any in-progress operations.  So it's the probe() and
open() routines which need to get the device into a sane state, not the shutdown
routines.

This way:

- We have less devices to take care of: we only care about those devices
  which are needed for a successful dump.

- We are poking at these devices in a known-good kernel, not from within
  a kernel which has wrecked itself.

- Any devices which are performing DMA to/from the old kernel's memory
  can just keep on doing that.  The new kernel doesn't care, unless it
  needs those devices for dumping.


