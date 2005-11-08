Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVKHVrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVKHVrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVKHVrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:47:15 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:6879 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965037AbVKHVrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:47:14 -0500
Subject: Re: oops with USB Storage on 2.6.14
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: "goggin, edward" <egoggin@emc.com>,
       "'Rolf Eike Beer'" <eike-kernel@sf-tec.de>,
       "'Andrew Morton'" <akpm@osdl.org>,
       Masanari Iida <standby24x7@gmail.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org
In-Reply-To: <20051108213306.GA25219@us.ibm.com>
References: <C2EEB4E538D3DC48BF57F391F422779321ADC0@srmanning.eng.emc.com>
	 <1131484123.3270.36.camel@mulgrave>  <20051108213306.GA25219@us.ibm.com>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 16:45:54 -0500
Message-Id: <1131486354.3270.42.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 13:33 -0800, Patrick Mansfield wrote:
> I mean we get a ref to the sdev in the upper level driver opens, scan, and
> sd flush. So where are we not getting a ref? 
> 
> Shouldn't the get be done at a higher level?

Actually, no, because of the way we run the queues for the next command.

If this is a sd_sync_cache() or something for the last possible command
on the device, the process may have a reference to the device, but as
soon as we call end_that_request_last(), they may be racing to release
it.  The bug is triggered when we get into scsi_next_command() with us
holding the only remaining reference to the device.

James


