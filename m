Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbTEMQlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbTEMQlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:41:10 -0400
Received: from pat.uio.no ([129.240.130.16]:2695 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262144AbTEMQlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:41:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.8979.48898.341246@charged.uio.no>
Date: Tue, 13 May 2003 18:53:39 +0200
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
In-Reply-To: <79170000.1052844307@baldur.austin.ibm.com>
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
	<shswugvjcy9.fsf@charged.uio.no>
	<20030513135756.GA676@suse.de>
	<16065.3159.768256.81302@charged.uio.no>
	<20030513152228.GA4388@suse.de>
	<16065.4109.129542.777460@charged.uio.no>
	<20030513154741.GA4511@suse.de>
	<16065.5911.55131.430734@charged.uio.no>
	<20030513160948.GA6594@suse.de>
	<16065.7415.189762.803068@charged.uio.no>
	<79170000.1052844307@baldur.austin.ibm.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave McCracken <dmccr@us.ibm.com> writes:

     > I'm in the process of quantifying a big race condition in
     > vmtruncate().  The scenario for the race is this:

     > * Task 1 truncates the file, which resets the size and calls
     >   vmtruncate().

     > * Task 1 in vmtruncate() walks all vmas for the file and unmaps
     >   pages from
     > the truncated file region.

     > * Task 2 then extends the file and faults pages back in.

     > * Task 1 (still in vmtruncate()) removes pages including the
     >   newly remapped
     > pages from the page cache using the original truncated size.

The scenario I'm thinking about is different and can be triggered on a
single process.

The dirty pages are failing to be written out because
they've been swapped out. We then try to do an RPC call to the server
to get it to truncate the file on its side.
Meanwhile one or more of the swapped out pages are faulted in, and
attempted written out. -> race...

Note that we do the vmtruncate() *after* the RPC call (since we cannot
predict whether or not the server will agree to our request) however
actually moving the vmtruncate() to before the RPC call does not
appear to fix the problem.

Cheers,
  Trond
