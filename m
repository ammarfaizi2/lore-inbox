Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWAVGoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWAVGoN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 01:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWAVGoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 01:44:12 -0500
Received: from smtpout.mac.com ([17.250.248.88]:42450 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750760AbWAVGoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 01:44:12 -0500
In-Reply-To: <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
References: <20060117143258.150807000@sergelap> <20060117143326.283450000@sergelap> <1137511972.3005.33.camel@laptopd505.fenrus.org> <20060117155600.GF20632@sergelap.austin.ibm.com> <1137513818.14135.23.camel@localhost.localdomain> <1137518714.5526.8.camel@localhost.localdomain> <20060118045518.GB7292@kroah.com> <1137601395.7850.9.camel@localhost.localdomain> <m1fyniomw2.fsf@ebiederm.dsl.xmission.com> <43D14578.6060801@watson.ibm.com> <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CC5052ED-FEC1-4B0C-A8A7-3CD190ADF0D3@mac.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
Date: Sun, 22 Jan 2006 01:43:41 -0500
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 21, 2006, at 09:42, Eric W. Biederman wrote:
> Hubertus Franke <frankeh@watson.ibm.com> writes:
>
>> Actions: The vpid_to_pid will disappear and the check for whether  
>> we are in the same container needs to be pushed down into the task  
>> lookup. question remains to  figure out  whether the context of  
>> the task lookup (will always remain the caller ?).
>
> Any place the kernel saves a pid and then proceeds to signal it  
> later. At that later point in time it is possibly you will be in  
> the wrong context.
>
> This probably justifies having a kpid_t that has both the process
> space id and the pid in it.  For when the kernel is storing pids to
> use as weak references, for signal purposes etc.

The kernel should not be saving a PID.  The kernel should be sticking  
a pointer to a struct task_struct somewhere (with appropriate  
refcounting) and using that.

> The only way I know to make this change safely is to make  
> compilation of all functions that manipulate pids in possibly  
> dangerous ways fail. And then to manually and slowly fix them up.
>
> That way if something is missed.  You get a compile error instead  
> of incorrect execution.

I agree.  This is one of the things I really liked about the recent  
mutex patch; it added a lot of checks to various codepaths to verify  
at both compile time and run time that the code was correct.

My personal opinion is that we need to add a new race-free API, say  
open("/proc/fork"); that forks a process and returns an open "process  
handle", essentially a filehandle that references a particular  
process.  (Also, an open("/proc/self/handle") or something to return  
a current-process handle)   Through some method of signaling the  
kernel (syscall, ioctl, some other?) a process can send a signal to  
the process referenced by the handle, check its status, etc.  A  
process handle might be passed to other processes using a UNIX-domain  
socket.  You would be able to dup() a process handle and then  
restrict the set of valid operations on the new process handle, so  
that it could be passed to another process  without giving that  
process access to the full set of operations (check status only, not  
able to send a signal, for example).

Obviously we would need to maintain support for the old interface for  
some period of time, but I think the new one would make it much  
easier to write simple race-free programs.

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



