Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbTEAOVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTEAOVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:21:06 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:51460 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261275AbTEAOVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:21:06 -0400
Date: Thu, 1 May 2003 15:33:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
Message-ID: <20030501153325.A15458@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030429155731.07811707.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030429155731.07811707.akpm@digeo.com>; from akpm@digeo.com on Tue, Apr 29, 2003 at 03:57:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/

 - large parts of the locking are hosed or not existant
      o shost->my_devices isn't locked down at all
      o the host list ist locked but not refcounted, mess can
         happen when the spinlock is dropped
      o there are lots of members of struct Scsi_Host/scsi_device/scsi_cmnd
        with very unclear locking, many of them probably want to become
	atomic_t's or bitmaps (for the 1bit bitfields).
      o there's lots of volatile abuse in the scsi code that needs to
        be thought about.
      o there's some global variables incremented without any locks

fs/devfs/

 - there's a fundamental lookup vs devfsd race that's only fixable
   by introducing a lookup vs devfs deadlock.  I can't see how this
   is fixable without getting rid of the current devfsd design.
   Mandrake seems to have a workaround for this so this is at least
   not triggered so easily, but that's not what I'd considere a fix..
