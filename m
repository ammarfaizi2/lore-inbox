Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266259AbUFPMSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUFPMSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266260AbUFPMSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:18:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28582 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266259AbUFPMSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:18:51 -0400
Date: Wed, 16 Jun 2004 13:18:51 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Linux 2.6.7
Message-ID: <20040616121850.GO12308@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> <20040616111329.GA1571@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616111329.GA1571@louise.pinerecords.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 01:13:29PM +0200, Tomas Szepe wrote:
> On Jun-15 2004, Tue, 22:56 -0700
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Summary of changes from v2.6.7-rc3 to v2.6.7
> [snip]
> 
> 2.6.7's airo.ko (unlike 2.6.6's) won't allow the user to set
> ESSID via "echo myessid >/proc/driver/aironet/ethX/SSID".
> 
> Changes like this shouldn't probably be made in the middle
> of a stable series.

Changes like this are called bugs.  The thing is, original variant of
function (actually, both read and write) was also buggy and trivially
exploitable, so fixing it was needed.  Fscking it up was not, obviously.

Fix follows; see if it works for you.

--- RC7/drivers/net/wireless/airo.c	Mon Jun  7 19:21:27 2004
+++ RC7-current/drivers/net/wireless/airo.c	Wed Jun 16 08:11:50 2004
@@ -4527,6 +4527,8 @@
 		len = priv->maxwritelen - pos;
 	if (copy_from_user(priv->wbuffer + pos, buffer, len))
 		return -EFAULT;
+	if (pos + len > priv->writelen)
+		priv->writelen = pos + len;
 	*offset = pos + len;
 	return len;
 }
