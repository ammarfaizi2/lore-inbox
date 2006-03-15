Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWCOFif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWCOFif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 00:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWCOFif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 00:38:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23758 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932582AbWCOFif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 00:38:35 -0500
To: "Ulrich Drepper" <drepper@gmail.com>
Cc: "Kirill Korotaev" <dev@sw.ru>,
       "Dave Hansen <haveblue@us.ibm.com> Cedric Le Goater" <clg@fr.ibm.com>,
       "Herbert Poetzl" <herbert@13thfloor.at>, linux-kernel@vger.kernel.org
Subject: Re: question: pid space semantics.
References: <1142282940.27590.17.camel@localhost.localdomain>
	<m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
	<a36005b50603142027u4b811864maefa06f8d78a57bc@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 14 Mar 2006 22:37:01 -0700
In-Reply-To: <a36005b50603142027u4b811864maefa06f8d78a57bc@mail.gmail.com> (Ulrich
 Drepper's message of "Tue, 14 Mar 2006 20:27:43 -0800")
Message-ID: <m1zmjsi802.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ulrich Drepper" <drepper@gmail.com> writes:

> On 3/14/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> The question:
>>   If we could add additional pid values in different pid spaces to a
>>   process with a syscall upon demand would that lead to an
>>   implementation everyone could use?
>
> Before going into this, how do propose to solve some other issues:
>
> - RT signal contexts have a si_pid field which contains the PID of the
> sender.  When and how do you fix this up?  Can a process which is not
> visible in a second PID space send a signal to a process in that
> second PID space?
>
> - similar problem: SysV IPC.  How do you fix up fields like msg_lspid
> in struct msqid_ds?
>
> - the proposed futex extensions for robust and maybe PI mutexes needs
> to store the TID in the futex field.  If the futex shared by processes
> in different PID spaces this value is worthless.

Odd.  I did not see that in Ingo's patches on the kernel list.
Perhaps only user space cares about storing the tid in the futex
field.

> It would perhaps be conceivable to fix up the first two problems in
> some cases.  If the process is visible in the PID space of the
> receiver of the signal or the process which calls msgctl() etc the
> kernel could magically fill in the correct PID for the PID space.  But
> what to do if the process is not visible?
>
> And for the futex case, the kernel is not involved in the fast path. 
> There is no magic fixup which can happen.
>
> I don't see at all how any of these things can work without breaking
> all kinds of code.

The point of containers and their building blocks largely is isolation
so you can have multiple different user space environments on one
machine.  So for most of the pieces that can really confuse user space
the answer is don't do that then.  The classic example is pid files
for remembering a daemon is running.

Interactions do need to happen between pid spaces for certain
administrative actions, and as much as possible I don't want
to reinvent the wheel.  Pid alases in the kernel are for
that purpose, and so will likely play a role in the RT signal
and the sysv shm case.

Eric
