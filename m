Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWFBJxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWFBJxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 05:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWFBJxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 05:53:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:17397 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751283AbWFBJxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 05:53:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=G0E9YcGHgbpqbjsxAqnlL5Pv2VlfROKph22znCOfSpziCQvr1ItVGDdDB2P0NZkyWIpR6TTwx6PFNprvkcofICrQlrUcOT9G08Fhl3kz4Abx4EfPTMDdWOlVYi9hD9MRXPQVIlhHrLYoYqPKilA2MdyeDC7GMU/G8AQ843NYUt4=
Date: Fri, 2 Jun 2006 09:53:03 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Zhu Yi <yi.zhu@intel.com>
Cc: Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       jketreno@linux.intel.com
Subject: Re: [patch mm1-rc2] lock validator: netlink.c netlink_table_grab fix
Message-ID: <20060602095303.GA1115@slug>
References: <20060529212109.GA2058@elte.hu> <20060530091415.GA13341@ens-lyon.fr> <20060601144241.GA952@slug> <1149217811.13745.127.camel@debian.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149217811.13745.127.camel@debian.sh.intel.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 11:10:10AM +0800, Zhu Yi wrote:
> On Thu, 2006-06-01 at 16:42 +0200, Frederik Deweerdt wrote:
> > This got rid of the oops for me, is it the right fix?
> 
> I don't think netlink will contend with hardirqs. Can you test with this
> fix for ipw2200 driver?
> 
It does work, thanks. But doesn't this add a possibility of missing 
some interrupts?
	cpu0				cpu1
        ====				====
in isr				in tasklet

				ipw_enable_interrupts
				|->priv->status |= STATUS_INT_ENABLED;

ipw_disable_interrupts
|->priv->status &= ~STATUS_INT_ENABLED;
|->ipw_write32(priv, IPW_INTA_MASK_R, ~IPW_INTA_MASK_ALL);

				|->ipw_write32(priv, IPW_INTA_MASK_R, IPW_INTA_MASK_ALL);
				/* This is possible due to priv->lock no longer being taken
				   in isr */

=>interrupt from ipw2200
in new isr
if (!(priv->status & STATUS_INT_ENABLED))
	return IRQ_NONE; /* we wrongfully return here because priv->status
                            does not reflect the register's value */


Not sure this is really important at all, just curious.

Thanks,
Frederik
