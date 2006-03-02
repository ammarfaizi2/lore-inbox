Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWCBJS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWCBJS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 04:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWCBJS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 04:18:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932149AbWCBJS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 04:18:56 -0500
Date: Thu, 2 Mar 2006 01:17:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: J M Cerqueira Esteves <jmce@artenumerica.com>
Cc: linux-kernel@vger.kernel.org, support@artenumerica.com
Subject: Re: oom-killer: gfp_mask=0xd1  with 2.6.12 on EM64T
Message-Id: <20060302011735.55851ca2.akpm@osdl.org>
In-Reply-To: <4405D383.5070201@artenumerica.com>
References: <4405D383.5070201@artenumerica.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J M Cerqueira Esteves <jmce@artenumerica.com> wrote:
>
> On a dual EM64T Xeon with 4GB of RAM, I am getting apparently "innocent"
>  processes killed by oom-killer with gfp_mask=0xd1 (with all or almost
>  all swap space still available).
> 

That's quite an old kernel.  If this is the notorious bio-uses-GFP_DMA bug
then I'd have expected this kernel to be useless from day one.  Did you
install it recently?

>  I haven't tried 2.6.15 kernels yet, but according to recent reports in
>  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175173
>  even those may still have oom-killer problems (like this?).

Yes, I expect it's the same still-unfixed bug.

If you're feeling keen you could add this patch which would confirm it:

--- devel/mm/oom_kill.c~a	2006-03-02 01:16:17.000000000 -0800
+++ devel-akpm/mm/oom_kill.c	2006-03-02 01:16:32.000000000 -0800
@@ -258,6 +258,8 @@ void out_of_memory(unsigned int __nocast
 	struct mm_struct *mm = NULL;
 	task_t * p;
 
+	dump_stack();
+
 	read_lock(&tasklist_lock);
 retry:
 	p = select_bad_process();
_


And if it's that bug then I'm afraid you'll have to sit tight until 2.6.16.
We shouldn't release 2.6.16 until this thing is fixed.

