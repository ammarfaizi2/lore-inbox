Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWI1RDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWI1RDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbWI1RDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:03:19 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:2823 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S1751941AbWI1RDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:03:18 -0400
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time:
	acpi_pm clocksource has been installed.
From: Joe Perches <joe@perches.com>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Greg KH <greg@kroah.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200609281819.43712.vda.linux@googlemail.com>
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com>
	 <200609281256.23175.vda.linux@googlemail.com>
	 <1159459694.5015.19.camel@localhost>
	 <200609281819.43712.vda.linux@googlemail.com>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 10:03:10 -0700
Message-Id: <1159462990.5015.50.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 18:19 +0200, Denis Vlasenko wrote:
> You are trying to cover all possible cases with this monstrosity:
> extern char *__dev_addr6_fmt(char* buf, const unsigned char *addr);
> #define DEV_ADDR6_FMT "%s" /* expands to: "FF:FF:FF:FF:FF:FF" */
> #define DEV_ADDR6_BUF char __dev_addr6_buf[sizeof("FF:FF:FF:FF:FF:FF")]
> DEV_ADDR6_BUF;
> ...
> printk(", h/w address " DEV_ADDR6_FMT "\n", DEV_ADDR6(dev->dev_addr));

Yup, it's not pretty.

> Why don't you use a parameter for DEV_ADDR6{_BUF}? DEV_ADDR6_BUF(var_name).
> DEV_ADDR6(var_name, addr). That would be less cryptic.

Your idea makes code a bit visually longer, but I've no real objection.

> print_mac(", h/w address ", dev->dev_addr, "\n");

> > Would a patch with a DEV6_ADDR->EUI48 substitution
> > be acceptable?
> 
> Maybe. Doesn't look obvious, but if it is in standards...

Perhaps:

extern char *__EUI48_fmt(char *buf, const unsigned char *addr);
#define EUI48_FMT "%s" /* expands to: "FF:FF:FF:FF:FF:FF" */
#define DECLARE_EUI48(name) char name[sizeof("FF:FF:FF:FF:FF:FF")]
#define EUI48(name, addr) __EUI48_fmt(name, (const unsigned char *)addr)

use case:

{
	DECLARE_EUI48(eui48);
	printk("mac: " EUI48_FMT, EUI48(eui48, dev->dev_addr));
}

Here's one with an assumption of an eui48 buffer name.

extern char *__EUI48_fmt(char *buf, const unsigned char *addr);
#define EUI48_FMT "%s" /* expands to: "FF:FF:FF:FF:FF:FF" */
#define DECLARE_EUI48 char __eui48_buf[sizeof("FF:FF:FF:FF:FF:FF")]
#define EUI48(addr) __EUI48_fmt(__eui48_buf, (const unsigned char *)addr)

use case:

{
	DECLARE_EUI48;
	printk("mac: " EUI48_FMT, EUI48(dev->dev_addr));
}

Which one do you like more?

