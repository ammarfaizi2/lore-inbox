Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWEPOCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWEPOCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWEPOCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:02:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751105AbWEPOCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:02:53 -0400
Date: Tue, 16 May 2006 06:58:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernd Schmidt <bernds_cb1@t-online.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, luke.yang@analog.com,
       gerg@snapgear.com
Subject: Re: Please revert git commit 1ad3dcc0
Message-Id: <20060516065848.13028f9f.akpm@osdl.org>
In-Reply-To: <4469B63B.6000502@t-online.de>
References: <4469B63B.6000502@t-online.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schmidt <bernds_cb1@t-online.de> wrote:
>
> Linus, Andrew,
> 
> please revert 1ad3dcc0.  That was a patch to the binfmt_flat loader, 
> which was motivated by an LTP testcase which checks that execve returns 
> EMFILE when the file descriptor table is full.
> 
> The patch is buggy: the code now keeps file descriptors open for the 
> executable and its libraries, which has confused at least one 
> application.  It's also unnecessary, since there is no code that uses 
> the file descriptor, so the new EMFILE error return is totally artificial.
> 
> The reversion is
> Signed-off-by: Bernd Schmidt <bernd.schmidt@analog.com>
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> and I think Luke had no objections either.
> 

I don't get it.  The substance of the patch is

+	/* check file descriptor */
+	exec_fileno = get_unused_fd();
+	if (exec_fileno < 0) {
+		ret = -EMFILE;
+		goto err;
+	}
+	get_file(bprm->file);
+	fd_install(exec_fileno, bprm->file);

and that get_file() will be undone by exit().  Without this change we'll
forget to do file limit checking.

So.. please tell us much more about the problem.
