Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWAYJ7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWAYJ7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWAYJ7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:59:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52643 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751097AbWAYJ7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:59:35 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
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
	<1138137305.2977.92.camel@laptopd505.fenrus.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 25 Jan 2006 02:58:51 -0700
In-Reply-To: <1138137305.2977.92.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Tue, 24 Jan 2006 22:15:05 +0100")
Message-ID: <m1ek2wk4ro.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Tue, 2006-01-24 at 21:11 +0000, Alan Cox wrote:
>> On Maw, 2006-01-24 at 12:26 -0700, Eric W. Biederman wrote:
>> > There is at least NFS lockd that appreciates having a single integer
>> > per process unique identifier.  So there is a practical basis for
>> > wanting such a thing.
>> 
>> Which gets us back to refcounting.
>> 
>> > At least for this first round I think talking about a kpid
>> > as a container, pid pair makes a lot of sense for the moment, as
>> > the other implementations just confuse things.
>> 
>> As an abstract object a kpid to me means a single identifier which
>> uniquely identifies the process and which in its component parts be they
>> pointers or not uniquely identifies the process in the container and the
>> container in the system, both correctly refcounted against re-use.
>
> they why not just straight use the task struct pointer for this? It's
> guaranteed unique.. ;)

Actually I think that is a very sensible solution to this problem.
It does double or triple the length of the string passed to lockd
and is an information leak about which kernel addresses you are
running out of which may be undesirable from a security perspective
but I think that will fix the practical problem.

Reference counting in this case is not an issue, as these are
per process locks and should be freed up when everything goes.

I have a weird memory that simply making the string long and using
%p (current) didn't work as well as of %d (current->kpid) but that is something
very hard to test, as usually even with multiple pid spaces you don't
get pid reuse and the errors from NFS are not at all clear that pid
reuse is what is causing problems.  So I don't have good data on
that situation.

Eric
