Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTEMQcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTEMQcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:32:51 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:56534 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S261921AbTEMQct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:32:49 -0400
Date: Tue, 13 May 2003 11:45:07 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: trond.myklebust@fys.uio.no, Dave Jones <davej@codemonkey.org.uk>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <79170000.1052844307@baldur.austin.ibm.com>
In-Reply-To: <16065.7415.189762.803068@charged.uio.no>
References: <20030512155417.67a9fdec.akpm@digeo.com>
 <20030512155511.21fb1652.akpm@digeo.com><shswugvjcy9.fsf@charged.uio.no>
 <20030513135756.GA676@suse.de><16065.3159.768256.81302@charged.uio.no>
 <20030513152228.GA4388@suse.de><16065.4109.129542.777460@charged.uio.no>
 <20030513154741.GA4511@suse.de><16065.5911.55131.430734@charged.uio.no>
 <20030513160948.GA6594@suse.de> <16065.7415.189762.803068@charged.uio.no>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, May 13, 2003 18:27:35 +0200 Trond Myklebust
<trond.myklebust@fys.uio.no> wrote:

> Ah... mmap()ed writes + truncate()...
> 
> OK. There's currently a known problem here which appears both in 2.4.x
> and 2.5.x: we appear to be incapable of flushing out all the dirty
> pages prior to truncating the file. The usual
> filemap_fdatasync()/filemap_fdatawait() appears to be subject to races
> with VM swapping.
> 
> Could we have some help from the VM experts on this one?

I'm in the process of quantifying a big race condition in vmtruncate().
The scenario for the race is this:

* Task 1 truncates the file, which resets the size and calls vmtruncate().

* Task 1 in vmtruncate() walks all vmas for the file and unmaps pages from
the truncated file region.

* Task 2 then extends the file and faults pages back in.

* Task 1 (still in vmtruncate()) removes pages including the newly remapped
pages from the page cache using the original truncated size.

We now have mapped and dirty pages that do not belong to any page cache and
will not be written back to the file.  All subsequent data written via the
mapped pages will be lost.

I don't have a solution for it yet.  I've just gotten as far as identifying
out the race.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

