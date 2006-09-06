Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWIFGjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWIFGjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 02:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWIFGjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 02:39:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35539 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751239AbWIFGjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 02:39:48 -0400
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive
	locking detected
From: Arjan van de Ven <arjan@infradead.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 06 Sep 2006 08:39:24 +0200
Message-Id: <1157524765.29093.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 10:37 -0700, Miles Lane wrote:
> ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> ieee1394: Node changed: 0-02:1023 -> 0-01:1023
> ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0080880002103eae]
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.18-rc5-mm1 #2
> ---------------------------------------------
> knodemgrd_0/2321 is trying to acquire lock:
>  (&s->rwsem){----}, at: [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
> 
> but task is already holding lock:
>  (&s->rwsem){----}, at: [<f8959078>] nodemgr_host_thread+0x717/0x883 [ieee1394]


looks like a real bug to me:

nodemgr_node_probe() takes down_read(&class->subsys.rwsem) and then
calls nodemgr_probe_ne() which calls nodemgr_update_pdrv() which does
down_read(&class->subsys.rwsem).

Such recursive taking of rwsems is not allowed (rwsems are fair, if a
write comes in in between then there is a deadlock).


