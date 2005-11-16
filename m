Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVKPIcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVKPIcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbVKPIcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:32:12 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:44944 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030223AbVKPIcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:32:11 -0500
Date: Wed, 16 Nov 2005 09:32:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Knecht <markknecht@gmail.com>, pavel@suse.cz,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt] race condition in fs/compat.c with compat_sys_ioctl
Message-ID: <20051116083214.GA14829@elte.hu>
References: <1131821278.5047.8.camel@localhost.localdomain> <5bdc1c8b0511121725u6df7ad9csb9cb56777fa6fe64@mail.gmail.com> <Pine.LNX.4.58.0511122149020.25152@localhost.localdomain> <5bdc1c8b0511121914v12dc4402u424fbaf416bf3710@mail.gmail.com> <1131853456.5047.14.camel@localhost.localdomain> <5bdc1c8b0511130634h501fb565v58906bdfae788814@mail.gmail.com> <1131994030.5047.17.camel@localhost.localdomain> <5bdc1c8b0511141057l60a2e778x89155cd5484d532f@mail.gmail.com> <1132115386.5047.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132115386.5047.61.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

>  	down_read(&ioctl32_sem);
>  	for (t = ioctl32_hash_table[ioctl32_hash(cmd)]; t; t = t->next) {
> -		if (t->cmd == cmd)
> +		if (t->cmd == cmd) {
> +			handler = t->handler;
> +			up_read(&ioctl32_sem);
>  			goto found_handler;
> +		}
>  	}
>  	up_read(&ioctl32_sem);

i think this problem only triggers on RT kernels, because the RT kernel 
only allows a single reader within a read-semaphore. This works well in 
99.9% of the cases. You just found the remaining 0.1% :-| The better 
solution within -rt would be to change ioctl32_sem to a compat 
semaphore, via the patch below. Can you confirm that this solves the 
bootup problem too?

	Ingo

Index: linux/fs/compat.c
===================================================================
--- linux.orig/fs/compat.c
+++ linux/fs/compat.c
@@ -268,7 +268,7 @@ out:
 
 #define IOCTL_HASHSIZE 256
 static struct ioctl_trans *ioctl32_hash_table[IOCTL_HASHSIZE];
-static DECLARE_RWSEM(ioctl32_sem);
+static COMPAT_DECLARE_RWSEM(ioctl32_sem);
 
 extern struct ioctl_trans ioctl_start[];
 extern int ioctl_table_size;
