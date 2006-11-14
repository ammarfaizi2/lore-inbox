Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932966AbWKNHjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966AbWKNHjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 02:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWKNHjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 02:39:51 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:54933 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932966AbWKNHjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 02:39:51 -0500
Message-ID: <455972D0.1030407@drzeus.cx>
Date: Tue, 14 Nov 2006 08:40:00 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: device_del() and references
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

I'm trying to wrap my head around the dependencies in the MMC layer and
there are some gaps I am suspicious about. Since you've been looking at
this a lot longer than I have, I thought you could have some valuable
insight.

When a card driver has obtained a reference to a card, what makes sure
we do not destroy that card from under its feet? The reference count on
the device structure in the card only makes sure the structure itself is
in memory, not that the data is valid. E.g. the host might be removed
leaving the host pointer invalid.

I suspect that device_del() doesn't return until remove() has been
called and that our requirement is that the card driver must have
released all references to the card before its remove routine exits.

If so, then there is the risk of a race in mmc_block. What guarantees
that the request handler isn't running in parallel with the remove
function? Again, I suspect that del_gendisk() might grab the queue lock,
but as there might be stuff left in the queue, this seems insufficient.

Perhaps there is a is_gendisk_valid() we can stick at the top of the
request handler?

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
