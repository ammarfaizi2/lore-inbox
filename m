Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUHQLxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUHQLxJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUHQLxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:53:09 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:52485 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261711AbUHQLxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:53:05 -0400
Date: Tue, 17 Aug 2004 12:53:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Warren Togami <wtogami@redhat.com>
Cc: linux-kernel@vger.kernel.org, Markus.Lidel@shadowconnect.com
Subject: Re: Merge I2O patches from -mm
Message-ID: <20040817125303.A21238@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Warren Togami <wtogami@redhat.com>, linux-kernel@vger.kernel.org,
	Markus.Lidel@shadowconnect.com
References: <411F37CC.3020909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <411F37CC.3020909@redhat.com>; from wtogami@redhat.com on Sun, Aug 15, 2004 at 12:15:40AM -1000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 12:15:40AM -1000, Warren Togami wrote:
> This is a request to please merge the I2O patches currently in Andrew 
> Morton's -mm tree into the mainline kernel.  They resolve all known 
> reported issues with I2O RAID devices.  If they can be included soon, it 
> would be possible to implement and test direct installation before FC3 
> Test2 freeze.

I've looked over it and except for the i2o_scsi driver it looks sane.

Cosmetic fixups I'd like to see done befoee merging to mainline:

 - run the code through Lindent
 - stop the needless file renaming.  Splitting up i2o_core.c into multiple
   files is fine, but please don' rename the other drivers for the sake of
   it

Now to i2o_scsi:

 - the logic of "demand-allocating" Scsi_Hosts looks rather bad to me,
   life would be much simpler with a Scsi_Host per i2o device.
 - the slave_configure/i2o_scsi_probe_dev logical is quite horriblebut
   fortunately with the suggestion above it would just go away
 - the global list of hosts and wlaking it on exit is a very bad design,
   that's something the ->remove callback should do on per-device basis
 - the completely lack of SCSI EH in this driver scares me, does the firmware
   really handle all EH?

cosemtic stuff in here:

 - <asm/*.h> after <linux/*.h>.
 - please include scsi headers using <scsi/*.h> (after linux and asm headers)
 - please use the standard pr_Debug instead of DBG
 - please reorder the functions a little so you don't need forward-declarations

