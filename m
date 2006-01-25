Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWAYJOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWAYJOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWAYJOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:14:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17315 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751066AbWAYJOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:14:53 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>
	<20060117143326.283450000@sergelap>
	<1137511972.3005.33.camel@laptopd505.fenrus.org>
	<20060117155600.GF20632@sergelap.austin.ibm.com>
	<1137513818.14135.23.camel@localhost.localdomain>
	<1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	<43D14578.6060801@watson.ibm.com>
	<m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
	<43D52592.8080709@watson.ibm.com>
	<m1oe22lp69.fsf@ebiederm.dsl.xmission.com>
	<1138050684.24808.29.camel@localhost.localdomain>
	<m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>
	<1138062125.24808.47.camel@localhost.localdomain>
	<m17j8pl95v.fsf@ebiederm.dsl.xmission.com>
	<1138137060.14675.73.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 25 Jan 2006 02:13:22 -0700
In-Reply-To: <1138137060.14675.73.camel@localhost.localdomain> (Alan Cox's
 message of "Tue, 24 Jan 2006 21:11:00 +0000")
Message-ID: <m1psmgk6vh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> However it looks to me that the biggest challenge right now about
>> development is the size of a patch to change any one of these things.
>
> Thats where we disagree strongly. Wrappers hide, confuse and obscure. We
> want the workings brutally and clearly visible so that people don't make
> assumptions and have nasty accidents. Its like typdedefs and overuse of
> defines.

I totally that we want the uses of pids to be clear and not over abstracted.
However most places that reference pids are debug statements are simply
line noise in any patch.

I threw together a casual patch for purposes of discussion earlier.
Not fully polished, just a rough draft for discussion and it was so big
most people didn't even receive it.  So regardless of other considerations
the sheer number size is a problem even if abstractions can't help.

I think adding a helper for the common debugging idiom of printing out
the current task is generally useful, and is worth considering on it's own merits.

In particular, does this look like a sane piece of code to add to the kernel?
This is based on analogy with dev_printk.

Either tsk_printk or something like NIP_QUAD is what I am thinking about.

Eric


diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0cfcd1c..d5dcbde 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -880,6 +880,19 @@ static inline pid_t process_group(struct
        return tsk->signal->pgrp;
 }

+/* debugging and troubleshooting/disanostic helpers. */
+#define tsk_printk(level, dev, format, arg...) \
+       printk(level "%s(%d): " format , (tsk)->comm , (tsk)->pid , ## arg)
+
+#define tsk_dbg(tsk, format, arg...)           \
+       tsk_printk(KERN_DEBUG , tsk , format, ## arg)
+#define tsk_err(tsk, format, arg...)           \
+       tsk_printk(KERN_ERR , tsk , format, ## arg)
+#define tsk_info(tsk, format, arg...)          \
+       tsk_printk(KERN_INFO , tsk , format, ## arg)
+#define tsk_warn(tsk, format, arg...)          \
+       tsk_printk(KERN_WARN , tsk , format, ## arg)
+
 /**
  * pid_alive - check that a task structure is not stale
  * @p: Task structure to be checked.

