Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbSJAK2m>; Tue, 1 Oct 2002 06:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSJAK2m>; Tue, 1 Oct 2002 06:28:42 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:8201 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S261576AbSJAK2k>; Tue, 1 Oct 2002 06:28:40 -0400
Date: Tue, 1 Oct 2002 12:37:42 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: linux-kernel@vger.kernel.org
cc: Greg KH <greg@kroah.com>
Subject: calling context when writing to tty_driver
Message-ID: <Pine.LNX.4.21.0210010523290.485-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

just hitting another "sleeping on semaphore from illegal context" issue
with 2.5.39. Happened on down() in either usbserial->write_room() or
usbserial->write(), when invoked from bh context.

Some grepping reveals no documentation of calling context requirements
for those driver calls and existing serial code seems to be happy with bh
context. Therefore I'm wondering whether it is permitted to call from
don't-sleep context?

Since write_room() is usually called immediately before write()'ing stuff
to the driver it would be a good idea to keep them both callable from bh,
IMHO. For example tty_ldisc->write_wakeup() might probably want to issue
write_room() followed by write().

Currently, usbserial calls write_wakeup() from bh (on OUT urb completion)
but needs process context for write_room() and write(). My impression is
the whole point of write_room() is to find out how many data can be
accepted by the write() - if write() would be allowed to sleep it could
just block to deal with any amount of data.

TIA for any insight.

Martin

