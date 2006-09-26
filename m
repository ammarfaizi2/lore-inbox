Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWIZTyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWIZTyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWIZTyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:54:50 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:23207 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932247AbWIZTys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:54:48 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Keith Owens <kaos@sgi.com>
Subject: KDB blindly reads keyboard port
Date: Tue, 26 Sep 2006 13:54:30 -0600
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609261354.30722.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

get_kbd_char() in arch/ia64/kdb/kdba_io.c does "inb(KBD_STATUS_REG)".

But we don't know whether there's even an i8042 keyboard controller
present.  On HP ia64 boxes, there is no i8042, and trying to read
from it can cause an MCA.

This depends on the specific platform and how it is configured.  I
observed this MCA while booting the SLES10 install kernel on an
HP rx7620 in "default" acpiconfig mode.  The supported acpiconfig
mode on this box is "single-pci-domain", which also puts some
legacy ports into "soft-fail" mode, where the read will just return
0xff instead of causing an MCA.  But I think it's wrong to blindly
poke around in I/O port space.

i8042_pnp_init() uses PNPACPI to figure out whether the i8042
device is present.  That's probably too heavy-weight for what
you want to do in KDB, though.

Bjorn
