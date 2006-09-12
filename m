Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbWILBXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbWILBXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 21:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWILBXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 21:23:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1254 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965236AbWILBXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 21:23:16 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       containers@lists.osdl.org
Subject: Re: [patch -mm] update mq_notify to use a struct pid
References: <45019CC3.2030709@fr.ibm.com>
	<m18xktkbli.fsf@ebiederm.dsl.xmission.com>
	<450537B6.1020509@fr.ibm.com>
	<m1u03eacdc.fsf@ebiederm.dsl.xmission.com>
	<45056D3E.6040702@fr.ibm.com>
	<m14pve9qip.fsf@ebiederm.dsl.xmission.com>
	<4505DADD.4080007@fr.ibm.com>
Date: Mon, 11 Sep 2006 19:22:20 -0600
In-Reply-To: <4505DADD.4080007@fr.ibm.com> (Cedric Le Goater's message of
	"Mon, 11 Sep 2006 23:53:33 +0200")
Message-ID: <m1ejuh98vn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> Eric W. Biederman wrote:
>
>> Cedric you mentioned a couple of other patches that are in flight.
>> In the future could you please Cc: the containers list so independent
>> efforts are less likely to duplicate work, and we are more likely
>> to review each others patches instead?
>
> yes sure, i was relying on the openvz wiki to avoid duplicated efforts on
> this topic but i guess email is just the one and only tool for this kind of
> development :)

Sure.  Especially when it comes to helping review each others code :)
Not duplicating work is not really my goal, not submitting a patch
after a patch has been reviewed and accepted is.

Plus we need patch review.

Several people working on a patch in parallel if it is difficult
can frequently find a solution that a single person would miss.

>>>> Filling in a struct pid through sysctl is extremely ugly at the
>>>> moment, plus cad_pid needs some locking.
>>> Which distros use /proc/sys/kernel/cad_pid and why ? I can image the need
>>> but i didn't find much on the topic.
>> 
>> I'm not at all certain, and I'm not even certain I care.  The concept
>> is there in the code so it needs to be dealt with.  
>
> OK. It would be nice to make sure this is still in use before trying to
> deal with /proc/sys/kernel/cad_pid.
>
>> Although if I we extend the cad_pid concept it may make a difference.
>
> what do you mean by extending cad_pid ? kill_init() ?

My meaning was every time we are sending a signal to init.  It is quite
possible we should be using cad_pid instead.

>>> is that about updating the siginfos in collect_signal() to hold the right
>>> pid value depending on the pid namespace they are being received ?
>> 
>> Yes in send_signal, and in collect signal.  To make it work easily I needed
>> to add a struct pid to struct sigqueue.  So in send_signal I generate
>> the struct pid from the pid_t value and in collect signal I regenerate
>> the numeric value.
>
> OK. That's what i imagined also but we need a bit more of the pid namespace
> to regenerate the numerical value. So, how will you convert this 'struct
> pid*' in a pid value using the current pid namespace ?

By calling pid_nr :)  The question I guess is how will pid_nr be implemented.

> thinking aloud :
>
> * if the pid namespace of the sending struct pid and current match,
> 	use nr.
> * if they don't,
> 	if the sending pid namespace is the ancestor of the current pid
> 	namespace
> 		use 0
> 	else
> 		it's a bug.
>
> struct pid* needs a pid namespace attribute and pid namespace needs to know
> its parent.

Yes, that sounds correct.

There is also the case that should not come up with signals where
we have a pid from a child namespace, that we should also be able to
compute the pid for.

In essence I intend to have a list of pid_namespace, pid_t pairs connected
to a struct pid that we can look through to find the appropriate pid.

Eric


