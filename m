Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWGFCxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWGFCxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 22:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWGFCxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 22:53:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16005 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965087AbWGFCxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 22:53:40 -0400
Date: Wed, 5 Jul 2006 19:53:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: miles.lane@gmail.com, petkan@users.sourceforge.net,
       linux-kernel@vger.kernel.org, david-b@pacbell.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.17-mm5 -- netconsole failed to send full trace
Message-Id: <20060705195330.6c58b43a.akpm@osdl.org>
In-Reply-To: <20060705194614.ae2be901.akpm@osdl.org>
References: <a44ae5cd0607030131x745b3106ydd2a4ca086cdf401@mail.gmail.com>
	<20060703014016.9f598cef.akpm@osdl.org>
	<a44ae5cd0607030704q63f1f64x5e46688cef6fa44c@mail.gmail.com>
	<20060703121717.b36ef57e.akpm@osdl.org>
	<a44ae5cd0607051144w5734ce4bkd38320adda99ae43@mail.gmail.com>
	<a44ae5cd0607051934o2656a40bs88393dc0d6591249@mail.gmail.com>
	<20060705194229.8ffe85d9.akpm@osdl.org>
	<20060705194614.ae2be901.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 19:46:14 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Wed, 5 Jul 2006 19:42:29 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Wed, 5 Jul 2006 19:34:52 -0700
> > "Miles Lane" <miles.lane@gmail.com> wrote:
> > 
> > > On 7/5/06, Miles Lane <miles.lane@gmail.com> wrote:
> > > > Hi Petko,
> > > >
> > > > David Brownell pointed out that you are the author of this driver (rtl8150).
> > > > My laptop is crashing every time I remove the Linksys EtherFast 10/100
> > > > Compact Network Adapter (model USB100M) from the USB port.
> > > >
> > > > Here's a link to the discussion thus far:
> > > > http://groups.google.com/group/linux.kernel/tree/browse_frm/thread/8c93e310c7b71242/a8a1e3edb1601906?rnum=1&q=miles+lane&_done=%2Fgroup%2Flinux.kernel%2Fbrowse_frm%2Fthread%2F8c93e310c7b71242%2Fc8a8ba47c49c39fc%3Ftvc%3D1%26q%3Dmiles+lane%26#doc_a8a1e3edb1601906
> > > >
> > > > Here's the stacktrace:
> > > > http://www.zip.com.au/~akpm/linux/patches/stuff/00003.jpg
> > > >
> > > > I have reproduced the bug with vanilla 2.6.17.  I am currently working my
> > > > back through kernel versions to try to isolate the responsible patches.
> > > 
> > > 2.6.15 is the first kernel earliest kernel that seems to work with Ubuntu 6.06's
> > > implementation of hal / udev / dbus.  It does set up the adapter successfully.
> > > 
> > > I was able to reproduce the crash with 2.6.15.  I have attached a screenshot
> > > of the stacktrace.  It may help, since it differs quite a bit from the one for
> > > 2.6.17-mm5.
> > 
> > The attachment will be too large to make it onto most mailing lists.  I put
> > a copy here: http://www.zip.com.au/~akpm/linux/patches/stuff/00005.jpg
> > 
> > > BTW, should I join linux-usb-devel and CC that list?  Also, should I take
> > > this discussion off of LKML?
> > 
> > Nah, spread it around.  Who knows, somoene might actually fix the bug ;)
> 
> I don't suppose it's this easy?
> 
> --- a/drivers/usb/net/rtl8150.c~a
> +++ a/drivers/usb/net/rtl8150.c
> @@ -909,6 +909,7 @@ static void rtl8150_disconnect(struct us
>  	usb_set_intfdata(intf, NULL);
>  	if (dev) {
>  		set_bit(RTL8150_UNPLUG, &dev->flags);
> +		tasklet_kill(&dev->tl);
>  		tasklet_disable(&dev->tl);
>  		unregister_netdev(dev->netdev);
>  		unlink_all_urbs(dev);
> _
> 

Better:

--- a/drivers/usb/net/rtl8150.c~a
+++ a/drivers/usb/net/rtl8150.c
@@ -910,6 +910,7 @@ static void rtl8150_disconnect(struct us
 	if (dev) {
 		set_bit(RTL8150_UNPLUG, &dev->flags);
 		tasklet_disable(&dev->tl);
+		tasklet_kill(&dev->tl);
 		unregister_netdev(dev->netdev);
 		unlink_all_urbs(dev);
 		free_all_urbs(dev);
_

But I suspect it won't help.

