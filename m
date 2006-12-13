Return-Path: <linux-kernel-owner+w=401wt.eu-S932605AbWLMHz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWLMHz1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 02:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWLMHz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 02:55:27 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:58355 "EHLO
	liaag2ag.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932605AbWLMHz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 02:55:26 -0500
Date: Wed, 13 Dec 2006 02:50:01 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@muc.de, vojtech@suse.cz
Message-ID: <200612130253_MC3-1-D4E3-471@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1165984783.23819.7.camel@localhost>

On Wed, 13 Dec 2006 05:39:43 +0100, Kasper Sandberg wrote:

> do you think it may be a bug in the kernel? the stuff with wine that
> gets thrown in the kernel messages?

Let's just say the behavior has changed.  It now returns
-EINVAL instead of -ENOTTY when the msdos IOCTLs fail.

> im 100% positive wine does NOT have
> access to any fat32, cause i entirely removed the only disk having such
> a filesystem, and it still likes to give this

That's when this happens: running certain programs that try
msdos-type IOCTLs on native Linux filesystems.

> however the last few
> times i havent observed the app going nuts

If there aren't any other problems you can just turn off the logging.

Did you change something else?

Anyway, here is a much simpler patch that restores the previous
behavior (but leaves the message.)  However if you aren't having
any problems now other than the messages maybe there's no real
problem after all?

--- 2.6.19.1-64smp.orig/fs/compat.c
+++ 2.6.19.1-64smp/fs/compat.c
@@ -444,7 +444,11 @@ asmlinkage long compat_sys_ioctl(unsigne
 
 		if (++count <= 50)
 			compat_ioctl_error(filp, fd, cmd, arg);
-		error = -EINVAL;
+
+		if (cmd == 0x82187201)
+			error = -ENOTTY;
+		else
+			error = -EINVAL;
 	}
 
 	goto out_fput;
-- 
MBTI: IXTP
