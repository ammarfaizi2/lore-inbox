Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVF3K2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVF3K2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVF3K1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:27:22 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:48271 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262937AbVF3KVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:21:34 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deinline sleep/delay functions
Date: Thu, 30 Jun 2005 13:21:20 +0300
User-Agent: KMail/1.5.4
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <200506300852.25943.vda@ilport.com.ua> <20050630021111.35aaf45f.akpm@osdl.org> <1120123189.3181.28.camel@laptopd505.fenrus.org>
In-Reply-To: <1120123189.3181.28.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506301321.20692.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 June 2005 12:19, Arjan van de Ven wrote:
> 
> > > There are a number of compile-time checks that your patch has removed
> > > which catch such things, and as such your patch is not acceptable.
> > > Some architectures have a lower threshold of acceptability for the
> > > maximum udelay value, so it's absolutely necessary to keep this.
> > 
> > It removes that check from x86 - other architectures retain it.
> > 
> > I don't recall seeing anyone trigger the check,
> 
> I do ;) Esp in vendor out of tree crap. It's a good compile time
> diagnostic so the junk code doesnt' hit mainline but gets fixed first.

It seems my patch was incomplete.

Thinking more about it, since it exists in all arches
and also since delaying is not performance critical
(hey, if we're going to delay/sleep, we surely can burn
a few more cycles), this can be done as follows:

linux/timer.c:

void ndelay(unsigned int nsecs)
{
	unsigned int m = nsecs/(1024*1024);
       	while (m--)
		__ndelay(1024);
	__ndelay(nsecs % (1024*1024));
}

void udelay(unsigned int usecs)
{
	unsigned int k = usecs/1024;
       	while (k--)
		__udelay(1024);
	__udelay(usecs % 1024);
}

void mdelay(unsigned int msecs)
{
       	while (msecs--)
		udelay(1000);
}

void ssleep(unsigned int secs)
{
        msleep(secs * 1000);
}

and arches will need to only supply two functions:

__udelay(n) [n is guaranteed <1024]
__ndelay(n) [n is guaranteed <1024*1024]

For users, _any_ value, however large, will work for
any delay function.

Comments?
--
vda

