Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262106AbRE3UeQ>; Wed, 30 May 2001 16:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbRE3UeG>; Wed, 30 May 2001 16:34:06 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:22761 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262076AbRE3Ud7>;
	Wed, 30 May 2001 16:33:59 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105302033.NAA07866@csl.Stanford.EDU>
Subject: [CHECKER] new floating point bugs in 2.4.5-ac4
To: linux-kernel@vger.kernel.org
Date: Wed, 30 May 2001 13:33:57 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two new uses of floating point that popped up in the 2.4.5-ac4
kernel.  While the expressions that use FP are trivial, at least my
version of gcc does not calculate them at compile time.

As a bonus, two old, but still existing FP uses are also included.

Dawson
MC linux bug database: http://hands.stanford.edu/linux

############################################################
# New errors.
#
---------------------------------------------------------
[BUG] DMFE_TX_TIMEOUT is HZ * 1.5 which seems easy to fix.

/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/dmfe.c:1112:dmfe_timer: ERROR:FLOAT: cannot use fp in kernel

	if ( db->tx_packet_cnt &&
		((jiffies - dev->trans_start) > DMFE_TX_KICK) ) {
		outl(0x1, dev->base_addr + DCR1);   /* Tx polling again */

		/* TX Timeout */

Error --->
		if ( (jiffies - dev->trans_start) > DMFE_TX_TIMEOUT ) {
---------------------------------------------------------
[BUG] DMFE_TX_KICK is (HZ * 0.5) which gcc does as floating point.  Fix is
	trivial: just divide by 2 instead.
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/dmfe.c:1108:dmfe_timer: ERROR:FLOAT: cannot use fp in kernel

	}
	db->interval_rx_cnt = 0;

	/* TX polling kick monitor */
	if ( db->tx_packet_cnt &&

Error --->
		((jiffies - dev->trans_start) > DMFE_TX_KICK) ) {

############################################################
# Existing, unfixed errors
#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/sgivwfb.c:731:sgivwfb_set_var: ERROR:FLOAT: cannot use fp in kernel

  var->green.msb_right = 0;
  var->blue.msb_right = 0;
  var->transp.msb_right = 0;

  /* set video timing information */

Error --->
  var->pixclock = (__u32)(1.0e+9/(float)timing->cfreq);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/sgivwfb.c:664:sgivwfb_set_var: ERROR:FLOAT: cannot use fp in kernel

    return -EINVAL;             /* Resolution to high */

  /* XXX FIXME - should try to pick best refresh rate */
  /* for now, pick closest dot-clock within 3MHz*/
#error "Floating point not allowed in kernel"  

Error --->
  req_dot = (int)((1.0e3/1.0e6) / (1.0e-12 * (float)var->pixclock));



############################################################
# Old fixed
#
[FIXED] sis_main.c:crtc_to_var:FLOAT: cannot use fp in kerne
/u2/engler/mc/oses/linux/2.4.4/drivers/video/sis/sis_main.c:588:crtc_to_var: ERROR:FLOAT: cannot use fp in kernel
