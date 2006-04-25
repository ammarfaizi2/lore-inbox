Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWDYNKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWDYNKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 09:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWDYNKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 09:10:30 -0400
Received: from sccrmhc11.comcast.net ([204.127.200.81]:7361 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932203AbWDYNKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 09:10:30 -0400
Message-ID: <444E1FC4.3020202@acm.org>
Date: Tue, 25 Apr 2006 08:10:28 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ipmi: strstrip conversion
References: <1145956267.27659.24.camel@localhost>
In-Reply-To: <1145956267.27659.24.camel@localhost>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a little less efficient, but certainly a lot cleaner to do it this
way.  It's not critical code, so I'm happy with this change.

-Corey

Pekka Enberg wrote:

>From: Pekka Enberg <penberg@cs.helsinki.fi>
>
>This patch switches an open-coded strstrip to use the new API.
>
>Cc: Corey Minyard <minyard@acm.org>
>Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
>
>---
>
> drivers/char/ipmi/ipmi_watchdog.c |   25 +++++++++----------------
> 1 files changed, 9 insertions(+), 16 deletions(-)
>
>342eaae5800b0fd002f5101d66ccb02e786016d8
>diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
>index 2d11ddd..8f88671 100644
>--- a/drivers/char/ipmi/ipmi_watchdog.c
>+++ b/drivers/char/ipmi/ipmi_watchdog.c
>@@ -212,24 +212,16 @@ static int set_param_str(const char *val
> {
> 	action_fn  fn = (action_fn) kp->arg;
> 	int        rv = 0;
>-	const char *end;
>-	char       valcp[16];
>-	int        len;
>-
>-	/* Truncate leading and trailing spaces. */
>-	while (isspace(*val))
>-		val++;
>-	end = val + strlen(val) - 1;
>-	while ((end >= val) && isspace(*end))
>-		end--;
>-	len = end - val + 1;
>-	if (len > sizeof(valcp) - 1)
>-		return -EINVAL;
>-	memcpy(valcp, val, len);
>-	valcp[len] = '\0';
>+	char       *dup, *s;
>+
>+	dup = kstrdup(val, GFP_KERNEL);
>+	if (!dup)
>+		return -ENOMEM;
>+
>+	s = strstrip(dup);
> 
> 	down_read(&register_sem);
>-	rv = fn(valcp, NULL);
>+	rv = fn(s, NULL);
> 	if (rv)
> 		goto out_unlock;
> 
>@@ -239,6 +231,7 @@ static int set_param_str(const char *val
> 
>  out_unlock:
> 	up_read(&register_sem);
>+	kfree(dup);
> 	return rv;
> }
> 
>  
>

