Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVKTXHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVKTXHT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVKTXHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:07:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39902 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932105AbVKTXHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:07:17 -0500
Date: Sun, 20 Nov 2005 23:07:14 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: "David S. Miller" <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
Message-ID: <20051120230714.GD27946@ftp.linux.org.uk>
References: <437E7ADB.5080200@shadowconnect.com> <20051118.172230.126076770.davem@davemloft.net> <1132371039.5238.14.camel@localhost.localdomain> <20051118.203707.129707514.davem@davemloft.net> <4380EDB1.1080308@shadowconnect.com> <20051120225256.GC27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120225256.GC27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	And here's another fun one:
                evt->size = size;
                evt->tcntxt = le32_to_cpu(msg->u.s.tcntxt);
                evt->event_indicator = le32_to_cpu(msg->body[0]);
                memcpy(&evt->tcntxt, &msg->u.s.tcntxt, size * 4);
in i2o_driver_dispatch().

We have
struct i2o_event {
        struct work_struct work;
        struct i2o_device *i2o_dev;     /* I2O device pointer from which the
                                           event reply was initiated */
        u16 size;               /* Size of data in 32-bit words */
        u32 tcntxt;             /* Transaction context used at
                                   registration */
        u32 event_indicator;    /* Event indicator from reply */
        u32 data[0];            /* Event data from reply */
};

and
in msg tcntxt goes right before body[0].  So we copy two 32bit values
converting to host order and then immediately overwrite them with
unconverted ones.

Looks like these assignments were meant to go *after* memcpy() and
serve as a fixup...
