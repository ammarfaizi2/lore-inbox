Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVKTXWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVKTXWD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVKTXWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:22:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:65228 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932115AbVKTXWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:22:01 -0500
Date: Sun, 20 Nov 2005 23:21:58 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: "David S. Miller" <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
Message-ID: <20051120232158.GE27946@ftp.linux.org.uk>
References: <437E7ADB.5080200@shadowconnect.com> <20051118.172230.126076770.davem@davemloft.net> <1132371039.5238.14.camel@localhost.localdomain> <20051118.203707.129707514.davem@davemloft.net> <4380EDB1.1080308@shadowconnect.com> <20051120225256.GC27946@ftp.linux.org.uk> <20051120230714.GD27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120230714.GD27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 11:07:14PM +0000, Al Viro wrote:
> 	And here's another fun one:
>                 evt->size = size;
>                 evt->tcntxt = le32_to_cpu(msg->u.s.tcntxt);
>                 evt->event_indicator = le32_to_cpu(msg->body[0]);
>                 memcpy(&evt->tcntxt, &msg->u.s.tcntxt, size * 4);
> in i2o_driver_dispatch().

Gaaack...  Old code used to be
                       evt = kmalloc(size * 4 + sizeof(*evt), GFP_ATOMIC);
                       if (!evt)
                               return -ENOMEM;
                       memset(evt, 0, size * 4 + sizeof(*evt));

                       evt->size = size;
                       memcpy_fromio(&evt->tcntxt, &msg->u.s.tcntxt,
                                    (size + 2) * 4);

Then it became
               evt->size = size;
               evt->tcntxt = readl(&msg->u.s.tcntxt);
               evt->event_indicator = readl(&msg->body[0]);
               memcpy_fromio(&evt->tcntxt, &msg->u.s.tcntxt, size * 4);

See the problem with it?  The last copy should be from &msg->body[1] to
evt->data.  As it is, we do not copy the last 8 bytes (which might or
might not be a problem) *AND* we overwrite tcntxt and event_indicator
with bus-endian values right after having host-endian ones carefully
assigned to them.

Breakage happened in
diff-tree 61fbfa8129c1771061a0e9f47747854293081c5b (from 34d6e07570ef74b96513145
Author: Markus Lidel <Markus.Lidel@shadowconnect.com>
Date:   Thu Jun 23 22:02:11 2005 -0700

    [PATCH] I2O: bugfixes and compability enhancements

