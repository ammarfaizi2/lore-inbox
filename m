Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269221AbUJWFyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269221AbUJWFyN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267304AbUJWEY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:24:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56493 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266878AbUJWENe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:13:34 -0400
Date: Fri, 22 Oct 2004 21:13:24 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, <cova@ferrara.linux.it>
Subject: Re: 2.6.9-mm1 usb oopses
Message-ID: <20041022211324.4c7691ba@lembas.zaitcev.lan>
In-Reply-To: <20041022204518.2c4418be.akpm@osdl.org>
References: <20041022204518.2c4418be.akpm@osdl.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 20:45:18 -0700, Andrew Morton <akpm@osdl.org> wrote:

> looks like a ub.c problem.

Yes. At least partially.

> Date: Fri, 22 Oct 2004 21:59:20 +0200
> From: Fabio Coatti <cova@ferrara.linux.it>

> Oct 22 21:40:05 kefk kernel: ub 5-3:1.0: usb_probe_interface - got id
> Oct 22 21:40:05 kefk kernel: uba: device 6 capacity nsec 50 bsize 512
> Oct 22 21:40:05 kefk kernel: uba: made changed
> Oct 22 21:40:05 kefk kernel: uba: device 6 capacity nsec 1024000 bsize 512
> Oct 22 21:40:05 kefk kernel: uba: device 6 capacity nsec 1024000 bsize 512
> Oct 22 21:40:05 kefk kernel:  uba: uba1
> Oct 22 21:40:05 kefk kernel:  uba: uba1
> Oct 22 21:40:05 kefk kernel: kobject_register failed for uba1 (-17)
> Oct 22 21:40:05 kefk kernel:  [<c01f1f77>] kobject_register+0x51/0x5f

This looks like a race, but isn't. What actually happens is that the ub
returns a device changed indication from check_media_changed when the
device is connected. In such case, do_open will make another attempt
to read partitions. I discussed it with Al and he opined that no block
device should ever return a changed indication before the first open
has completed. If it cannot, it should refuse the open.

This only happens to devices which refuse to come online easily. Therefore,
I was going to fold a fix into a patch to add START STOP UNIT command.
It is not written yet.

The other side of this, the oops, is something for Viro/James/Axboe
to check out. It's entirely on their side. But of course, if ub quits
tripping the double registration condition, the problem of buggy
error paths in the block layer becomes moot. I'll work on it as soon
as possible.

-- Pete
