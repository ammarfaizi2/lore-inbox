Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293341AbSCSARe>; Mon, 18 Mar 2002 19:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293344AbSCSAR0>; Mon, 18 Mar 2002 19:17:26 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:51716 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S293317AbSCSARJ>; Mon, 18 Mar 2002 19:17:09 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7717@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'linux-serial'" <linux-serial@vger.kernel.org>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Roman Kurakin'" <rik@cronyx.ru>, Russell King <rmk@arm.linux.org.uk>
Subject: RE: Serial.c BUG 2.4.x-2.5x
Date: Mon, 18 Mar 2002 16:16:57 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Mar 07, 2002, Roman Kurakin wrote:
> 
> On Wed Mar 06, 2002, Russell King wrote:
> >
> >The patch does fine for the most part, but I have two worries:
> >
> >1. the possibilities of pushing through changes in the IO or memory space
> >   by changing the other space at the same time. (ie, port = 1, iomem =
> >   0xfe007c00 and you already have a line at port = 0, iomem =
0xfe007c00).
> >   I dealt with this properly using the resource management subsystem.
> >
> I think such code could solve this problem ...
> 
> - 	    (rs_table[i].port == new_port) &&
> + 	    ((rs_table[i].port && rs_table[i].port == new_port) ||
> +	    ((rs_table[i].iomem_base && rs_table[i].iomem_base == new_mem))
&&

Indeed it would solve this problem, but I'm not sure there is a problem to
solve here. Have not found a case where ->port and ->iomem_base fields can
both be non-zero. If one of them is always zero then the previous patch hunk
in the "address in use" test at about line 2146 is well enough:

            if ((state != &rs_table[i]) &&
                (rs_table[i].port == new_port) &&
+               (rs_table[i].iomem_base == new_mem) &&
                rs_table[i].type)
                    return -EADDRINUSE;

Assuming one of the two fields is always zero, demanding both to match for
the in use condition works anyway. If the non-zero field matches, then they
both must match. The following hunk at the bottom of function get_pci_port()
at about line 3931 seems to guarantee that they start out this way:

	[[ The req struct is memset() to zero at about line 4009 in 
	  function start_pci_pnp_board(). ]]

        if (IS_PCI_REGION_IOPORT(dev, base_idx)) {
                req->port = port;
                if (HIGH_BITS_OFFSET)
                        req->port_high = port >> HIGH_BITS_OFFSET;
                else
                        req->port_high = 0;
                return 0;
        }
        req->io_type = SERIAL_IO_MEM;
        req->iomem_base = ioremap(port, board->uart_offset);
        req->iomem_reg_shift = board->reg_shift;
        req->port = 0;
        return 0;

Does anybody see a need to add the code anyway? Did I miss a lurker? 

Best to all,

---------------------------------------------------------------- 
Ed Vance              serial24@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

