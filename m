Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbRFEB6l>; Mon, 4 Jun 2001 21:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263082AbRFEB6b>; Mon, 4 Jun 2001 21:58:31 -0400
Received: from hera.cwi.nl ([192.16.191.8]:61679 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263080AbRFEB6N>;
	Mon, 4 Jun 2001 21:58:13 -0400
Date: Tue, 5 Jun 2001 03:58:03 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106050158.DAA189320.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        mdharm-usb@one-eyed-alien.net
Subject: Unit attention in USB storage
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last month my CF reader read CF cards happily.
Now that I returned from Denmark, I find that it no longer works
(with the same 2.4.3 kernel). Indeed, it is not properly detected.

The reason seems to be slightly different timing at bootup -
maybe because I connected a wheelmouse this time -
and now this device comes with Unit Attention
	(code 70, key 6, ASC 28, ASCQ 0: not ready to ready transit)
and this is regarded as an error return and the initial INQUIRY fails.

Thus, since this code actually occurs in real life, we should
probably add

	case 0x2800: what="not ready to ready transtion (media change?)";
		break;

in debug.c:usb_stor_show_sense().
I have not really thought about the proper treatment of this Unit Attention.
However, if one decides that really nothing at all is wrong when a device
tells us that it is ready now, then

                if ((srb->sense_buffer[2] & 0xf) == 0x6 /* unit attention */
                    && srb->sense_buffer[12] == 0x28
                    && srb->sense_buffer[13] == 0 /* not ready -> ready */)
                        srb->result = GOOD << 1;

is perhaps not too unreasonable. (This is in usb/storage/transport.c,
usb_stor_invoke_transport(), at the end of the need autosense part.)
Anyway, with this addition (to 2.4.3) all works for me again.

Andries
