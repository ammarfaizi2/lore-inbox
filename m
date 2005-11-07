Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVKGRKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVKGRKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVKGRKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:10:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41372 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932316AbVKGRK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:10:29 -0500
Date: Mon, 7 Nov 2005 17:47:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, patrizio.bassi@gmail.com
Cc: shaohua.li@intel.com
Subject: Re: 2.6.14-git4 suspend fails: kernel NULL pointer dereference
Message-ID: <20051107164715.GA1534@elf.ucw.cz>
References: <20051006072749.GA2393@spitz.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006072749.GA2393@spitz.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> echo shutdown > /sys/power/disk
> echo disk > /sys/power/state
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> EIP:    0060:[<c0132a5e>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.14-git4)
> EIP is at enter_state+0xe/0x90

It works for me, with pretty recent tree. But I see a potential
problem there, you are not using ACPI, right?

I think it is caused by this commit:

commit eb9289eb20df6b54214c45ac7c6bf5179a149026
tree dac51cecdd94e0c7273c990259ddd800057311b9
parent 0245b3e787dc3267a915e1f56419e7e9c197e148
author Shaohua Li <shaohua.li@intel.com> Sun, 30 Oct 2005 15:00:01
-0800
committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 30 Oct 2005
17:37:15 -0800

    [PATCH] introduce .valid callback for pm_ops

    Add pm_ops.valid callback, so only the available pm states show in
    /sys/power/state.  And this also makes an earlier states error
report at
    enter_state before we do actual suspend/resume.

Try this patch.

							Pavel

diff --git a/kernel/power/main.c b/kernel/power/main.c
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -167,7 +167,7 @@ static int enter_state(suspend_state_t s
 {
 	int error;
 
-	if (pm_ops->valid && !pm_ops->valid(state))
+	if (pm_ops && pm_ops->valid && !pm_ops->valid(state))
 		return -ENODEV;
 	if (down_trylock(&pm_sem))
 		return -EBUSY;


-- 
Thanks, Sharp!
