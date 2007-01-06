Return-Path: <linux-kernel-owner+w=401wt.eu-S1750949AbXAFAmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbXAFAmy (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 19:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbXAFAmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 19:42:54 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46503 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbXAFAmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 19:42:54 -0500
Date: Fri, 5 Jan 2007 16:42:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Tom Lanyon" <tomlanyon@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: runaway loop modprobe binfmt-0000
Message-Id: <20070105164249.f79630a0.akpm@osdl.org>
In-Reply-To: <cd32a0620701051513i41e19d13k53d08d123980a717@mail.gmail.com>
References: <cd32a0620701051513i41e19d13k53d08d123980a717@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007 09:43:14 +1030
"Tom Lanyon" <tomlanyon@gmail.com> wrote:

> How can I discover
> what is trying to load binfmt-0000 and why is it looping?

Start with this, I guess..

--- a/kernel/kmod.c~a
+++ a/kernel/kmod.c
@@ -98,10 +98,12 @@ int request_module(const char *fmt, ...)
 	atomic_inc(&kmod_concurrent);
 	if (atomic_read(&kmod_concurrent) > max_modprobes) {
 		/* We may be blaming an innocent here, but unlikely */
-		if (kmod_loop_msg++ < 5)
+		if (kmod_loop_msg++ < 5) {
 			printk(KERN_ERR
 			       "request_module: runaway loop modprobe %s\n",
 			       module_name);
+			dump_stack();
+		}
 		atomic_dec(&kmod_concurrent);
 		return -ENOMEM;
 	}
_

