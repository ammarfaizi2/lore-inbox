Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWINRDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWINRDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWINRDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:03:06 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:7132 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750752AbWINRDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:03:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jUXRu4vQXT0/xpH+W2epTSSBU+XVfdbpnVWwmGuCeJqPTdLKBS/6Rg/KDgdIJ7QwrYnI+810gJqQySI5fnMZt01biJt7igAR6n4rzFGSohUYdaQf66DQnXuEoAT7BnYYDUS53DFmNUlxY5z6u+Ph0rGZLyAUy44M7HyD6H6UcIM=
Message-ID: <b324b5ad0609141003tdd222e6ye0f67d6ad5e7f9e0@mail.gmail.com>
Date: Thu, 14 Sep 2006 10:03:02 -0700
From: "David Singleton" <daviado@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: OpPoint summary
Cc: linux-pm@lists.osdl.org, "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060914055529.GA18031@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060911082025.GD1898@elf.ucw.cz>
	 <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	 <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	 <20060911225617.GB13474@elf.ucw.cz>
	 <20060912001701.GC14234@linux.intel.com>
	 <20060912033700.GD27397@kroah.com>
	 <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
	 <20060914055529.GA18031@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Care to resend your patches in the proper format, through email so that
> we can see them, and possibly get some testing in -mm if they look sane?

Greg,
   here's the patch that leverages the cpufreq notifier lists for
driver PRE and POST
change functions.  I'm also rebasing to 2.6.18-rc7 and making changes Pavel
suggested about just having suspend states in /sys/power/state and moving
the operating point control file down under
/sys/power/operating_states directory.


Signed-Off-by: David Singleton <dsingleton@mvista.com>

 drivers/cpufreq/cpufreq.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |    2 ++
 2 files changed, 38 insertions(+)

Index: linux-2.6.17/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.17.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.17/drivers/cpufreq/cpufreq.c
@@ -226,6 +226,35 @@ static void adjust_jiffies(unsigned long
 static inline void adjust_jiffies(unsigned long val, struct
cpufreq_freqs *ci) { return; }
 #endif

+int cpufreq_prepare_transition(struct oppoint *cur, struct oppoint *new)
+{
+       struct cpufreq_freqs freqs;
+
+       freqs.old = cur->frequency;
+       freqs.new = new->frequency;
+       freqs.cpu = 0;
+       freqs.flags = new->flags;
+       blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+                       CPUFREQ_PRECHANGE, &freqs);
+       adjust_jiffies(CPUFREQ_PRECHANGE, &freqs);
+       return 0;
+}
+EXPORT_SYMBOL(cpufreq_prepare_transition);
+
+int cpufreq_finish_transition(struct oppoint *cur, struct oppoint *new)
+{
+       struct cpufreq_freqs freqs;
+
+       freqs.old = cur->frequency;
+       freqs.new = new->frequency;
+       freqs.cpu = 0;
+       freqs.flags = new->flags;
+       adjust_jiffies(CPUFREQ_POSTCHANGE, &freqs);
+       blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+                       CPUFREQ_POSTCHANGE, &freqs);
+       return 0;
+}
+EXPORT_SYMBOL(cpufreq_finish_transition);

 /**
  * cpufreq_notify_transition - call notifier chain and adjust_jiffies
@@ -920,6 +949,12 @@ static void cpufreq_out_of_sync(unsigned
 }


+#ifdef CONFIG_PM
+unsigned int cpufreq_quick_get(unsigned int cpu)
+{
+       return (current_state->frequency);
+}
+#else
 /**
  * cpufreq_quick_get - get the CPU frequency (in kHz) frpm policy->cur
  * @cpu: CPU number
@@ -941,6 +976,7 @@ unsigned int cpufreq_quick_get(unsigned

        return (ret);
 }
+#endif
 EXPORT_SYMBOL(cpufreq_quick_get);


Index: linux-2.6.17/include/linux/cpufreq.h
===================================================================
--- linux-2.6.17.orig/include/linux/cpufreq.h
+++ linux-2.6.17/include/linux/cpufreq.h
@@ -268,6 +268,8 @@ static inline unsigned int cpufreq_quick
        return 0;
 }
 #endif
+int cpufreq_prepare_transition(struct oppoint *cur, struct oppoint *new);
+int cpufreq_finish_transition(struct oppoint *cur, struct oppoint *new);


 /*********************************************************************



>
> thanks,
>
> greg k-h
>
