Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVIWRmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVIWRmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVIWRmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:42:25 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:27354 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750841AbVIWRmY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:42:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BynneEdjm/C3TzAThxekMJUPUqkmKW8PuRNNqZs3WgyZawPOqVSLTS/dXVedgd+V5dollozHstiRbgrUKtECUHQ4rBzmx831/fXP/MZsP2h04GgRWjqp30j5w5i6YMxMTgC4N58z8bF172sXQTM21BGa5IgAR56u7CQMLbcG3Z4=
Message-ID: <29495f1d0509231042139e9b94@mail.gmail.com>
Date: Fri, 23 Sep 2005 10:42:23 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch] Make epoll_wait() handle negative timeouts as MAX_SCHEDULE_TIMEOUT ...
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0509231031570.10222@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.63.0509231031570.10222@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, Davide Libenzi <davidel@xmailserver.org> wrote:
>
> As reported by Vadim Lobanov, epoll_wait() did not handle correctly
> timeouts <0 (only the -1 case was MAX_SCHEDULE_TIMEOUT'd).
>
>
> Signed-off-by: Davide Libenzi <davidel@xmailserver.org>

Arrgggh, this is as wrong as sys_poll() was before! :)

--- a/fs/eventpoll.c	2005-09-23 10:06:45.000000000 -0700
+++ b/fs/eventpoll.c	2005-09-23 10:09:35.000000000 -0700
@@ -1507,7 +1507,7 @@
 	 * and the overflow condition. The passed timeout is in milliseconds,
 	 * that why (t * HZ) / 1000.
 	 */
-	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
+	jtimeout = timeout < 0 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?

@timeout is in miliseconds, per the comment, yes? If so, then

timeout [msecs] > MAX_SCHEDULE_TIMEOUT [jiffies] - 1000 [jiffies] / HZ
[jiffies / sec]

compares milliseconds to seconds! (Don't worry, sys_poll() had the
same error for a long time). There is a patch in 2.6.14-rc2-mm1 for
sys_poll() to fix the handling of long timeouts, please take a look
and maybe apply the same ideas to epoll(). Alexey Dobriyan has filed a
regression against the patch, but I'm unable to reproduce it (and it
could be an app depending on the old broken behavior).

Thanks,
Nish
