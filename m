Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWDXWA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWDXWA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWDXWA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:00:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37813 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750749AbWDXWA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:00:56 -0400
Date: Mon, 24 Apr 2006 15:03:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: sekharan@us.ibm.com
Cc: herbert@13thfloor.at, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       stern@rowland.harvard.edu
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
Message-Id: <20060424150314.2de6373d.akpm@osdl.org>
In-Reply-To: <1145913967.1400.59.camel@linuxchandra>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
	<20060421110140.GC14841@MAIL.13thfloor.at>
	<1145655097.15389.12.camel@linuxchandra>
	<20060422005851.GA22917@MAIL.13thfloor.at>
	<1145913967.1400.59.camel@linuxchandra>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>
> Thanks for the steps. With that i was able to reproduce the problem and
> i found the bug.
> 
> While i go ahead and generate the patch, i wanted to hear if my
> conclusion is correct.
> 
> The problem is due to the fact that most notifier registrations
> incorrectly use __devinitdata to define the callback structure, as in:
> 
> static struct notifier_block __devinitdata hrtimers_nb = {
>         .notifier_call = hrtimer_cpu_notify,
> };
> 
> devinitdata'd  data is not _expected to be available_ after the
> initialization(unless CONFIG_HOTPLUG is defined).
> 
> I do not know how it was working until now :), anybody has a theory that
> can explain it (or my conclusion is wrong) ?

That sounds right.  There are several __devinitdata notifier_blocks in the
tree - please be sure to check them all.

btw, it'd be pretty trivial to add runtime checking for this sort of thing:

int addr_in_init_section(void *addr)
{
	return addr >= __init_begin && addr < __init_end;
}

(x86-specific)
(need to add __init_end to vmlinux.lds.S)

then we could use that to check various things in various places...
