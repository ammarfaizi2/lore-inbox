Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTGCPlB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTGCPlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:41:01 -0400
Received: from ping.uio.no ([129.240.78.2]:59660 "EHLO ping.uio.no")
	by vger.kernel.org with ESMTP id S264460AbTGCPk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:40:58 -0400
To: Aurelien Minet <a.minet@prim-time.fr>
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] rfcomm oops in 2.5.74
References: <d8jznjvzr07.fsf@wirth.ping.uio.no>
	<3F04458C.4070502@prim-time.fr>
From: ilmari@ilmari.org (Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?=)
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Date: Thu, 03 Jul 2003 17:54:10 +0200
In-Reply-To: <3F04458C.4070502@prim-time.fr> (Aurelien Minet's message of
 "Thu, 03 Jul 2003 17:02:36 +0200")
Message-ID: <d8jptkrzjvh.fsf@wirth.ping.uio.no>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurelien Minet <a.minet@prim-time.fr> writes:

Hi Aurelien, and thanks for the quick response.

>> Calling socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM) on 2.5.74
>> segfaults and gives the below oops. module.h:297 is
>> BUG_ON(module_refcount(module) == 0) in __module_get(), which is called
>> from rfcomm_sock_alloc() via sk_set_owner().
>
> I don't know for 2.5.xx  but for 2.4.xx in order to use RFCOMM protocol
> you must use a SOCK_STREAM and not SOCK_RAW socket type.
> (SOCK_RAW is for HCI , SOCK_SEQPACKET & SOCK_DGRAM for L2cap)
> I think it must return an error instead of making a segfault, in this
> way it is a bug.

I noticed it when rfcomm(1) segfaulted and caused the oops on startup,
so I straced it. The strace output is:

  [linking stuff snipped]
  socket(0x1f /* PF_??? */, SOCK_RAW, 3 <unfinished ...>
  +++ killed by SIGSEGV +++

According to <net/bluetooth/bluetooth.h> 0x1f is PF_BLUETOOTH and 3 is
PTPROTO_RFCOMM. Looking at the source, rfcomm(1) uses SOCK_RAW for the
RFCOMM control socket (for ioctls: RFCOMMGETDEVLIST, RFCOMMCREATEDEV,
RFCOMMRELEASEDEV, RFCOMMGETDEVINFO), and SOCK_STREAM for the data
sockets.

What is the correct way of doing these ioctls on 2.5 if not against a
SOCK_RAW socket?

-- 
ilmari
