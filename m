Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267822AbTBROqw>; Tue, 18 Feb 2003 09:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267833AbTBROqw>; Tue, 18 Feb 2003 09:46:52 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:61921 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267822AbTBROqv>; Tue, 18 Feb 2003 09:46:51 -0500
Date: Tue, 18 Feb 2003 15:55:03 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: stuff-up in pcmcia/cardbus stuff
Message-ID: <20030218145502.GA1233@brodo.de>
References: <15953.37244.263505.214325@argo.ozlabs.ibm.com> <20030218081529.GA2334@brodo.de> <3E51FBA1.7020208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E51FBA1.7020208@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 04:23:45AM -0500, Jeff Garzik wrote:
> Dominik Brodowski wrote:
> >Indeed. socket->pcmcia_socket (old) == socket->cls_d.s_info[0] (new)
> 
> If this is true...
> 
> >@@ -230,14 +230,16 @@
> > static int cardbus_suspend (struct pci_dev *dev, u32 state)
> > {
> > 	pci_socket_t *socket = pci_get_drvdata(dev);
> >-	pcmcia_suspend_socket (socket->pcmcia_socket);
> >+	if (socket && socket->cls_d.s_info[0])
> >+		pcmcia_suspend_socket (socket->cls_d.s_info[0]);
> > 	return 0;
> > }
> > 
> > static int cardbus_resume (struct pci_dev *dev)
> > {
> > 	pci_socket_t *socket = pci_get_drvdata(dev);
> >-	pcmcia_resume_socket (socket->pcmcia_socket);
> >+	if (socket && socket->cls_d.s_info[0])
> >+		pcmcia_resume_socket (socket->cls_d.s_info[0]);
> > 	return 0;
> > }
> 
> 
> 1) ...why do you bother checking for NULL?  Isn't NULL indicative of a 
> BUG(), instead?

Well, it's only a safeguard against suspending / resuming combined with 
probing or removing the device. Else it's a BUG indeed...

> 2) why are multiple s_info records allocated, when you hardcode use of 
> record #0 ?
Only one s_info is actually allocated (in cs.c::pcmcia_register_socket) as
only one pcmcia/cardbus socket is attached to one pci_dev for yenta-style
devices. There are up to four pcmcia sockets to one pci_dev for i82092
devices, though. And so s_info[3] might be perfectly valid within the
i82092 driver.

	Dominik

