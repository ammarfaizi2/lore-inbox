Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265757AbUADQhU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265756AbUADQhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:37:20 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:8204 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265757AbUADQhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:37:12 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH]: Fw: [Bugme-new] [Bug 1242] New: devfs oops with SMP kernel (not in UP mode)
Date: Sun, 4 Jan 2004 19:32:40 +0300
User-Agent: KMail/1.5.3
References: <20030915212755.5017acc7.akpm@osdl.org>
In-Reply-To: <20030915212755.5017acc7.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Pavel Roskin <proski@gnu.org>,
       kpfleming@cox.net
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401041932.40960.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 September 2003 08:27, Andrew Morton wrote:
> Andrey,
>
> didn't we fix this?
>
>

Sorry for delay. Oops is due to concurrent d_instantiate on the same dentry; 
the bug was unfortunately quite ugly to fix inside devfs itself.

The attached patch makes sure d_revalidate is always called under parent i_sem 
allowing it to drop and reacquire semaphore before going to wait. It provides 
both mutual exclusion with devfs_lookup and between d_revalidate, fixing

- this bug; unfortunately I do not know how to reproduce it on purpose. It 
apparently needs at least true SMP that I do not have. We need two 
d_revalidate's against the same dentry running concurrently

- old devfs_lookup/d_revalidate deadlock (which has been fixed a bit 
differently before). This I can test using old tests.

- theoretically possible problem when dentry->d_op is changed after 
d_op->d_revalidate has been tested resulting in NULL pointer dereferencing 
(if (dentry->d_op->d_revalidate) dentry->d_op->d_revalidate). I am not even 
sure if it is really possible.

Pavel, you have been lucky in cathing devfs bugs, could you please test this 
if it works for you?

I appreciate comments about fs/namei.c changes. I tried to make them as 
non-intrusive as possible. Believe me - it is the most simple way to close 
devfs races.

with this resolved we can start cleaning devfs; my final goal is to autoremove 
unneeded path components and get rid of devfs_name alltogether. Now when 
every driver has kernel name it is enough to register using this one letting 
devfsd to do the rest.

regards

-andrey

> Begin forwarded message:
>
> Date: Mon, 15 Sep 2003 21:03:04 -0700
> From: bugme-daemon@osdl.org
> To: bugme-new@lists.osdl.org
> Subject: [Bugme-new] [Bug 1242] New: devfs oops with SMP kernel (not in UP
> mode)
>
>
> http://bugme.osdl.org/show_bug.cgi?id=1242
>
>            Summary: devfs oops with SMP kernel (not in UP mode)
>     Kernel Version: 2.6.0-test5
>             Status: NEW
>           Severity: normal
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: kpfleming@cox.net
>
>
> Distribution: homegrown
> Hardware Environment: Intel L440GX+ with 2 Pentium III 750 CPUs, 512MB RAM
> Software Environment: kernel and LFS-built system
> Problem Description: During system startup, rapid activity (filesystem
> mounting and other) causes this oops. It can appear in various processes,
> but the call trace is always as attached. In this case, the process that
> got oops'ed was a simple bash script to mount the sysfs filesystem on /sys
> (the oops occurred during the mount operation itself as best I can tell).
> The oops does not occur on the same system with kernel recompiled with SMP
> turned off.
>
> Steps to reproduce: Boot my system with an SMP kernel :-)
>
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.

