Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263979AbUFKSbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUFKSbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 14:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUFKSbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 14:31:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11984 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263979AbUFKSbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 14:31:21 -0400
Date: Fri, 11 Jun 2004 19:31:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparse: __user annotations for ipc compat code
Message-ID: <20040611183120.GP12308@parcelfarce.linux.theplanet.co.uk>
References: <200406111727.31160.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406111727.31160.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 05:27:30PM +0200, Arnd Bergmann wrote:
> -		fourth.__pad = &s64;
> +		fourth.__pad = (void __user *)&s64;

That makes absolutely no sense (and should generate a warning anyway).
This is _NOT_ a userland pointer.  Obviously so - we are talking about
on-stack address, for crying out loud!

>  	old_fs = get_fs();
>  	set_fs(KERNEL_DS);
> -	err = sys_msgsnd(first, p, second, third);
> +	err = sys_msgsnd(first, (struct msgbuf __user *)p, second, third);
>  	set_fs(old_fs);

Again, makes no sense whatsoever (we _still_ get a warning and clear fix
would be to get rid of set_fs() here and switch to compat_alloc_user_space()).

Same goes for the rest of patch.

Folks, warnings are not personal performance metrics, they are tools for
finding bogus code.  Sigh...
