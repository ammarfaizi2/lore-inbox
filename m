Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbTHVAkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbTHVAkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:40:31 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:11528
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262967AbTHVAk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:40:29 -0400
Date: Thu, 21 Aug 2003 17:40:28 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: vijayan prabhakaran <pvijayan@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read in ext3
Message-ID: <20030822004028.GE1040@matchmail.com>
Mail-Followup-To: vijayan prabhakaran <pvijayan@rediffmail.com>,
	linux-kernel@vger.kernel.org
References: <20030822000926.17486.qmail@webmail6.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822000926.17486.qmail@webmail6.rediffmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 12:09:26AM -0000, vijayan prabhakaran wrote:
> 
> Hi,
> 
> I have a doubt on how ext3 handles read in this specific case.
> 
> Assume that a page is written to the journal but not yet updated
> to its actual location and before updating the actual copy the 
> page
> gets invalidated. Now if a read comes to the same
> data, which block will be read: the journal copy or the actual
> copy ?
> 
> First of all, will this situation ever occur ? The page will be
> marked dirty until it is written to its actual location so it 
> may
> never get invalidated until it is written to the actual
> location!

The page will be in memory until the transaction has finished.  The
transaction won't finish until it has been moved from the journal to its
final location on disk.

Once that has happened the page can be freed.  Now, if the page is
invalidated in the middle of the transaction, all future accesses will come
from memory until that page is flushed, or cleaned.

IIUC, ext3 never reads from the journal (unless you're doing a recovery).
The journal just shows on disk what is already in memory so it can be
recovered after an abnormal shutdown.
