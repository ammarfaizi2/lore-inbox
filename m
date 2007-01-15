Return-Path: <linux-kernel-owner+w=401wt.eu-S1751025AbXAOQ5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbXAOQ5G (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 11:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbXAOQ5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 11:57:06 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:35981 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbXAOQ5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 11:57:05 -0500
Date: Mon, 15 Jan 2007 17:56:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Suhabe Bugrara <suhabe@stanford.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: user pointer bugs
In-Reply-To: <5166c2f30701141558td770dfbt13fd5098f76bcde6@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0701151746370.23841@yvahk01.tjqt.qr>
References: <5166c2f30701141558td770dfbt13fd5098f76bcde6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 14 2007 15:58, Suhabe Bugrara wrote:
>
> In linux-2.6.19.2, do the following lines have bugs in them? It looks
> like they dereference a user pointer without first being checked by
> the "access_ok" macro to ensure that they point into userspace.
>
> Suhabe
>
> ========================
> File: sound/isa/sscape.c
> Lines: 550, 665
> Description: The pointer "bb" is dereferenced in the expression
> "bb->code" without being checked first.
> Fix: Replace "bb->code" with "&bb->code"

Looking at 2.6.20-rc5 now...

550: ret = upload_dma_data(sscape, bb->code, sizeof(bb->code));
665: if ( !access_ok(VERIFY_READ, bb->code, sizeof(bb->code)) )

Here's a test:

$ cat x.c
/*1*/ struct foo {
/*2*/     char bar[256];
/*3*/ };
/*4*/ int main(void) {
/*5*/     struct foo tmp;
/*6*/     char *x = tmp.bar;
/*7*/     char *y = &tmp.bar;
/*8*/     return 0;
/*9*/ }

$ cc x.c -Wall
x.c:7: warning: initialization from incompatible pointer type

Hence, &bb->code would be wrong. Really. (Talk to ##c or comp.lang.c
perhaps on details.)

>
> ========================
> File: block/scsi_ioctl.c
> Lines: 406, 427, 430, 482, 486
> Description: The pointer "sic" is dereferenced in the expression
> "sic->data" without being checked first.
> Fix: Replace "sic->code" with "&sic->code"

Same. sic->code decays into a char* when used.
This gets boring, I won't look at the others.


	-`J'
-- 
