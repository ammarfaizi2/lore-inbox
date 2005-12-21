Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVLUSFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVLUSFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVLUSFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:05:38 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:55379 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751147AbVLUSFi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:05:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jsy9it8RF/r77O+ik47AuabiHpcEIkVr7heTsUmO5XD7s76n3El0HnCH3snn2BWepVFv1FPf1oLcOlQ4qEkurMhtsa0lBiVVQ1SeHXX9wxfIxoUSx774XevWI4R0lenRfqDzW313c3ba350ZlxORBOrwrWAHc/annwBCT59biHM=
Message-ID: <9a8748490512211005u40ca4c7dv41044827544f97fa@mail.gmail.com>
Date: Wed, 21 Dec 2005 19:05:36 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jie Zhang <jzhang918@gmail.com>
Subject: Re: Question on the current behaviour of malloc () on Linux
Cc: linux-kernel@vger.kernel.org, lars.friedrich@wago.com
In-Reply-To: <6f48278f0512210936y25169c37t9fb7eb13fef3a97d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6f48278f0512210936y25169c37t9fb7eb13fef3a97d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, Jie Zhang <jzhang918@gmail.com> wrote:
> Hi,
>
> I first asked this question on uClinux mailing list. My first question
> is <http://mailman.uclinux.org/pipermail/uclinux-dev/2005-December/036042.html>.
> Although I found this issue on uClinux, it's also can be demostrated
> on Linux. This is a small program:
>
[snip memory hog]
>
> When I run it on my Linux notebook, it will be killed. I expect to see
> it prints out   "fail".
>

You are seeing the effects of Linux overcommitting memory.

When an application asks for memory the allocation will be granted
even if the system does not have enough free to actually satisfy the
request. This is done on the assumption that either the app won't
actually touch all mem that it allocates (it's only really allocated
once it's written to) or when the app gets to the point of writing to
the mem then enough will be free at that point. Really obviously
faulty allocations are still refused.

In most cases this works well.

What's happening in your case is a series of small allocations that
the kernel will grant since they are not "obviously flawed", then you
proceed to actually write to the mem and you eventually run into a
situation where the kernel runs out of memory to fulfill the promise
it has made and has no other way to recover than killing off one or
more processes to free some RAM. That's when the OOM killer kicks in
and tries to identify the memory hog and it correctly identifies your
application as a good candidate to kill, it kills the app and the
system survives at the expense of your app.

If for some reason you run apps where memory overcommit is not
acceptable, then you can disable overcommit by doing

 echo 2 > /proc/sys/vm/overcommit_memory

There are two basic knobs you can tweak in relation to memory
overcommit. The first one is /proc/sys/vm/overcommit_memory which
controlls the general overcommit strategy.
The default value is 0 and means "Heuristic overcommit" - That is,
generally overcommit, but try to be smart about it.
A value of 1 means "Always overcommit" - In this mode even completely
rediculous allocation requests made by applications will always appear
to succeed.
The final value of 2 means "Always overcommit" - In this mode the
kernel will never overcommit memory, so if an application asks for
more than is currently available the allocation will fail.

The second knob you can turn is /proc/sys/vm/overcommit_ratio that
controls how much (a percentage) the kernel will overcommit when in
overcommit mode 0. Tweaking this is often better than completely
disabling overcommit.

For more information read Documentation/vm/overcommit-accounting ,
Documentation/sysctl/vm.txt & Documentation/filesystems/proc.txt


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
