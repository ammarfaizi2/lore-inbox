Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbWALA1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbWALA1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbWALA1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:27:21 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:25529
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932674AbWALA1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:27:19 -0500
Subject: Re: [PATCH] new tty buffering access fix
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20060111160823.6bc95ab8.akpm@osdl.org>
References: <1137023508.3113.10.camel@x2.pipehead.org>
	 <20060111160823.6bc95ab8.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 18:27:12 -0600
Message-Id: <1137025632.3113.18.camel@x2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 16:08 -0800, Andrew Morton wrote:
> Curious.  How did this manage to sneak through without anyone noticing? 
> Does tty_buffer_request_room() mostly work, or do only rarely-used drivers
> use it, or what?

At common speeds you never have more than one
buffer on the queue when the function in question is called.
So looking at the head is the same as looking at the tail.

In my recent testing, I cranked the speed up and at 460800bps
the queue became corrupted when more than one buffer was pending.
This is the important part of the patch.

With this patch, I've been running multiple devices (synclink_gt)
simultaneously on an SMP machine from 38400bps to 921600bps and
the new buffering is solid.

The part of the patch in flush_to_ldisc closes a tiny hole
where an ISR might access the queue tail after flush_to_ldisc
has removed it from the queue.

-- 
Paul Fulghum
Microgate Systems, Ltd

