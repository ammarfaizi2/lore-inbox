Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbUKPXBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUKPXBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUKPW7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:59:50 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:43206 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261880AbUKPW5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:57:11 -0500
Date: Tue, 16 Nov 2004 17:56:58 -0500
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kai Makisara <Kai.Makisara@metla.fi>, Willem Riede <osst@riede.org>,
       coda@cs.cmu.edu, Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 0/4] Cleanup file_count usage
Message-ID: <20041116225658.GA1341@delft.aura.cs.cmu.edu>
Mail-Followup-To: Ravikiran G Thirumalai <kiran@in.ibm.com>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Kai Makisara <Kai.Makisara@metla.fi>, Willem Riede <osst@riede.org>,
	coda@cs.cmu.edu, Paul Mackerras <paulus@samba.org>
References: <20041116135200.GA23257@impedimenta.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116135200.GA23257@impedimenta.in.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 07:22:00PM +0530, Ravikiran G Thirumalai wrote:
> What remains:
> 1. Hack to return error code to user space at last close through file_count
>    check at the driver's flush routine.  This hack is used in scsi/st.c,
>    scsi/osst.c and coda/file.c to return error code through .flush() 
>    (Although it is doubtful if applications check for error during close(2)).
>    Kai has a patch to cleanup scsi/st.c.  I will make patches to move last 
>    close code from .flush() to .release() in the coda filesystem if no one 
>    objects to it.  Not sure if you can do anything on errors at close...

That won't work, in fops_release it is far too late to pass error codes
back to the application that called close(2).

In fact Coda used to only have a CODA_CLOSE upcall in coda_release until
users noticed that they never got an error return when the final write
to the servers failed. The only solution was to split the store and
release functionality of CODA_CLOSE so that we can perform the writeback
to the servers during the fops_flush operation (CODA_SYNC) and release
the last reference to the object during fops_release (CODA_RELEASE). If
either of these upcalls fails we fall back on the old behaviour.

People who write application with Coda in mind actually do check for
errors at close, it is the only time that we can actually generate any
errors as individual writes are not visible to the cache manager.

Do you have a link to the original discussion, what problem are we
trying to solve here?

Jan
