Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSHFQas>; Tue, 6 Aug 2002 12:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSHFQas>; Tue, 6 Aug 2002 12:30:48 -0400
Received: from mail.esstech.com ([64.152.86.3]:57267 "HELO [64.152.86.3]")
	by vger.kernel.org with SMTP id <S313070AbSHFQar>;
	Tue, 6 Aug 2002 12:30:47 -0400
Subject: Re: ide prd table size
From: Gerald Champagne <gerald.champagne@esstech.com>
To: martin@dalecki.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D4C67F4.20807@evision.ag>
References: <1028309451.29024.659.camel@localhost.localdomain> 
	<3D4C67F4.20807@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Aug 2002 11:27:05 -0500
Message-Id: <1028651230.25642.106.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-03 at 18:32, Marcin Dalecki wrote:
> Well the documentation is a bit inadequate.
> The reality is a bit more complicated and reveals if you look at the
> actual usage pattern:
> 
> 1. Two drives on a channel share them.
> 2. primary and secondary channel are tightly coupled by the
>     host controller hardware (in esp the PIIX) and have to
>     be allocated in one go.

The comments say that happens, but it doesn't.  Here's the code as I see
it:

- setup_pci_device calls setup_host_channel once for ATA_PRIMARY and
once for ATA_SECONDARY.

- setup_host_channel calls setup_channel_dma, which calls the host-
specific dma init routine, which calls ata_init_dma.

- The routine ata_init_dma allocates the prd table.  It says that it
will allocate enough room for the primary and secondary interface.  In
reality, it allocates a page of memory for a table when called for the
primary controller and uses half of it.  Then it does the same thing
when called for the secondary controller.  Two different tables are
defined separately with no guarantees about their placement, and neither
interface uses the other table at all.

None of this is a big issue, but with the new code that constant is
exported to the bio code and it's not just an internal definition in the
ide driver any more.  Since that constant is now a little more
important, I think it should have a little more accurate definition.  Or
at least a little more accurate description if the number happens to
remain the same.

Thanks.

Gerald


