Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130570AbRCLSnP>; Mon, 12 Mar 2001 13:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130581AbRCLSnG>; Mon, 12 Mar 2001 13:43:06 -0500
Received: from colorfullife.com ([216.156.138.34]:11012 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130570AbRCLSmy>;
	Mon, 12 Mar 2001 13:42:54 -0500
Message-ID: <001601c0ab24$37a50d70$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <kuznet@ms2.inr.ac.ru>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200103121812.VAA09627@ms2.inr.ac.ru>
Subject: Re: Feedback for fastselect and one-copy-pipe
Date: Mon, 12 Mar 2001 19:42:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <kuznet@ms2.inr.ac.ru>
> Hello!
>
> > * davem's patch breaks apps that assume that write(,PIPE_BUF) after
> > poll(POLLOUT) never blocks, even for blocking pipes.
>
> Pardon, but PIPE_BUF <= PAGE_SIZE yet, so that fears have no reasons.
>

The difference is the =

> <<<<< davem's patch
> +       if (count >= PAGE_SIZE &&
>                       ^^
> +           !(filp->f_flags & O_NONBLOCK)) {
> <<<<<<< my patch
> +  if (count > PIPE_BUF && chars == PIPE_SIZE &&
                     ^
> +      (!(filp->f_flags & O_NONBLOCK))) {
> <<<<<<<

davem used >=, I used >. All other differences between our patches are
code cleanups.

Just try this on i386: (PIPE_BUF is defined to 4096 on i386 - I really
don't understand why, but now it's too late to reverse it back to 512)

<<<<
char buf[PIPE_BUF];
void main()
{
    int pipes[2];
    pipe(pipes);
    write(pipes[1],buf,sizeof(buf));
}
<<<<<<<

It returns immediately on all unix platforms I tested, including all
linux versions, except with davem's patch.
It's not guaranteed in sus or posix, but I'm reluctant to change it.

--
    Manfred


