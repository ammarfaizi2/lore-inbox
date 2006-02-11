Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWBKJo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWBKJo5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 04:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWBKJo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 04:44:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39107 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751088AbWBKJo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 04:44:57 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the
 process id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 11 Feb 2006 02:42:25 -0700
In-Reply-To: <43ECF803.8080404@sw.ru> (Kirill Korotaev's message of "Fri, 10
 Feb 2006 23:30:59 +0300")
Message-ID: <m1ek2axmda.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>> + * kill_pspace_info() sends a signal to all processes in a process space.
>> + * This is what kill(-1, sig) does.
>> + */
>> +
>> +int __kill_pspace_info(int sig, struct siginfo *info, struct pspace *pspace)
>> +{
>> +	struct task_struct *p = NULL;
>> +	int retval = 0, count = 0;
>> +
>> +	for_each_process(p) {
>> +		int err;
>> +		/* Skip the current pspace leader */
>> +		if (current_pspace_leader(p))
>> +			continue;
>> +
>> +		/* Skip the sender of the signal */
>> +		if (p->signal == current->signal)
>> +			continue;
>> +
>> +		/* Skip processes outside the target process space */
>> +		if (!in_pspace(pspace, p))
>> +			continue;
>> +
>> +		/* Finally it is a good process send the signal. */
>> +		err = group_send_sig_info(sig, info, p);
>> +		++count;
>> +		if (err != -EPERM)
>> +			retval = err;
> <<<<
> why EPERM is ok?
> do you want to miss some tasks?


A good question.  This is how kill -1 is currently implemented.
It doesn't align with how signals are sent to a process group,
so it could very well be wrong.

>> +	}
>> +	return count ? retval : -ESRCH;
>> +}
>> +
