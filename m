Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263055AbVAFWD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbVAFWD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbVAFWD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:03:27 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:8833 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S263055AbVAFV7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:59:44 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Date: Thu, 6 Jan 2005 13:59:25 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       mst@mellanox.co.il, akpm@osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
References: <20050106145356.GA18725@infradead.org> <20050106210921.GK5772@vana.vc.cvut.cz> <20050106212424.GA6465@kroah.com>
In-Reply-To: <20050106212424.GA6465@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200501061359.25719.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 January 2005 1:24 pm, Greg KH wrote:
> > P.S.:  When designing new API, please do not make it unnecessary complicated.
> > USB video needs rather large bandwidth and low latency, so please no ASCII
> > strings, and scatter-gather aware API helps a bit...
> 
> In measurements published on linux-usb-devel, pure userspace calls using
> the current usbfs code generated almost full bandwidth usage (within the
> hardware limits).  So adding the scatter-gather api interface to usbfs
> wouldn't really provide that much benefit.

Actually, the measurements I recall were using that
nasty usbfs-specific async API ... or using huge
buffers with the synchronous/blocking calls, so
the hiccups added by scheduling latencies didn't
kick in very often.


> And, we can always use help in designing such an API, if you could find
> someone at your company to help us out in doing so... :)

Or just doing something like gadgetfs, where the standard
Linux "libaio" calls work just fine.  I was certainly able
to stream 24 Mbyte/sec isochronous transfers (that's the
top speed possible with one high speed ISO endpoint).

The key point is that one userspace IOCB should map directly
to one URB in the kernel; and one userspace file (descriptor)
should map to one USB endpoint.  For a host side API, it turns
out that isochronous URBs already have limited scatter/gather
style support -- each one maps to several packets.

I think it'd be best to use the existing AIO support rather
than have usbfs2 create yet another USB-specific thing.

- Dave
