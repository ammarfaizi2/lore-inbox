Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWCTTfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWCTTfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWCTTfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:35:41 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:10954 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964864AbWCTTfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:35:38 -0500
Message-ID: <441F0352.758F0321@tv-sign.ru>
Date: Mon, 20 Mar 2006 22:32:34 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] simplify/fix first_tid()
References: <441DB045.87C4134C@tv-sign.ru>
		<m1fyldvvvo.fsf@ebiederm.dsl.xmission.com>
		<441EF4D7.AEC1AE8C@tv-sign.ru> <m1y7z5uepz.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> >> So we really still need the nr_threads test in there so we don't
> >> traverse the list twice everytime through readdir.
> >
> > How so? We don't do it twice?
> 
> In general user space does.  Because a read of 0 bytes signifies
> the end of a directory.
> 
> So we have 2 trips through proc_task_readdir initiated by user
> space.

Oh, thanks, you are right.

[PATCH] simplify-fix-first_tid-fix

Restore a stupidly deleted optimization.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/fs/proc/base.c~	2006-03-21 01:08:10.000000000 +0300
+++ MM/fs/proc/base.c	2006-03-21 01:14:36.000000000 +0300
@@ -2190,6 +2190,11 @@ static struct task_struct *first_tid(str
 			goto found;
 	}
 
+	/* If nr exceeds the number of threads there is nothing todo */
+	pos = NULL;
+	if (nr && nr >= get_nr_threads(leader))
+		goto out;
+
 	/* If we haven't found our starting place yet start
 	 * with the leader and walk nr threads forward.
 	 */
