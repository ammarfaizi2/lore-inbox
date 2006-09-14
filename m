Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWINAo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWINAo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 20:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWINAo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 20:44:28 -0400
Received: from twin.jikos.cz ([213.151.79.26]:47746 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751278AbWINAo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 20:44:27 -0400
Date: Thu, 14 Sep 2006 02:44:01 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [PATCH 0/3] Synaptics - fix lockdep warnings 
Message-ID: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following three patches fix two lockdep warnings I am receiving with 
2.6.18-rc6-mm2 (but at least the first one has been already discussed in 
the times of 2.6.17, reported by Dave Jones) and I can see the problem in 
current mainline source too).

* [1/3] fixes this:
 =============================================
 [ INFO: possible recursive locking detected ]
 2.6.18-rc6-mm2-dirty #4
 ---------------------------------------------
 kseriod/140 is trying to acquire lock:
  (&ps2dev->cmd_mutex/1){--..}, at: [<c02b973b>] ps2_command+0x5b/0x3a0

 but task is already holding lock:
  (&ps2dev->cmd_mutex/1){--..}, at: [<c02b973b>] ps2_command+0x5b/0x3a0


* [2/3] adds support for spin_lock_irqsave_nested(), which is needed by 
[3/3]

* [3/3] fixes this:
 =============================================
 [ INFO: possible recursive locking detected ]
 2.6.18-rc6-mm2-dirty #7
 ---------------------------------------------
 swapper/0 is trying to acquire lock:
  (&serio->lock){++..}, at: [<c02b7a20>] serio_interrupt+0x20/0x60

 but task is already holding lock:
  (&serio->lock){++..}, at: [<c02b7a20>] serio_interrupt+0x20/0x60

All three patches are based against 2.6.18-rc6-mm2, I can rebase them 
against mainline, if needed.

Both warnings have been solved by splitting the respective functions to 
nested and non-nested variants, and calling them from synpatics driver as 
appropriate.
 
-- 
JiKos.
