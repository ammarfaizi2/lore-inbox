Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWAGTZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWAGTZF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWAGTZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:25:05 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:32748 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161009AbWAGTZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:25:02 -0500
Date: Sat, 7 Jan 2006 11:24:58 -0800
From: "Kurtis D. Rader" <kdrader@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Platform device matching, & weird strncmp usage
Message-ID: <20060107192458.GA12409@us.ibm.com>
References: <1136527179.4840.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136527179.4840.120.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 16:59:39, Benjamin Herrenschmidt wrote:
> In 2.6.15, platform device matching works according to this comment in
> the code, or rather are supposed to:
> 
>  *	Platform device IDs are assumed to be encoded like this:
>  *	"<name><instance>", where <name> is a short description of the
>  *	type of device, like "pci" or "floppy", and <instance> is the
>  *	enumerated instance of the device, like '0' or '42'.
> 
> However, looking a few lines below, I see the actual implemetation:
> 
> static int platform_match(struct device * dev, struct device_driver * drv)
> {
> 	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
> 
> 	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
> }
> 
> As far as I know, strncmp() is _NOT_ supposed to return 0 if one string
> is shorter than the other and they match until that point. Thus the
> above will never match unless the <name> portion of pdev->name is
> exactly of size BUS_ID_SIZE which is obviously not the case...
> 
> Did I miss something or do we expect a "special" semantic for strncmp in
> the kernel ?

I can't speak to the correctness of that code but your understanding of
strncmp() is incorrect. From "GNU C Library Application Fundamentals":

    This function is the [sic] similar to strcmp, except that no more
    than size wide characters are compared. In other words, if the two
    strings are the same in their first size wide characters, the return
    value is zero.

And this has been may experience for the past 20 years and is confirmed by
this trivial program which prints zero in both cases:

#include <string.h>
#include <stdio.h>
int main() {
    printf("%d\n", strncmp("abc","abcd",3));
    printf("%d\n", strncmp("abcd","abc",3));
}
