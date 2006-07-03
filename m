Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWGCKjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWGCKjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWGCKjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:39:40 -0400
Received: from canuck.infradead.org ([205.233.218.70]:16005 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751086AbWGCKjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:39:40 -0400
Subject: Re: [PATCH 1/2] Support TIF_RESTORE_SIGMASK on x86_64
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@muc.de, drepper@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060703031937.274aa506.akpm@osdl.org>
References: <1151919711.3000.82.camel@pmac.infradead.org>
	 <20060703031937.274aa506.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 11:39:31 +0100
Message-Id: <1151923171.12290.6.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 03:19 -0700, Andrew Morton wrote:
> Could you please describe the signal mask fix? 

@@ -583,7 +583,7 @@
        if (!user_mode(regs))
                return;

-       if (!test_thread_flag(TIF_RESTORE_SIGMASK))
+       if (test_thread_flag(TIF_RESTORE_SIGMASK))
                oldset = &current->saved_sigmask;
        else
                oldset = &current->blocked;


>  Is that likely to have caused the above symptoms?

Yeah, it'll screw up the signal mask all over the place. 
cf. https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=180567
also https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=179228

> Should we be setting TASK_INTERRUPTIBLE before releasing that lock?

Before releasing current->sighand->siglock? Nah, schedule() will check
for pending signals -- it's not like racing with a wake_up() 

-- 
dwmw2

