Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTHZXgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 19:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbTHZXgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 19:36:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20981 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262934AbTHZXgd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 19:36:33 -0400
Message-ID: <3F4BEE68.A6C862C2@us.ibm.com>
Date: Tue, 26 Aug 2003 16:34:00 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>, Randy Dunlap <rddunlap@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Net device error logging, revised
References: <3F4A8027.6FE3F594@us.ibm.com> <20030826183221.GB3167@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> On Mon, Aug 25, 2003 at 02:31:19PM -0700, Jim Keniston wrote:
> > +int __netdev_printk(const char *sevlevel, const struct net_device *netdev,
> > +     int msglevel, const char *format, ...)
> > +{
> > +     if (!netdev || !format) {
> > +             return -EINVAL;
> > +     }
> > +     if (msglevel == NETIF_MSG_ALL || (netdev->msg_enable & msglevel)) {
> > +             char msg[512];
> 
> 512 bytes on the stack?  Any way to prevent this from happening?  With
> the push to make the stack even smaller in 2.7, people will not like
> this.
> 
> thanks,
> 
> greg k-h

The following options come to mind:
1. Keep the msg buffer, but make it smaller.  Around 120 bytes would probably be
big enough for the vast majority of messages.  (printk() uses a 1024-byte buffer,
but it's static -- see #2.)

2. Use a big, static buffer, protected by a spinlock.  printk() does this.

3. Do the whole thing in a macro, as in previous proposals.  The size of the macro
expansion could be reduced somewhat by doing the encode-prefix step in a function --
something like:

#define netdev_printk(sevlevel, netdev, msglevel, format, arg...)	\
do {									\
if (NETIF_MSG_##msglevel == NETIF_MSG_ALL || ((netdev)->msg_enable & NETIF_MSG_##msglevel)) {	\
	char pfx[40];							\
	printk(sevlevel "%s: " format , make_netdev_msg_prefix(pfx, netdev) , ## arg);	\
}} while (0)

This would make your code bigger, but not that much bigger for the common case where
the msglevel is omitted (and the 'if(...)' is optimized out).

Jim
