Return-Path: <linux-kernel-owner+w=401wt.eu-S932073AbXACUJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbXACUJt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbXACUJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:09:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:19670 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073AbXACUJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:09:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AidasxiZ0eNt+4ioS2h7vaaOL8DsbkLNZ5Oba5aXCi3coDUCpDoEczrkGErv+8SVGhPT7FNdA2quJv726oGJnAHbsy/dO6n/wQMMzR5oD4ZsnaFdQJJqLQbmOFsux3sWgdE5zZl1AoztCa98Q4P6tU21QxdPg+tn6LNGO2J+6Bo=
Message-ID: <c70ff3ad0701031209g43cf5576v11b6409696af1ed4@mail.gmail.com>
Date: Wed, 3 Jan 2007 22:09:46 +0200
From: "saeed bishara" <saeed.bishara@gmail.com>
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: using splice/vmsplice to improve file receive performance
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061222124710.GR17199@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c70ff3ad0612211121g3c5aaa28s9b738e9c79f9c2be@mail.gmail.com>
	 <20061222094858.GP17199@kernel.dk>
	 <c70ff3ad0612220318i54e7569fn161cf781d9bf0669@mail.gmail.com>
	 <20061222113917.GQ17199@kernel.dk>
	 <c70ff3ad0612220359w3f568850qb720230bae76a698@mail.gmail.com>
	 <20061222124710.GR17199@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Fri, Dec 22 2006, saeed bishara wrote:
> > On 12/22/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> > >On Fri, Dec 22 2006, saeed bishara wrote:
> > >> On 12/22/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> > >> >On Thu, Dec 21 2006, saeed bishara wrote:
> > >> >> Hi,
> > >> >> I'm trying to use the splice/vmsplice system calls to improve the
> > >> >> samba server write throughput, but before touching the smbd, I started
> > >> >> to improve the ttcp tool since it simple and has the same flow. I'm
> > >> >> expecting to avoid the "copy_from_user" path when using those
> > >> >> syscalls.
> > >> >> so far, I couldn't make any improvement, actually the throughput get
> > >> >> worst. the new receive flow looks like this (code also attached):
> > >> >> 1. read tcp packet (64 pages) to page aligned buffer.
> > >> >> 2. vmsplice the buffer to pipe with SPLICE_F_MOVE.
> > >> >> 3. splice the pipe to the file, also with SPLICE_F_MOVE.
> > >> >>
> > >> >> the strace shows that the splice takes a lot of time. also when
> > >> >> profiling the kernel, I found that the memcpy() called to often !!
> > >> >
> > >> >(didn't see this until now, axboe@suse.de doesn't work anymore)
> > >> >
> > >> >I'm assuming that you mean you vmsplice with SPLICE_F_GIFT, to hand
> > >> >ownership of the pages to the kernel (in which case SPLICE_F_MOVE will
> > >> >work, otherwise you get a copy)? If not, that'll surely cost you a data
> > >> >copy
> > >>   I'll try the vmplice with SPLICE_F_GIFT and splice with MOVE. btw,
> > >> I noticed that the  splice system call takes the bulk of the time,
> > >> does it mean anything?
> > >
> > >Hard to say without seeing some numbers :-)
> > I'm out of the office, I'll send it later. btw, my test bed ( the
> > receiver side ) is arm9. does it matter?
>
> The vmsplice is basically vm intensive, so it could matter.
>
> > >> >This sounds remarkably like a recent thread on lkml, you may want to
> > >> >read up on that. Basically using splice for network receive is a bit of
> > >> >a work-around now, since you do need the one copy and then vmsplice that
> > >> >into a pipe. To realize the full potential of splice, we first need
> > >> >socket receive support so you can skip that step (splice from socket to
> > >> >pipe, splice pipe to file).
> > >> Ashwini Kulkarni posted patches that implements that, see
> > >> http://lkml.org/lkml/2006/9/20/272 .  is that right?
> > >> >
> > >> >There was no test code attached, btw.
> > >> sorry, here it is.
> > >> can you please add sample application to your test tools (splice,fio
> > >> ,,) that demonstrates my flow; socket to file using read & vmsplice?
> > >
> > >I didn't add such an example, since I had hoped that we would have
> > >splice from socket support sooner rather than later. But I can do so, of
> > >course.
> > do you any preliminary patches? I can start playing with it.
>
> I don't, Intel posted a set of patches a few months ago though. I didn't
> have time to look that at the time being, but you should be able to find
> them in the archives.
>
> > >I'll try your test. One thing that sticks out initially is that you
> > >should be using full pages, the splice pipe will not merge page
> > >segments. So don't use a buflen less than the page size.
> >
> > yes, actually I  run the ttcp with -l65536 ( 64KB ), and the buffer is
> > always page aligned.also, the splice/vmsplice with MOVE or GIFT will
> > fail if the buffer is not a whole pages. am I rigth?
>
> Yes.
>
> I added a simple splice-fromnet example in the splice git repo, see if
> you can repeat your results with that. Doing:
>
> # ./splice-fromnet -g 2001 | ./splice-out -m /dev/null
>
> and
>
> # cat /dev/zero | netcat localhost 2001
>
> gets me about 490MiB/sec, using a recv/write loop is around 413MiB/sec.
> Not migrating pages gets me around 422MiB/sec.
>
> --
> Jens Axboe
>
>
I've done some investigation in the splice flow and found the following:
even when using vmsplice with GIFT and splice with MOVE, the user
buffers still copied, I see that the memcpy from pipe_to_file() is
called.
I added debug messages in this function and here what I got:
1. the  generic_pipe_buf_steal always fails, this is because the
page_count is 2.
2. after then, the find_lock_page fails as well.
3. page_cache_alloc_cold succeeds.
4. but, since the buf->page is differs from the page (returned by
page_cache_alloc_cold) the memcpy function is called.

this behavior true for all the buffers that vmspliced to ext3 file.
is this the expected behavior? is there any way to make the steal
operation return with success?

saeed
