Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992710AbWJTSzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992710AbWJTSzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992709AbWJTSzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:55:41 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:2259 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S2992706AbWJTSzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:55:39 -0400
Date: Fri, 20 Oct 2006 11:55:22 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: + fs-prepare_write-fixes.patch added to -mm tree
Message-ID: <20061020185522.GG10128@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <200610182150.k9ILoLNk019702@shell0.pdx.osdl.net> <20061019014209.GA10128@ca-server1.us.oracle.com> <20061019052537.GA15687@wotan.suse.de> <20061019230900.GE10128@ca-server1.us.oracle.com> <453809C6.20708@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453809C6.20708@yahoo.com.au>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 09:27:02AM +1000, Nick Piggin wrote:
> >Cool, I appreciate that.
> 
> OK, I will be posting that mail tomorrow or next day... I'll summarise
> your concerns you've posted in this thread too.
Thanks.


> zeroing out the hole and marking it uptodate in case of a 0 length
> ->commit_write does sound like the right way to go. I probably haven't
> handled that correctly if it needs to be done in ext? or generic fs/
> routines...
I *think* we want to handle this in generic_file_buffered_write(). Between
->prepare_write() and ->commit_write(). Here's what I'm thinking:

generic_file_buffered_write() notices that it got a short copy from
copy_from_user_inatomic(). It can then call a helper which walks the buffer
heads attached to the page looking for BH_New regions which haven't been
written to yet. It can then zero those out. We pass the normal from/to
arguments over to ->commit_write() and those callbacks don't have to change
- they just continue as usual. The newly allocated regions get written out,
filling the holes with valid data and we avoid returning garbage from disk
on subsequent reads.

Ideas? "Holes" in the design? :)
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
