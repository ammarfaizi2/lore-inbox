Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWITVaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWITVaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWITVaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:30:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932133AbWITVay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:30:54 -0400
Date: Wed, 20 Sep 2006 14:30:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC][PATCH -mm] replace cad_pid by a struct pid
Message-Id: <20060920143028.fd446145.akpm@osdl.org>
In-Reply-To: <45110C1B.7020304@fr.ibm.com>
References: <45110C1B.7020304@fr.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 11:38:35 +0200
Cedric Le Goater <clg@fr.ibm.com> wrote:

> There are a few places in the kernel where the init task is
> signaled. The ctrl+alt+del sequence is one them. It kills a task,
> usually init, using a cached pid (cad_pid).
> 
> This patch replaces the pid_t by a struct pid to avoid pid wrap around
> problem. The struct pid is initialized at boot time in init() and can
> be modified through systctl with
> 
> 	/proc/sys/kernel/cad_pid

hm.  Is there any sane scenario in which C-A-D would be directed to any
other process?

What happens if/when the process which is identifier by
/proc/sys/kernel/cad_pid exits?  User error, I guess...

> +extern struct pid* cad_pid;

Whitespace violation detected!

> -	if (shuting_down || kill_proc(1, SIGINT, 1)) {
> +	if (shuting_down || kill_cad_pid(SIGINT, 1)) {

So your patch actually makes functional changes: lots of random
init-signallers gain extra functionality: the process which they signal can
now be configured via /proc/sys/kernel/cad_pid.  But by default, things
remain unchanged.  Fair enough.


> --- 2.6.18-rc7-mm1.orig/drivers/char/nwbutton.c
> +++ 2.6.18-rc7-mm1/drivers/char/nwbutton.c

This driver can be compiled as a module.  I shall add the missing export...

(And I'll fix the parisc build too)
