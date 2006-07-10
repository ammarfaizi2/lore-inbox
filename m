Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWGJVnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWGJVnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWGJVnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:43:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964900AbWGJVnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:43:45 -0400
Date: Mon, 10 Jul 2006 14:43:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH -mm] sysfs_remove_bin_file: no return value, no check
 needed
Message-Id: <20060710144342.2efc174c.akpm@osdl.org>
In-Reply-To: <20060710122910.08c01f46.rdunlap@xenotime.net>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<20060710122910.08c01f46.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 12:29:10 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> >   In some cases (eg, sysfs file removal) there's not a lot the caller can do
> >   apart from warn, so we should probably change those things to return void
> >   and put a diagnostic message into the callee itself.
> 
> sysfs_remove_bin_file() cannot tell if there is an error and
> cannot return an error, so "fix" around 40 must-check warnings.
> 
> Convert sysfs_remove_bin_file() from int to void since it
>   cannot return an error.
> Remove __must_check from its declaration.
> Convert the only function that checked the return value of
>   sysfs_remove_bin_file().
> 

Yes, I think that's the best way to handle this case.

But it's still an error if the file isn't there, or if the removal fails
for some other reason.  It means that someone tried to remove a file which
they didn't add, and that a subsequent attempt to add that file will fail,
etc.

So I think a better policy would be to emit a warning from within
sysfs_remove_bin_file(), then return void.  The warning should include the
stack trace and the filename (if poss).

