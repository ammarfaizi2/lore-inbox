Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264300AbRFMCsh>; Tue, 12 Jun 2001 22:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264323AbRFMCs2>; Tue, 12 Jun 2001 22:48:28 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:29312 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264300AbRFMCsX>; Tue, 12 Jun 2001 22:48:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Ben Greear <greearb@candelatech.com>, landley@webofficenow.com
Subject: Re: Hour long timeout to ssh/telnet/ftp to down host?
Date: Tue, 12 Jun 2001 17:47:35 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01061217025700.02061@localhost.localdomain> <3B26CD5B.47002360@candelatech.com>
In-Reply-To: <3B26CD5B.47002360@candelatech.com>
MIME-Version: 1.0
Message-Id: <01061217473501.02061@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You can tune things by setting the tcp-timeout probably..I don't
>know exactly where to set this..

Aha, found it.  /proc/sys/net/ipv4/tcp_syn_retries

I am a victim of the exponential retry falloff, it would seem.  syn_retries 
of 1 takes a few seconds, 3 takes less than half a minute, and 5 takes 
several minutes.  The default value of 10 is what's giving me the problem 
(something like 20 minutes to time out, according to my earlier tests.)

Then the fact that ssh then re-attempts the connection four times before 
actually failing is where I got my hour and change timeout.  ("ssh -v -v -v" 
comes in handy...)

Fun.

Can we change the default value for this to something more sane, like 5?  
Exponential falloff is not good when your order of magnitude hits double 
digits.

> You probably don't want all tcp to time out at 15 seconds anyway, so

Just connection initiation.  (If their ip stack hasn't replied to me by then, 
I doubt it's going to.)

> I'd suggest either using non-blocking connect (if you have the code
> that does the connect), or just set a timer (or use sigalarm) when you
> start the attempt, and fail the attempt if the timer or alarm signal
> goes off.

Except I'm using off-the-shelf ssh.  (I asked them about this problem a month 
ago, and there was some discussion of a workaround on their mailing list, but 
2.9 came out and still had the same behavior.  Apparently, if it's not a 
problem in OpenBSD, it's not a problem in OpenSSH...)

> > If it's glibc I'm probably better off writing a wrapper to ping the
> > destination before trying to connect, or killing the connection after a
> > timeout with no traffic.  But both of those are really ugly solutions.
>
> Ugly is relative, and don't use ping because there is still a race
> condition (ping worked, but by the time you try tcp, the box is down.)

Yeah, but it would eventually time out and recover, I've got ten threads out 
querying boxes, that's a really rare race condition.  And I already 
acknowledged it was ugly. :)

So the problem is just that tcp_syn_retries' default value of 10 is way too 
high due to the exponentially increasing gap between each retry.

Rob
