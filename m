Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWAXVJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWAXVJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWAXVJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:09:38 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:35002 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750712AbWAXVJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:09:38 -0500
Message-ID: <43D69784.9090206@watson.ibm.com>
Date: Tue, 24 Jan 2006 16:09:24 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Greg KH <greg@kroah.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain>	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>	<43D14578.6060801@watson.ibm.com>	<m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>	<43D52592.8080709@watson.ibm.com>	<m1oe22lp69.fsf@ebiederm.dsl.xmission.com>	<1138050684.24808.29.camel@localhost.localdomain>	<m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>	<43D5557F.9060006@watson.ibm.com> <m13bjdl8rh.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13bjdl8rh.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Hubertus Franke <frankeh@watson.ibm.com> writes:
> 
> 
>>In that case, I think we do require the current vpid_to_pid(translations)
>>in order to transfer the external user pid ( relative to the namespace )
>>into one that combines namespace (aka container_id) with the external pid.
>>Exactly how it is done today.
>>What will slightly change is the low level implementations of the
>>
>>inline pid_t pid_to_vpid_ctx(pid_t pid, const struct task_struct *ctx);
>>pid_t __pid_to_vpid_ctx_excp(pid_t pid, int pidspace_id,const struct task_struct
>>*ctx);
>>
>>and reverse.
>>The VPID_2_PID and PID_2_VPID still remain at same locations.
>>
>>Did I get your comments correctly, Eric ?..
> 
> 
> Well we may need that.   For the moment let's consider putting both
> a kpid and upid and the task_struct, and elsewhere. Basically I don't think
> translation is necessary in the common case.

OK for discussion purposes no problem .. what ever is the best at the end
is the GO.
Abstractly speaking, mangling the <container,upid> tuple into the same
long int is an implementation detail.

> 
> However let's look at a single practical case to see how it would need
> to be implemnted.
> 
> struct fown_struct.  Every file has one and you can modify it both on
> a socket with ioctls FIOSETOWN,SIOCSPGRP,FIOGETOWN,SIOCPGRP.  And on
> a normal file handle with fcntl with FSETOWN, and FGETOWN.
> 
> Since a struct file can be passed between processes in different
> pid spaces using unix domain sockets we cannot count on the context
> of the signaler to be the same as the context of the setter.

If you follow the patch set, we do distinguish the context case (we might have
missed a few here and there, as you already pointed out), but going into
the kernel we always take the context of the caller, coming out of the
kernel kpid -> upid we do use the appropriate context.

static inline pid_t pid_to_vpid_ctx(pid_t pid, const struct task_struct *ctx)

> 
> So we need to look at how to handle this case cleanly, and safely.

-- Hubertus

