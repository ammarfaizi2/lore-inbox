Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWI1QZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWI1QZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWI1QZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:25:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:36965 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030248AbWI1QZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:25:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f4qu1Gznh8g99y56Ei/yCaHW9Sr23+ZK8KCyGpyH6fru4LMLaBZoxPRYlW5QoUZMnsj7vQ2EaGZ2XmO+wIbNzE6TMowVtxUKZqkRrPYHRh0KlVe2cAF7FRgZkqvfC91pUTcogWT/HnAtUMTR8aM9/7F6kFRp4HGnvj1/NtZQ3Bs=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Joe Perches <joe@perches.com>
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time: acpi_pm clocksource has been installed.
Date: Thu, 28 Sep 2006 18:19:43 +0200
User-Agent: KMail/1.8.2
Cc: Randy Dunlap <rdunlap@xenotime.net>, Greg KH <greg@kroah.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com> <200609281256.23175.vda.linux@googlemail.com> <1159459694.5015.19.camel@localhost>
In-Reply-To: <1159459694.5015.19.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609281819.43712.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 September 2006 18:08, Joe Perches wrote:
> On Thu, 2006-09-28 at 12:56 +0200, Denis Vlasenko wrote:
> > \#define MACSTR "%02X:%02X:%02X:%02X:%02X:%02X"
> > #define MAC(bytevector) \
> >         ((unsigned char *)bytevector)[0], \
> >         ((unsigned char *)bytevector)[1], \
> >         ((unsigned char *)bytevector)[2], \
> >         ((unsigned char *)bytevector)[3], \
> >         ((unsigned char *)bytevector)[4], \
> >         ((unsigned char *)bytevector)[5]
> 
> This is similar to the 802.11 way.
> 802.11 uses MAC_FMT and MAC_ARG.
> I think a common style is preferable.
> 
> It's fine, but it increases the size of kernel image
> by up to ~100K.  Using a common function, a stack
> automatic and "%s" in the printk decreases the size
> of the kernel. 

You deleted part of my message where I show exactly that:
a common function, which handles 80% of usage cases.

You are trying to cover all possible cases with this monstrosity:

extern char *__dev_addr6_fmt(char* buf, const unsigned char *addr);
#define DEV_ADDR6_FMT "%s" /* expands to: "FF:FF:FF:FF:FF:FF" */
#define DEV_ADDR6_BUF char __dev_addr6_buf[sizeof("FF:FF:FF:FF:FF:FF")]
#define DEV_ADDR6(addr) __dev_addr6_fmt(__dev_addr6_buf,(const unsigned char*)addr)
#define DEV_ADDR6_BUF_2 char __dev_addr6_buf_2[sizeof("FF:FF:FF:FF:FF:FF")]
#define DEV_ADDR6_2(addr) __dev_addr6_fmt(__dev_addr6_buf_2,(const unsigned char*)addr)
#define DEV_ADDR6_BUF_3 char __dev_addr6_buf_3[sizeof("FF:FF:FF:FF:FF:FF")]
#define DEV_ADDR6_3(addr) __dev_addr6_fmt(__dev_addr6_buf_3,(const unsigned char*)addr)
#define DEV_ADDR6_BUF_4 char __dev_addr6_buf_4[sizeof("FF:FF:FF:FF:FF:FF")]
#define DEV_ADDR6_4(addr) __dev_addr6_fmt(__dev_addr6_buf_4,(const unsigned char*)addr)

Usage:

DEV_ADDR6_BUF;
...
printk(", h/w address " DEV_ADDR6_FMT "\n", DEV_ADDR6(dev->dev_addr));

Why don't you use a parameter for DEV_ADDR6{_BUF}? DEV_ADDR6_BUF(var_name).
DEV_ADDR6(var_name, addr). That would be less cryptic.

In my case, it's just

print_mac(", h/w address ", dev->dev_addr, "\n");

Actually, I think it makes sense to have both: yours for complicated
cases (printk with lots of other %something) and mine for simple ones
(no local variable, smaller code).

> Strictly, not all MAC addresses are 6 byte.
> 
> Maybe all the Ethernet/TR addresses should use the
> IEEE EUI48 designation?  That feels a bit like the
> KiB/KB distinction, but it is technically correct.
> 
> Would a patch with an DEV6_ADDR->EUI48 substitution
> be acceptable?

Maybe. Doesn't look obvious, but if it is in standards...
--
vda
