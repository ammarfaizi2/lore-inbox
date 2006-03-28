Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWC1Dpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWC1Dpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 22:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWC1Dpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 22:45:44 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:43660 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751231AbWC1Dpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 22:45:43 -0500
Subject: Re: [RFC][PATCH 1/2] Virtualization of UTS
From: Sam Vilain <sam@vilain.net>
To: Kirill Korotaev <dev@sw.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, ebiederm@xmission.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com
In-Reply-To: <44242CE7.3030905@sw.ru>
References: <44242B1B.1080909@sw.ru>  <44242CE7.3030905@sw.ru>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 15:45:56 +1200
Message-Id: <1143517556.7156.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 20:31 +0300, Kirill Korotaev wrote:
> +static inline void get_uts_ns(struct uts_namespace *ns)
> +{
> +	atomic_inc(&ns->cnt);
> +}
> +
> +static inline void put_uts_ns(struct uts_namespace *ns)
> +{
> +	if (atomic_dec_and_test(&ns->cnt))
> +		free_uts_ns(ns);
> +}

I think somebody already said this, but this is probably better using
kobject as I was asked to for the vx_info.  (Documentation/kobject.txt)

Also I think it might be useful to have a count of tasks that refer to
the structure, in addition to the count of actual references.  In this
way you can know whether the resource is "free" before its kobject
destructor is called (as the vserver vx_info does).

Perhaps that abstraction is best to put in when it becomes "useful",
like you have a situation where you want to do something when the last
process with a utsname exits, but before the last kthread referencing
the structure stops (eg, a sleeping process reading /proc somewhere).

Otherwise, nice and simple; I could quite easily at this point plug this
into the syscall infrastructure I posted earlier (once it is reworked
based on people's comments), and provide tests for this.

Sam.

