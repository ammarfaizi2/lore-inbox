Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWBIUN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWBIUN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWBIUN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:13:29 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:54826 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750761AbWBIUN2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:13:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rMdK4pe+oBW2CXrb6fAA+kkYOk8ESUL/pD6YMvdT4GkgHLh/4Id5ApaK6jym3+l3tTY6giZcYR6FlgkuQ8Xs5j6Na/5QDLX10Dtf5TthqZ7ohBuzz9mfT2FTYbVqy5A27ut4lQl+RJhUfRWUx/nszVyr7Khy6ctJP2RfCSv4F0o=
Message-ID: <9a8748490602091213p2e020355ue516d59b7d0b6c81@mail.gmail.com>
Date: Thu, 9 Feb 2006 21:13:21 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: pid_t range question
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m1r76c2yhf.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com>
	 <m1pslystkz.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.61.0602091751220.30108@yvahk01.tjqt.qr>
	 <m1r76c2yhf.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> writes:
>
> >>> On Linux, type pid_t is defined as an int if you look
> >>> through all the intermediate definitions such as S32_T,
> >>> etc. However, it wraps at 32767, the next value being 300.
> >
> > There is also an aesthetical reason. If pids were allowed to exceed, say,
> > ten million, you would need a quite wide field in `ps` for the process
> > number which is on "normal desktop user" systems just require 5 or 6
> > decimal places. Well, what I mean, just look at this sample ps output:
> >
> > 17:59 shanghai:../fs/proc # ps
> >         PID TTY          TIME CMD
> >           1 -        00:00:00 init [3]
> >  4215914607 tty2     00:00:00 bash
> >  4215914653 tty2     00:00:00 ps
> >
> > mingw/msys and cygwin already have this "cosmetic problem" since windows
> > "pids" are usually above one million.
>
> Yes.  Although this I'm not I'm not certain how bad the cosmetic problem
> is.  Certainly significant enough that we don't want to change a good
> thing when we got it.  But if there were real problems a big pid
> would solve I don't expect large pid numbers to stop us.
>

I can think of at least 3 ways to at least hide that cosmetic problem
a bit. Won't solve the problem but will make it less likely that most
people will ever encounter it.

(assuming below that we want something like 64bit pids but want to
keep pids at 5 digits as much as possible)

1. When allocating a pid for a new process, always assign the lowest
available free pid.

2. Allocate pid's as we currently do, but once we hit 99999 wrap the
pids and start allocating from free pids starting from 2 and up. only
if no pids below 99999 are free do we continue upwards and allocate
pid 100000.

3. Whenever a process terminates put its pid on a pid_reuse list. When
a new pid needs to be allocated always pick a pid from the pid_reuse
list if any are available, otherwise allocate pids as we currently do.


Any of those 3 scheemes should keep pids below 6 digits as much as
possible. We can still hit the cosmetic problem on boxes where more
than 99999 processes are actually running at the same time, but most
users will never encounter that.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
