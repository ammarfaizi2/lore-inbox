Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVACSJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVACSJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVACSFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:05:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6327 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261551AbVACSCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:02:11 -0500
Date: Mon, 3 Jan 2005 18:02:09 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Len Brown <len.brown@intel.com>
Cc: Michael Geithe <warpy@gmx.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: __iounmap: bad address c00f0000 (Re: 2.6.10-bk5)
Message-ID: <20050103180209.GW26051@parcelfarce.linux.theplanet.co.uk>
References: <200501030114.55399.warpy@gmx.de> <1104773076.18173.64.camel@d845pe> <1104774583.18174.68.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104774583.18174.68.camel@d845pe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 12:49:43PM -0500, Len Brown wrote:
> Suggested-by: Al Viro
> Signed-off-by: Len Brown <len.brown@intel.com>
> 
> 
> ===== arch/i386/kernel/dmi_scan.c 1.74 vs edited =====
> --- 1.74/arch/i386/kernel/dmi_scan.c	2004-12-28 14:07:48 -05:00
> +++ edited/arch/i386/kernel/dmi_scan.c	2005-01-03 12:46:33 -05:00
> @@ -126,12 +126,12 @@
>  			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n",
>  				base));
>  			if(dmi_table(base,len, num, decode)==0) {
> -				iounmap(p);
> +				/* too early to call iounmap(p); */

One comment: iounmap() on result of ioremap(ISA address) is a no-op.
The problem in this case is that we are too early in setup sequence
and that confuses iounmap() into not recognizing that fact.  So we
end up trying to find VMA created by ioremap() and (surprise, surprise)
find none.  Which gives the warning in question.  We *still* do nothing,
so everything actually works fine, but we do get confused "WTF is going
on?" in the logs.
