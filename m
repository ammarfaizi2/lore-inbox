Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWIKVxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWIKVxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWIKVxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:53:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:17559 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964926AbWIKVxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:53:43 -0400
Message-ID: <4505DADD.4080007@fr.ibm.com>
Date: Mon, 11 Sep 2006 23:53:33 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       containers@lists.osdl.org
Subject: Re: [patch -mm] update mq_notify to use a struct pid
References: <45019CC3.2030709@fr.ibm.com>	<m18xktkbli.fsf@ebiederm.dsl.xmission.com>	<450537B6.1020509@fr.ibm.com>	<m1u03eacdc.fsf@ebiederm.dsl.xmission.com>	<45056D3E.6040702@fr.ibm.com> <m14pve9qip.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m14pve9qip.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> Cedric you mentioned a couple of other patches that are in flight.
> In the future could you please Cc: the containers list so independent
> efforts are less likely to duplicate work, and we are more likely
> to review each others patches instead?

yes sure, i was relying on the openvz wiki to avoid duplicated efforts on
this topic but i guess email is just the one and only tool for this kind of
development :)

[ ... ]

>>> Converting that is going to need some sysctl work, so I have been
>>> ignoring it temporarily.
>>>
>>> Filling in a struct pid through sysctl is extremely ugly at the
>>> moment, plus cad_pid needs some locking.
>> Which distros use /proc/sys/kernel/cad_pid and why ? I can image the need
>> but i didn't find much on the topic.
> 
> I'm not at all certain, and I'm not even certain I care.  The concept
> is there in the code so it needs to be dealt with.  

OK. It would be nice to make sure this is still in use before trying to
deal with /proc/sys/kernel/cad_pid.

> Although if I we extend the cad_pid concept it may make a difference.

what do you mean by extending cad_pid ? kill_init() ?

[ ... ]

>> is that about updating the siginfos in collect_signal() to hold the right
>> pid value depending on the pid namespace they are being received ?
> 
> Yes in send_signal, and in collect signal.  To make it work easily I needed
> to add a struct pid to struct sigqueue.  So in send_signal I generate
> the struct pid from the pid_t value and in collect signal I regenerate
> the numeric value.

OK. That's what i imagined also but we need a bit more of the pid namespace
to regenerate the numerical value. So, how will you convert this 'struct
pid*' in a pid value using the current pid namespace ?

thinking aloud :

* if the pid namespace of the sending struct pid and current match,
	use nr.
* if they don't,
	if the sending pid namespace is the ancestor of the current pid
	namespace
		use 0
	else
		it's a bug.

struct pid* needs a pid namespace attribute and pid namespace needs to know
its parent.

C.
