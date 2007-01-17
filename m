Return-Path: <linux-kernel-owner+w=401wt.eu-S1751018AbXAQX44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbXAQX44 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 18:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXAQX44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 18:56:56 -0500
Received: from mail.apcon.com ([66.213.199.210]:29838 "EHLO mail.apcon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbXAQX44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 18:56:56 -0500
Subject: A question about break and sysrq on a serial console (2.6.19.1)
From: Brian Beattie <brianb@apcon.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: APCON, Inc.
Date: Wed, 17 Jan 2007 15:56:54 -0800
Message-Id: <1169078214.16802.17.camel@brianb>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2007 23:57:08.0853 (UTC) FILETIME=[32B2CA50:01C73A93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to do a SYSRQ over a serial console.  As I understand it a
break will do that, but I'm not seeing the SYSRQ.  In looking at
uart_handle_break() in drivers/serial/8250.c it looks like the code will
toggle port->sysrq, rather than just setting it when the port is a
console.  I think the correct code would be to move the "port->sysrq =
0;" to follow the closing brace on the next line, or am I missing
something.

--------------
/*
 * We do the SysRQ and SAK checking like this...
 */
static inline int uart_handle_break(struct uart_port *port)
{
    struct uart_info *info = port->info;
#ifdef SUPPORT_SYSRQ
    if (port->cons && port->cons->index == port->line) {
        if (!port->sysrq) {
            port->sysrq = jiffies + HZ*5;
            return 1;
        }
        port->sysrq = 0;
    }
#endif
    if (port->flags & UPF_SAK)
        do_SAK(info->tty);
    return 0;
}
-------------

It seem to me that this code will toggle port->sysrq.
-- 
Brian Beattie
Firmware Engineer
APCON, Inc.
BrianB@apcon.com

