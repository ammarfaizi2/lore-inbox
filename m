Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUBRDDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUBRDDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:03:15 -0500
Received: from dp.samba.org ([66.70.73.150]:7328 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262048AbUBRDCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:02:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16434.54737.59564.622998@samba.org>
Date: Wed, 18 Feb 2004 14:02:41 +1100
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <200402172327.08962.robin.rosenberg.lists@dewire.com>
References: <16433.38038.881005.468116@samba.org>
	<200402172208.25398.robin.rosenberg.lists@dewire.com>
	<Pine.LNX.4.58.0402171314320.2154@home.osdl.org>
	<200402172327.08962.robin.rosenberg.lists@dewire.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin,

 > Having to put up with the existence of Windows day in and out is
 > the reason I'm still on an eight-bit encoding.  Sorry for not
 > explaining the REAL problem, but only a partial problem. I need to
 > support all kinds of clients on Windows with protocols that convey
 > no character set info. With samba that's no problem. Having to put
 > up with a Unix world running ISO-8859-1 (or ISO-8859-15) is
 > another. Ofcourse that means Linux machines also add to the
 > disturbance by not storing things as unicode. The real obstable is
 > file names, everything else including content of files, I can
 > handle (I think). Maybe I'll find a solution for the filenames too,
 > but usually some hot discussions are needed for the brain to kick
 > into the right gear.

I suspect you are running Samba 2.x, which negotiated all that
multi-byte stuff on the wire. Samba 3.x does the same as windows
servers have done for years and negotiates UCS-2, which means that
every windows box that connects to it no matter what locale it is in
uses the same charset encoding as every other windows box.

There are still some legacy interfaces on the wire that use the old
encodings, but they are rare and getting rarer. To support these,
Samba3 juggles 4 character set encodings internally:

  * the unix-charset, which it uses to talk to the OS, and defaults to
    UTF-8

  * the windows wire charset, which is always UCS-2

  * the dos-charset for legacy parts of the protocol, which you have
    to configure in the samba config if you care about these legacy
    parts of the protocol (for example if you have older apps). It
    defaults to either CP850 or ASCII depending on what autoconf
    discovers. 

  * the display-charset which is used to put stuff on an admins
    terminal for utilities like smbclient. The default depends on your
    LOCALE setting, or if nothing is set it uses ASCII.

Internally Samba3 only ever stores stuff in the "unix-charset"
encoding, which is usually UTF-8. It converts to the others as needed
when talking on the wire or to terminals.

 > I want to switch to UTF-8 to work better with the outside world,
 > but as things are people will start to take notice of what OS is
 > running in the shadows when they see the filename problems, and
 > start demanding Windows, and ...  You see; I'm not mean; I don't
 > want to do that to them (or myself),

If you use Samba3 then they will not notice what charset you are using
on your Linux filesystems. The windows clients will just see UCS-2.

Cheers, Tridge
