Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVLFMPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVLFMPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVLFMPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:15:09 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:23428 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964958AbVLFMPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:15:08 -0500
Date: Tue, 6 Dec 2005 09:56:10 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-Id: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Greg,

 Don't get scared. :-)

 As showed by Eduardo Habkost some days ago, the spin lock 'lock' in the
struct 'usb_serial_port' is being used by some USB serial drivers to protect
the access to the 'write_urb_busy' member of the same struct.

 The spin lock however, is needless: we can change 'write_urb_busy' type
to be atomic_t and remove all the spin lock usage.

 The following patch series does that. It introduces a very simple URB write
lock abstraction and four macros to do the same job currently done by the
spin lock.

 The final result is a simpler and easy to read/understand code, with no
spin lock at all.

 I've splited the work that way: the frist patch introduces the new macros;
from the second patch until the eight all the drivers are ported; patch
nine removes the 'lock' member from the usb-serial driver and patch ten
adds the write URB lock initialization for all the ports.

 An important note is about the omninet driver. In its omninet_write_room()
method, it's accessing the 'write_urb_busy' member from the 'serial->port[1]'
port, and _not_ from the usb_serial_port passed as its argument. I have no
sure if it is right, but my port does perserve that semantic.

 As I don't have any of the changed drivers, I have only made the compilation
test. Would be good to hold the patches in -mm for a while.

 A final note: all the patches have been made with my usb-serial fixes
(which are already in your tree) applyed. They are:

usbserial-adds-missing-checks-and-bug-fix.patch
usbserial-race-condition-fix.patch

 Thank you,

-- 
Luiz Fernando N. Capitulino
