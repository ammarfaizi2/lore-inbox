Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUF1QXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUF1QXY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265057AbUF1QXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:23:23 -0400
Received: from fw-us-hou19.bmc.com ([198.207.223.240]:3912 "EHLO
	mangrove.bmc.com") by vger.kernel.org with ESMTP id S265055AbUF1QXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:23:17 -0400
Message-ID: <F12B6443B4A38748AFA644D1F8EF3532147334@bos-ex-01.adprod.bmc.com>
From: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
To: "'Andries Brouwer'" <aebr@win.tue.nl>,
       "Makhlis, Lev" <Lev_Makhlis@bmc.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [SYSVIPC] Change shm_tot from int to size_t
Date: Mon, 28 Jun 2004 11:22:55 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Fri, Jun 25, 2004 at 04:56:32PM -0500, Makhlis, Lev wrote:
> 
> > What do you think about following the example of sys_statfs 
> in sys_shmctl?
> 
> I don't mind. It is fairly unimportant - just the informative stuff
> printed by
> 
> % ipcs -m -l
> 
> ------ Shared Memory Limits --------
> max number of segments = 4096
> max seg size (kbytes) = 32768
> max total shared memory (kbytes) = 8388608
> min seg size (bytes) = 1
> 
> (but it seems a pity to deny user space this information if only
> one field is large).
> 

Yes, I thought it might be a little heavy-handed, but I figured, if it's
good enough for statfs...  Also, the values in "ipcs -m -l"
(1) come from IPC_INFO shmctl (separate from SHM_INFO) and
(2) are also available in /proc/sys/kernel (except for shmmin, which is
constant anyway).

On a tangential issue, I think it would be nice if an app could get the
actual values it wants, rather than just know that they are unreliable.
With statfs, that's possible thanks to the existence of statfs64, which
is 64-bit wide even in 32-bit world.
With {shm,sem,msg}ctl, we do have struct shminfo64 etc., but I'm not
sure why they exist at all, as they seem always to have the same bitness
as the default structures.
On the other hand, sys_shmctl() has forever had a comment about replacing
it with a /proc interface.  This has been done for {SHM,SEM,MSG}_STAT calls
(/proc/sysvipc/{shm,sem,msg}), but not for {IPC,SHM,SEM,MSG}_INFO calls.
Some of the *_INFO values are exposed in /proc, but only the sysctl-able
ones.
So I'm writing a patch to create /proc/sysvipc/{shm,sem,msg}info.  This
will allow ipcs and anyone else to access the values using a
bitness-agnostic
interface.  (But exactly because these values aren't that important, I'm
afraid no one may care enough to apply it.)
