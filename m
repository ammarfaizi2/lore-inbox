Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWGKB7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWGKB7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 21:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWGKB7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 21:59:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:35890 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965049AbWGKB7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 21:59:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=owkwX0rviUJjD4qPoq0R502s2cGaXxX7DzUcbsoX/+gLw93MwRBtNH3VgZLZO1j1QbRMUjf4qfEx2akrkKkvvU0vnM6hWn62J0tcAFOipGasr6h/Yy/cYCx2CJ77I5Syjo09preGjKiDIYs/jwz3GG704b/zQF5GVbOjk+c+xAE=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Andrea Arcangeli <andrea@cpushare.com>
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Date: Mon, 10 Jul 2006 21:59:09 -0400
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org, mingo@elte.hu
References: <20060629192121.GC19712@stusta.de> <1151679780.32444.21.camel@mindpipe> <20060708092313.GD5135@opteron.random>
In-Reply-To: <20060708092313.GD5135@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 05:23, Andrea Arcangeli wrote:
..
> (note that unless you sell cpu through CPUShare
> actively this overhead consists in two cacheline touches per context
> switch),

It's probably not worth the complication, but I suppose that could be
reduced to one cacheline by lazily enabling the TSC access.

...
> +	  This feature mathematically prevents covert channels
> +	  for tasks running under SECCOMP.

I disagree with this wording. First, for most users the worry isn't so
much covert channels, as it is side channels. In other words, the
worry is not so much that data is sent to the SECCOMP process
secretly, as that the data could be sensitive. Second, the feature
closes one only one type of side-channel; others may still exist. It's
quite possible for cpu bugs or undefined behaviour to reveal internal
cpu state (possibly affected by another process) without otherwise
being security risks. (In my uninformed opinion). I wouldn't worry
about such side channels myself, but they do likely exist.

Suggested wording as a patch against 2.6.18-rc1-mm1:
------

Change help text for SECCOMP_DISABLE_TSC to warn about
side channels (the larger concern) instead of covert channels.

signed-off-by: Andrew Wade <andrew.j.wade@gmail.com>
---

diff -rupN a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2006-07-10 21:00:37.000000000 -0400
+++ b/arch/i386/Kconfig	2006-07-10 21:37:12.000000000 -0400
@@ -748,12 +748,12 @@ config SECCOMP_DISABLE_TSC
 	depends on SECCOMP
 	default n
 	help
-	  This feature mathematically prevents covert channels
-	  for tasks running under SECCOMP. This can generate
-	  a minuscule overhead in the scheduler.
+	  This feature closes potential side channels for tasks
+	  running under SECCOMP. Enabling this can generate a
+	  miniscule overhead in the scheduler.
 
 	  If you care most about performance say N. Say Y only if you're
-	  paranoid about covert channels.
+	  paranoid about security.
 
 config VGA_NOPROBE
        bool "Don't probe VGA at boot" if EMBEDDED
diff -rupN a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	2006-07-10 21:00:40.000000000 -0400
+++ b/arch/x86_64/Kconfig	2006-07-10 21:44:59.000000000 -0400
@@ -537,12 +537,12 @@ config SECCOMP_DISABLE_TSC
 	depends on SECCOMP
 	default n
 	help
-	  This feature mathematically prevents covert channels
-	  for tasks running under SECCOMP. This can generate
-	  a minuscule overhead in the scheduler.
+	  This feature closes potential side channels for tasks
+	  running under SECCOMP. Enabling this can generate a
+	  miniscule overhead in the scheduler.
 
 	  If you care most about performance say N. Say Y only if you're
-	  paranoid about covert channels.
+	  paranoid about security.
 
 source kernel/Kconfig.hz
 
