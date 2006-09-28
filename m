Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965309AbWI1LCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309AbWI1LCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbWI1LCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:02:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:48800 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965309AbWI1LCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:02:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ujlTLJZLAneJyWvW/3RLiKk8l9gRNXDJcbefoOsaI+5QCbOhcK0TIZIFy0+HwLfbsc2nLzKZMk9qKGK8NY8BwNqYFm3d8Oty43p0gApSvni0IyUZ3R82GtOVMMfITI5cbWqE2mwNxrPUHYzcCVHgQPDurYeE4mOS/qH6KjLT86k=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time: acpi_pm clocksource has been installed.
Date: Thu, 28 Sep 2006 12:56:23 +0200
User-Agent: KMail/1.8.2
Cc: Joe Perches <joe@perches.com>, Greg KH <greg@kroah.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com> <1159333843.13196.6.camel@localhost> <20060926221718.7e20613e.rdunlap@xenotime.net>
In-Reply-To: <20060926221718.7e20613e.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609281256.23175.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 07:17, Randy Dunlap wrote:
> On Tue, 26 Sep 2006 22:10:43 -0700 Joe Perches wrote:
> 
> > On Tue, 2006-09-26 at 21:56 -0700, Randy Dunlap wrote:
> > > > Nope, that's part of the NIC's MAC address.  It was split up.
> > > 
> > > Sorry.  In this case, it was via-rhine.c:
> > > 
> > > 	for (i = 0; i < 5; i++)
> > > 		printk("%2.2x:", dev->dev_addr[i]);
> > > 	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], pdev->irq);
> > > 
> > > so it does break the printk()s up itself.
> > 
> > Changing all of those MAC address printks to a single function
> > could prevent this.
> > 
> > http://www.uwsg.iu.edu/hypermail/linux/net/0602.1/0002.html
> 
> True enough.  Thanks for the patch.
> However, in this case, the single-printed MAC address still needs
> a \n, with the IRQ on a separate line (wasting vertical screen space),
> or it needs a custom printk() that is all done at one time.

Custom print_mac worked very nice for me in acx driver.
In order to accomodate arbitrary text before/after mac addres,
I did it this way:

#define MACSTR "%02X:%02X:%02X:%02X:%02X:%02X"
#define MAC(bytevector) \
        ((unsigned char *)bytevector)[0], \
        ((unsigned char *)bytevector)[1], \
        ((unsigned char *)bytevector)[2], \
        ((unsigned char *)bytevector)[3], \
        ((unsigned char *)bytevector)[4], \
        ((unsigned char *)bytevector)[5]

void print_mac(const char *head, const unsigned char *mac, const char *tail)
{
        printk("%s"MACSTR"%s", head, MAC(mac), tail);
}


Usage: print_mac("adev->bssid: ", adev->bssid, "\n");
--
vda
