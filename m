Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVKGMAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVKGMAb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbVKGMAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:00:31 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:21649 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751347AbVKGMAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:00:31 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Mon,  7 Nov 2005 13:00:13 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org, linux-audit@redhat.com
Subject: Re: 2.6.14-mm1
In-reply-to: <20051106182447.5f571a46.akpm@osdl.org>
Message-Id: <20051107120012.48D7C22AF77@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>Changes since 2.6.14-rc5-mm1:
>
[...]
> git-audit.patch
There are many errors produced by this patch. I don't have any security model
enabled and in audit_ipc_context security_ipc_getsecurity returns -EOPNOTSUPP,
that causes audit_panic("error in audit_ipc_context");

>char *audit_ipc_context(struct kern_ipc_perm *ipcp)
>{
>	struct audit_context *context = current->audit_context;
>	char *ctx = NULL;
>	int len = 0;
>
>	if (likely(!context))
>		return NULL;
>
>	len = security_ipc_getsecurity(ipcp, NULL, 0);
This fails here with -EOPNOTSUPP, and it goes to the error_path label. 

>	if (len < 0)
>		goto error_path;
>
>	ctx = kmalloc(len, GFP_ATOMIC);
>	if (!ctx)
>		goto error_path;
>
>	len = security_ipc_getsecurity(ipcp, ctx, len);
>	if (len < 0)
>		goto error_path;
>
>	return ctx;
>
>error_path:
>	if (ctx)
>		kfree(ctx);
>	audit_panic("error in audit_ipc_context");
>	return NULL;
>}
There should be something like if (len == -EOPNOTSUPP) goto ret, where ret
should be right before return NULL. Or am I missing something? David, it's from
your tree, do you have any comments, ideas?

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
