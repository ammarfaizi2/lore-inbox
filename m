Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSJ2WIs>; Tue, 29 Oct 2002 17:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSJ2WIs>; Tue, 29 Oct 2002 17:08:48 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:61453 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262380AbSJ2WIr>;
	Tue, 29 Oct 2002 17:08:47 -0500
Date: Tue, 29 Oct 2002 14:12:34 -0800
From: Greg KH <greg@kroah.com>
To: Marco Roeland <marco.roeland@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.5.44-ac3
Message-ID: <20021029221234.GA29085@kroah.com>
References: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com> <20021025125514.GA30278@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025125514.GA30278@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 02:55:14PM +0200, Marco Roeland wrote:
> 
> > Linux 2.5.44-ac2
> > o	Rip out lots of the left over pcibios_ stuff	(Greg Kroah-Hartmann)
> 
> Since -ac2 there's a pcibios_read_config_dword left in drivers/pcmcia/cist.c
> preventing (CardBus) PCMCIA to compile.
> 
> The following makes it compile again, whether it _works_ I've absolutely no
> idea, lacking amongst others any kernel knowledge or even a cardbus card.
> Compiles for me (TM) ;-)

Here's a working patch (well, works for me (tm)) for this problem:

thanks,

greg k-h


diff -Nru a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
--- a/drivers/pcmcia/cistpl.c	Wed Oct 30 13:59:29 2002
+++ b/drivers/pcmcia/cistpl.c	Wed Oct 30 13:59:29 2002
@@ -429,7 +429,10 @@
 #ifdef CONFIG_CARDBUS
     if (s->state & SOCKET_CARDBUS) {
 	u_int ptr;
-	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
+	struct pci_dev *dev = pci_find_slot (s->cap.cb_dev->subordinate->number, 0);
+	if (!dev)
+	    return CS_BAD_HANDLE;
+	pci_read_config_dword(dev, 0x28, &ptr);
 	tuple->CISOffset = ptr & ~7;
 	SPACE(tuple->Flags) = (ptr & 7);
     } else
