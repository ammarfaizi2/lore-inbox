Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267351AbUBSQSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUBSQSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:18:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:27367 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267351AbUBSQSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:18:08 -0500
Date: Thu, 19 Feb 2004 08:10:40 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jan Marek <linux@hazard.jcu.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.3-mm1][PROBLEM] Apache cannot start
Message-Id: <20040219081040.6c56b801.rddunlap@osdl.org>
In-Reply-To: <20040219131221.GA1328@hazard.jcu.cz>
References: <20040219131221.GA1328@hazard.jcu.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 14:12:21 +0100 Jan Marek <linux@hazard.jcu.cz> wrote:

| Hallo lkml,
| 
| I have problem with kernel 2.6.3-mm1: apache cannot start. Some last
| lines from strace output:
| 
| 3299  shmget(IPC_PRIVATE, 737284, IPC_CREAT|0600) = 393216
| 3299  shmat(393216, 0, 0)               = -1 EINVAL (Invalid argument)
| 3299  time(NULL)                        = 1077193406
| 3299  write(15, "[Thu Feb 19 13:23:26 2004] [emer"..., 69) = 69
| 3299  shmctl(393216, IPC_64|IPC_RMID, 0) = 0
| 3299  munmap(0x40018000, 4096)          = 0
| 3299  exit_group(2)                     = ?
| 
| I think, that problem is in the calling shmat function?
| 
| My last kernel was 2.6.2-mm1 and here apache went without problems...


Patch from Andrew is below.

--
~Randy



diff -puN ipc/shm.c~add-syscalls_h-shmat-fix ipc/shm.c
--- 25/ipc/shm.c~add-syscalls_h-shmat-fix	2004-02-18 01:22:41.000000000 -0800
+++ 25-akpm/ipc/shm.c	2004-02-18 01:22:41.000000000 -0800
@@ -635,7 +635,7 @@ out:
  * "raddr" thing points to kernel space, and there has to be a wrapper around
  * this.
  */
-long sys_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
+asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
 {
 	struct shmid_kernel *shp;
 	unsigned long addr;
