Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWCBKZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWCBKZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCBKZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:25:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10175 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750983AbWCBKZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:25:15 -0500
Date: Thu, 2 Mar 2006 02:23:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5 OOM regression
Message-Id: <20060302022356.5fad2e08.akpm@osdl.org>
In-Reply-To: <4405F929.2030609@keyaccess.nl>
References: <4405F929.2030609@keyaccess.nl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman <rene.herman@keyaccess.nl> wrote:
>
> I was playing with "slabtop" (a /proc/slabinfo display tool) while 
>  running a little memory-eater app in a different xterm:
> 
>  === pig.c
> 
>  #include <stdlib.h>
> 
>  int main(void)
>  {
>  	unsigned char *p;
> 
>  	while ((p = malloc(4096)))
>  		*p = 0;
>  	return 0;
>  }
> 
>  ===
> 
>  I was expecting the oom-killer but instead had X freeze on me entirely. 
>    No keyboard or mouse, and while the machine does still ping in this 
>  state, also no rlogins. This does not happen in 2.6.15.4 -- there the 
>  oom-killer will kill the eater app (sometimes including the xterm it's 
>  in, sometimes not, but not a problem).
> 
>  The 2.6.16-rc5 freeze is "highly repeatable", meaning not always, but 
>  very often. It seems that having for example Firefox loaded increases 
>  the chances of a full freeze, but that might just be chance as well.

crap, thanks.  I would appear to have broken one of Christoph's patches for
him.

--- devel/mm/oom_kill.c~out_of_memory-locking-fix	2006-03-02 02:17:00.000000000 -0800
+++ devel-akpm/mm/oom_kill.c	2006-03-02 02:17:22.000000000 -0800
@@ -355,6 +355,7 @@ retry:
 	}
 
 out:
+	read_unlock(&tasklist_lock);
 	cpuset_unlock();
 	if (mm)
 		mmput(mm);
_

