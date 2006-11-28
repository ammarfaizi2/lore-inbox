Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935876AbWK1Lso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935876AbWK1Lso (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 06:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935875AbWK1Lso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 06:48:44 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:45285 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S935876AbWK1Lsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 06:48:43 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Subject: Re: O2micro smartcard reader driver.
Date: Tue, 28 Nov 2006 12:49:45 +0100
User-Agent: KMail/1.8
Cc: Laurent Bigonville <l.bigonville@edpnet.be>, linux-kernel@vger.kernel.org
References: <20061127182817.d52dfdf1.l.bigonville@edpnet.be> <456C0BD0.7080606@tremplin-utc.net>
In-Reply-To: <456C0BD0.7080606@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611281249.45243.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Latest version I've published is there:
> http://pieleric.free.fr/o2scr/

        case OZSCR_OPEN: /* Request ICC */
            dprintk("OZSCR_OPEN\n");
            ATRLength = ATR_SIZE;
            pRdrExt->IOBase = (PSCR_REGISTERS *) dev->io_base; //XXX necessary?
            pRdrExt->membase = dev->am_base; //XXX necessary?

            pRdrExt->m_SCard.AvailableProtocol = 0;
            pRdrExt->m_SCard.RqstProtocol = 0;
            dprintk("membase:%p\n", pRdrExt->membase);
            dprintk("ioport:0x%03x\n", (unsigned)pRdrExt->IOBase);

            ret = CmdResetReader( pRdrExt, FALSE, ATRBuffer, &ATRLength );
            apdu.LengthOut = ATRLength;

#ifdef PCMCIA_DEBUG
            printk(KERN_DEBUG "Open finished, ATR buffer = ");
            for( ATRLength = 0; ATRLength < apdu.LengthOut; ATRLength++ )
                printk(" [%02X] ", ATRBuffer[ATRLength] );
            printk("\n");
#endif

            memcpy( apdu.DataOut, ATRBuffer, ATRLength );
            ret = copy_to_user((struct ozscr_apdu *)arg, &apdu, sizeof(struct ozscr_apdu));
            break;

1. This needs locking against concurrent ioctls
2. The interpretation of copy_to_user()'s return code is incorrect

            ret = copy_from_user(&apdu, (struct ozscr_apdu *)arg, sizeof(struct ozscr_apdu));
You need to check ret, or you might write shit to the device
            pRdrExt->IOBase = (PSCR_REGISTERS *) dev->io_base;
            pRdrExt->membase = dev->am_base;
            pRdrExt->m_SCard.RqstProtocol = apdu.DataIn[6];
            dprintk("membase:%p\n", pRdrExt->membase);
            dprintk("ioport:0x%03x\n", (unsigned)pRdrExt->IOBase);
            ret = CmdResetReader( pRdrExt, FALSE, ATRBuffer, &ATRLength );

	HTH
		Oliver
