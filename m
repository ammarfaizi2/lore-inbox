Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752073AbWCOE1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbWCOE1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 23:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbWCOE1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 23:27:48 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:17582 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752073AbWCOE1r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 23:27:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j9dEWV+5w0agmCRRTJwi0ize5+bvO+goFcKKd9Aok/QQXA1OZLmE9E13v8SF5I11M/vXwvQhEXjLjuZTiY9+9OB2Mx9fvOBXq3CM0VTwpVN7pHhsgcsY8o/YgsKeUgGiBQe3Dn5eBMWBvtustUyf+kBOI8I3/RShtFAP7G1dl8w=
Message-ID: <a36005b50603142027u4b811864maefa06f8d78a57bc@mail.gmail.com>
Date: Tue, 14 Mar 2006 20:27:43 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: question: pid space semantics.
Cc: "Kirill Korotaev" <dev@sw.ru>,
       "Dave Hansen <haveblue@us.ibm.com> Cedric Le Goater" <clg@fr.ibm.com>,
       "Herbert Poetzl" <herbert@13thfloor.at>, linux-kernel@vger.kernel.org
In-Reply-To: <m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1142282940.27590.17.camel@localhost.localdomain>
	 <m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> The question:
>   If we could add additional pid values in different pid spaces to a
>   process with a syscall upon demand would that lead to an
>   implementation everyone could use?

Before going into this, how do propose to solve some other issues:

- RT signal contexts have a si_pid field which contains the PID of the
sender.  When and how do you fix this up?  Can a process which is not
visible in a second PID space send a signal to a process in that
second PID space?

- similar problem: SysV IPC.  How do you fix up fields like msg_lspid
in struct msqid_ds?

- the proposed futex extensions for robust and maybe PI mutexes needs
to store the TID in the futex field.  If the futex shared by processes
in different PID spaces this value is worthless.

It would perhaps be conceivable to fix up the first two problems in
some cases.  If the process is visible in the PID space of the
receiver of the signal or the process which calls msgctl() etc the
kernel could magically fill in the correct PID for the PID space.  But
what to do if the process is not visible?

And for the futex case, the kernel is not involved in the fast path. 
There is no magic fixup which can happen.

I don't see at all how any of these things can work without breaking
all kinds of code.
