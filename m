Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVCaKBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVCaKBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVCaKBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:01:10 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:48655 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S261202AbVCaKAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:00:32 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: Jacek =?iso-8859-2?Q?=A3uczak?= <difrost@pin.if.uz.zgora.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <424AE48C.8000805@pin.if.uz.zgora.pl>
References: <424AE48C.8000805@pin.if.uz.zgora.pl>
Content-Type: text/plain; charset=iso-8859-2
Date: Thu, 31 Mar 2005 12:00:30 +0200
Message-Id: <1112263230.1165.15.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 19:40 +0200, Jacek £uczak wrote:
> Hi
> 
> I made some tests and almost all Linux distros brings down while freebsd 
> survive!Forkbombing is a big problem but i don't think that something like
> 
> max_threads = mempages / (16 * THREAD_SIZE / PAGE_SIZE);
> 
> is good solution!!!
> How about add max_user_threads to the kernel? It could be tunable via 
> proc filesystem. Limit is set only for users.
> I made a fast:) patch - see below - and test it on 2.6.11, 
> 2.6.11ac4,2.6.12rc1...works great!!!New forks are stoped in 
> copy_process() before dup_task_struct() and EAGAIN is returned. System 
> works without any problems and root can killall -9 forkbomb.
> 

I really liked this approach because:

* it is similar to other *nixes. (freebsd, openbsd)

* it is easily tuneable (/proc or systcl)

* it is stupid simple - small chance that things can go wrong.

* this solves *many* things in comparation to possible problems it
causes.

Only thing that could be a problem that I come to think of is that you
cannot raise the limit through /etc/security/limits.conf or similar. Eg.
you migh want all setuid() services/daemons run with a low limit but you
want give user Bob more processes. (I don't know if this is a realistic
situation though)

The default value could be something like:

max_user_threads = max_threads / 2

or:

max_user_threads = max_threads / 4;

With a lower limit to 20 or something, just like max_threads (in case
you try run Linux on 2MiB RAM)

If a fixed value (like 300, 512, 2000) is used then will probably
systems with low amount of RAM be vulerable to the forkbomb attack.

--
Natanael Copa


