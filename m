Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWBSGrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWBSGrG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 01:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWBSGrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 01:47:06 -0500
Received: from 69-172-25-214.clvdoh.adelphia.net ([69.172.25.214]:45811 "EHLO
	ever.mine.nu") by vger.kernel.org with ESMTP id S1751077AbWBSGrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 01:47:04 -0500
Date: Sun, 19 Feb 2006 01:46:49 -0500
Message-Id: <200602190646.k1J6knG8012818@rhodes.mine.nu>
To: psusi@cfl.rr.com
CC: linux-kernel@vger.kernel.org
From: linuxer@ever.mine.nu
In-reply-to: <43F80C15.4090409@cfl.rr.com> (message from Phillip Susi on Sun,
	19 Feb 2006 01:11:33 -0500)
Subject: Re: pktcdvd DVD+RW always writes at max drive speed (not media speed)
References: <200602182023.k1IKNNuI012372@rhodes.mine.nu> <43F80C15.4090409@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> wrote:

  > 
  > I thought that the code asked the drive for the max supported speed _for 
  > the loaded media_.  I know I've been using pktcdvd without problem on 
  > cdrw media that is only rated for 4x on drives that support 12x or 16x, 
  > and based on the performance I've been seeing, it is only burning at 4x. 
  >   Maybe your drive isn't reporting properly?
  > 

As I stated clearly before, I am having this problem with DVD+RW media. The
relevant code in pktcdvd.c (in function pkt_open_write) is:

	if ((ret = pkt_get_max_speed(pd, &write_speed)))
		write_speed = 16 * 177;
	switch (pd->mmc3_profile) {
		case 0x13: /* DVD-RW */
		case 0x1a: /* DVD+RW */
		case 0x12: /* DVD-RAM */
			DPRINTK("pktcdvd: write speed %ukB/s\n", write_speed);
			break;
		default:
			if ((ret = pkt_media_speed(pd, &media_write_speed)))
				media_write_speed = 16;
			write_speed = min(write_speed, media_write_speed * 177);
			DPRINTK("pktcdvd: write speed %ux\n", write_speed / 176);
			break;
	}
	read_speed = write_speed;

	if ((ret = pkt_set_speed(pd, write_speed, read_speed))) {
		DPRINTK("pktcdvd: %s couldn't set write speed\n", pd->name);
		return -EIO;
	}

As you can see, in the case of DVD+RW, the speed is set to the value stored
to write_speed by the function pkt_get_max_speed, whose documented purpose
(according to comments) is to return the drives reported maximum rewrite
speed capability. pkt_media_speed is only called in the case of CD-RW's. In
fact, it returns an error if the media is not CD-RW.

