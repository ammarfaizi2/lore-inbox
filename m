Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161307AbWGNVdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161307AbWGNVdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 17:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161308AbWGNVdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 17:33:55 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:41579 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161307AbWGNVdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 17:33:54 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Properly unregister reboot notifier in case of failure in ehci hcd
Date: Fri, 14 Jul 2006 14:33:47 -0700
User-Agent: KMail/1.7.1
Cc: Aleksey Gorelov <dared1st@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       gregkh@suse.de, stern@rowland.harvard.edu, linux-kernel@vger.kernel.org
References: <20060714164637.79842.qmail@web81212.mail.mud.yahoo.com>
In-Reply-To: <20060714164637.79842.qmail@web81212.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607141433.48695.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 July 2006 9:46 am, Aleksey Gorelov wrote:

> David, Alan,
> 
> Do you think it is Ok to unregister reboot notifier in ehci_run before registering one to make
> sure there is no 'double registering' of notifier, or is it better to move register/unregister
> reboot notifier from ehci_run/ehci_stop completely to some other place ?

Probably the best way is to stop using the notifier, and brute force it
by making every EHCI subdriver get its own shutdown() method.  That'd be
obvious enough for PCI bus glue, and due to recent patches probably even
for the non-PCI ones ... since they all use "platform_bus" now, they can
all share the same method.  Though I could imagine some platforms might
want to do extra stuff like clk_disable() after the root hub reset.

I could see the tail end of ehci-hcd.c with a forward decl for a method
like ehci_platform_shutdown(), updating the subdrivers to reference that,
and then #ifdef PLATFORM_DRIVER provide the definition of that routine
(doing what the reboot notifier does) for use by the non-PCI subdrivers.

- Dave

