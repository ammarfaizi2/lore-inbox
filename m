Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVFMPkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVFMPkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVFMPkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:40:32 -0400
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:41656 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261605AbVFMPjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:39:33 -0400
Message-ID: <000a01c57035$79738a80$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Denis Vlasenko" <vda@ilport.com.ua>, <linux-kernel@vger.kernel.org>
References: <002301c57018$266079b0$2800000a@pc365dualp2> <200506131618.09718.vda@ilport.com.ua>
Subject: Re: [RFC] Observations on x86 process.c
Date: Mon, 13 Jun 2005 12:32:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a good idea BTW.

It could be expanded upon further by adding something else to designate
error case and infrequent oddball situation code blocks.  Even "fast"
functions often include large sections of stuff that doesn't need speed
optimizations.  That stuff just winds up puffing up the L1/L2 when bits of
it get touched.  A compiler smart enough to emit function code to two
different .text regions could take advantage of this.

ex.

int __fast fast1(whatever...)
{
    if (rare_case) {
    ...large blob of non-speed critical code...
    }
    ...fast code...
}

int __fast fast2(whatever...)

The way it happens today is GCC (usually) relocates the blob of speed
insensitive code towards the bottom of the function, which means you're less
likely to pick up a bit of fast2()'s prolog as you're exiting fast1, and
more likely to pollute the caches with worthless stuff.

If blocks can be designated as infrequent/error paths and relocatable to a
different .text section you stand a much better chance of picking up
something useful as functions exit.  ex:

int __fast fast1(whatever...)
{
    if (rare_case) __attribute__((slowcode)) {
    ...large blob of non-speed critical code...
    }
    ...fast code...
}

Where __attribute__((slowcode)) is defined in some macro.


----- Original Message ----- 
From: "Denis Vlasenko" <vda@ilport.com.ua>
>
> What about having a __speed macro:
>
> int very_frequently_user_func() __speed {
> ...
> }

