Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbTGOHls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 03:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266823AbTGOHlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 03:41:47 -0400
Received: from rth.ninka.net ([216.101.162.244]:26764 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S266813AbTGOHlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 03:41:37 -0400
Date: Tue, 15 Jul 2003 00:56:17 -0700
From: "David S. Miller" <davem@redhat.com>
To: "B. D. Elliott" <bde@nwlink.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: Stime/Settimeofday are still broken
Message-Id: <20030715005617.39f55582.davem@redhat.com>
In-Reply-To: <20030715071826.A891F6AB63@smtp4.pacifier.net>
References: <20030715071826.A891F6AB63@smtp4.pacifier.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 00:40:49 -0700
"B. D. Elliott" <bde@nwlink.com> wrote:

> The problems described below still exist in -2.6.0-test1.

Ignore my previous reply, not a Sparc problem obviously
but a generic one, sorry.

Andrew, he's right, we need to fix this and his patch looks
perfectly fine.

> >Date: Wed, 18 Jun 2003 00:57:12 -0700
> >From: "B. D. Elliott" <bde@nwlink.com>
> >To: linux-kernel@vger.kernel.org
> >Subject: Sparc64-2.5.72: A Serious Time Problem
> >Mail-Followup-To: linux-kernel@vger.kernel.org
> >Mime-Version: 1.0
> >Content-Type: text/plain; charset=us-ascii
> >Content-Disposition: inline
> >User-Agent: Mutt/1.5.4i
> >Message-Id: <20030618073556.94E966A4FC@smtp4.pacifier.net>
> >Status: RO
> >Content-Length: 1651
> >Lines: 47
> >
> >There is a serious bug in setting time on 64-bit sparcs (and probably other
> >64-bit systems).  The symptom is that ntpdate or date set the time back to
> >1969 or 1970.  The underlying problems are that stime is broken, and any
> >settimeofday call fails with a bad fractional value.  Ntpdate falls back to
> >stime when settimeofday fails.
> >
> >The settimeofday problem is that the timeval and timespec structures are not
> >the same size.  In particular, the fractional part is an int in timeval, and
> >a long in timespec.  The stime problem is that the argument is not an int,
> >but a time_t, which is long on at least some 64-bit systems.
> >
> >The following patch appears to fix this on my sparc64.
> >
> >===================================================================
> >--- ./kernel/time.c.orig	2003-06-16 22:36:04.000000000 -0700
> >+++ ./kernel/time.c	2003-06-18 00:00:43.000000000 -0700
> >@@ -66,7 +66,7 @@
> >  * architectures that need it).
> >  */
> >  
> >-asmlinkage long sys_stime(int * tptr)
> >+asmlinkage long sys_stime(time_t * tptr)
> > {
> > 	struct timespec tv;
> > 
> >@@ -162,13 +162,15 @@
> > 
> > asmlinkage long sys_settimeofday(struct timeval __user *tv, struct timezone __user *tz)
> > {
> >+	struct timeval user_tv;
> > 	struct timespec	new_tv;
> > 	struct timezone new_tz;
> > 
> > 	if (tv) {
> >-		if (copy_from_user(&new_tv, tv, sizeof(*tv)))
> >+		if (copy_from_user(&user_tv, tv, sizeof(*tv)))
> > 			return -EFAULT;
> >-		new_tv.tv_nsec *= NSEC_PER_USEC;
> >+		new_tv.tv_sec = user_tv.tv_sec;
> >+		new_tv.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
> > 	}
> > 	if (tz) {
> > 		if (copy_from_user(&new_tz, tz, sizeof(*tz)))
> >===================================================================
> 
> -- 
> B. D. Elliott   bde@nwlink.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
