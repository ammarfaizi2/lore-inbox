Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbTLaUUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 15:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbTLaUUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 15:20:15 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:7577 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265256AbTLaUUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 15:20:09 -0500
Subject: Re: [PATCH 1/2] kthread_create
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rusty@rustcorp.com.au, jgarzik@pobox.com, benh@kernel.crashing.org,
       akpm@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1072893730.828.7255.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 Dec 2003 13:02:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct task_struct *kthread_create(int (*initfn)(void *data),
> +       int (*corefn)(void *data),
> +       void *data,
> +       const char namefmt[],
> +       ...)
> +{
> + va_list args;
> + struct kthread_create kc;
> + DECLARE_WORK(work, spawn_kthread, &kc);
> + /* Or, as we like to say, 16. */
> + char name[sizeof(((struct task_struct *)0)->comm)];
> +
> + va_start(args, namefmt);
> + vsnprintf(name, sizeof(name), namefmt, args);
> + va_end(args);
> +
> + init_completion(&kc.done);
> + kc.k.initfn = initfn;
> + kc.k.corefn = corefn;
> + kc.k.data = data;
> + kc.k.name = name;

Since processor ID info is available, there's no
need for per-CPU naming. (I do realize it may be
per-disk or per-filesystem though)

With the huge NUMA boxes, a simple "ps -ef" is
going to look insane. How about task groups for
them? Then the various threads wind up being
seen as just that, threads.

BTW, some (p->pid==0) tests may need to become
(p->tgid==0) tests instead.


