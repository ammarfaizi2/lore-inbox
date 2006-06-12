Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWFLW3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWFLW3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWFLW3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:29:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:34921 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932613AbWFLW3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:29:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hwm62gkplJcj6cP2KIldho2cqjXjd6fMGcmayerhbcq2PDjuQBXSSm3G/kYX9lBPO441FRDz3hwsF8ifsveaa8pKrX7QDFOQdNPlnKiFyF7N98kOWPx7oGO9nHMseIC6sSZQ36LiDMjx5UalIRBMmtCuDuy92n+kmvqAYoi4tGE=
Message-ID: <9a8748490606121529v4fe3c261jd73ebcb6a06f8386@mail.gmail.com>
Date: Tue, 13 Jun 2006 00:29:46 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Cc: jeff@garzik.org, matti.aarnio@zmailer.org, rlrevell@joe-job.com,
       folkert@vanheusden.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060612.130058.78495098.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1150048497.14253.140.camel@mindpipe>
	 <20060611.115430.112290058.davem@davemloft.net>
	 <448D7FB0.9070604@garzik.org>
	 <20060612.130058.78495098.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/06, David Miller <davem@davemloft.net> wrote:
> From: Jeff Garzik <jeff@garzik.org>
> Date: Mon, 12 Jun 2006 10:52:32 -0400
>
> > Create two simple web pages, one that shows the last 24 hours' worth of
> > LKML posts, and another one that shows the last 24 hours' worth of spam.
> >   Allow any user on the Internet to report an LKML post as spam, or
> > alternately, highlight a false positive as not-spam.  (perhaps generate
> > one of those wavy-text verify-you-are-a-human graphics)
> >
> > Then you, as admin, only have to click a button that accepts or rejects
> > the submission(s).  If you want to scan it yourself for false positives,
> > you just hit the same webpage as everybody else.
> >
> > That feedback is then fed into the bayesian system, to train it using
> > well-known methods.
>
> I like this idea a lot.

It's a lot more sane than SPF, that's for sure.

I'd suggest taking a look at DSPAM (http://dspam.nuclearelephant.com/)
for something like that.

But, there are also other, and even simpler, options.
I've personally found that using some of the build-in anti-spam
features in postfix can be used to stop a lot of spam with almost zero
impact on ham. While some of the features do affect some ham, there
are a few that almost never do, yet they stop quite a bit of spam :


  smtpd_client_restrictions =
    reject_unauth_pipelining

Reject the mail if the sending server tries to send SMTP commands
ahead of time without first checking if the server supports
pipelining.
I've only ever seen obvious spam sources being rejected by this.


  smtpd_helo_required = yes

Mail servers that can't be bothered to send any HELO/EHLO at all are
in my experience only spam sources.


  smtpd_helo_restrictions =
    reject_invalid_hostname,

This will reject mail from servers that send a hostname in HELO/EHLO
that has bad syntax or invalid characters. I've never seen this one
reject valid senders, but I have seen it reject a lot of spam sources.
 Postfix also has other more strict checks you can enable on helo, but
those tend to reject too much valid mail.


  strict_rfc821_envelopes = yes

This rejects some spam from spambots that don't know how to generate a
proper mail. I've on occasion seen it hit valid senders, but very
rarely.


  smtpd_sender_restrictions =
    reject_non_fqdn_sender,
    reject_unknown_sender_domain

This will reject mail with senders without a fully qualified name as
well as sender addresses where the sender domain does not have an A or
MX record.
This stops a lot of spam on my servers and I've never had any problems
with it since what's the point of accepting a mail from somewhere that
you can't reply back to...


  smtpd_recipient_restrictions =
    reject_non_fqdn_recipient,
    reject_unknown_recipient_domain

Same as for senders, reject the mail if the recipient domain i not
fully qualified or the recipient domain has no A or MX record.


Implementing these things should have a minimum of impact on ham on
vger, but should stop a fair amount of spam - at least they do for me,
and my servers at work pass hundreds of thousands of messages daily
without users complaining about these settings and I can see in the
logs that they stop quite a lot of junk.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
