Return-Path: <linux-kernel-owner+w=401wt.eu-S1754671AbXAAAnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbXAAAnK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 19:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbXAAAnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 19:43:10 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:50283 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671AbXAAAnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 19:43:09 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
Date: Mon, 1 Jan 2007 01:43:00 +0100
User-Agent: KMail/1.9.5
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>,
       Amit Choudhary <amit2030@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061221234127.29189.qmail@web55606.mail.re4.yahoo.com> <Pine.LNX.4.61.0612280952450.15825@yvahk01.tjqt.qr> <1167572312.3318.47.camel@gimli.at.home>
In-Reply-To: <1167572312.3318.47.camel@gimli.at.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701010143.02870.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 31. December 2006 14:38, Bernd Petrovitsch wrote:
> That depends on the decision/definition if (so called) "double free" is
> an error or not (and "free(NULL)" must work in POSIX-compliant
> environments).

A double free of non-NULL is certainly an error.
So the idea of setting it to NULL is ok, since then you can
kfree the variable over and over again without any harm.

It is just complicated to do this side effect free.

Maybe one should check for builtin-constant and take the address,
if this is not an builtin-constant.

sth, like this

#define kfree_nullify(x) do { \
	if (__builtin_constant_p(x)) { \
		kfree(x); \
	} else { \
		typeof(x) *__addr_x = &x; \
		kfree(*__addr_x); \
		*__addr_x = NULL; \
	} \
} while (0)

Regards

Ingo Oeser
