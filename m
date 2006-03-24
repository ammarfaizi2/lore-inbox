Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWCXTNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWCXTNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWCXTNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:13:25 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:7326 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964791AbWCXTNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:13:24 -0500
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time
	through fs-wide dirty bit]
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Valerie Henson <val_henson@linux.intel.com>, pbadari@gmail.com,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
       arjan@linux.intel.com, tytso@mit.edu, zach.brown@oracle.com
In-Reply-To: <20060324104818.0016c2f2.akpm@osdl.org>
References: <20060322011034.GP12571@goober>
	 <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com>
	 <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org>
	 <20060324143239.GB14508@goober>  <20060324104818.0016c2f2.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 24 Mar 2006 11:13:19 -0800
Message-Id: <1143227599.4561.139.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 10:48 -0800, Andrew Morton wrote:
> Valerie Henson <val_henson@linux.intel.com> wrote:
> >
> > On Wed, Mar 22, 2006 at 05:55:03PM -0800, Andrew Morton wrote:
> > > Valerie Henson <val_henson@linux.intel.com> wrote:
> > > > 
> > > > ext2 is simpler and faster than ext3 in many cases.  This is sort of
> > > > cheating; ext2 is simpler and faster because it makes no effort to
> > > > maintain on-disk consistency and can skip annoying things like, oh,
> > > > reserving space in the journal.  I am looking for ways to make ext2
> > > > cheat even more.
> > > > 
> > > 
> > > But it might be feasible to knock up an ext3-- in which all the journal
> > > operations are stubbed out.
> > 
> > Hmm... Could we get the mark_buffer_dirty/mark_inode_dirty logic
> > right?
> 
> All things are possible ;) One might add a new
> ext3_minus_minus_mark_buffer_dirty(), for example, put that in all the
> right places.
> 
> >  Probably create a list in the stubbed journal functions and
> > then mark them dirty in the journal close?  However, half the reason
> > I'm working on ext2 is the simplicity of the code - stubbing it out
> > would solve the performance problem but not the complexity problem.
> 
> Well ext3-- won't do anything to simplify the ext3 codebase.  It was just a
> thought..
> 
> > Note that ext3's habit of clearing indirect blocks on truncate would
> > break some things I want to do in the future. (Insert secret plans
> > here.)
> 
> Ah.  I guess one would need to port the ext2 truncate code.
> 
> 

There are reasons for zeroing indirect blocks on truncate: 

      * There are limits to the size of a single journal transaction
        (1/4 of the journal size). When truncating a large fragmented
        file, it may require modifying so many block bitmaps and group
        descriptors that it forces a journal transaction to close out,
        stalling the unlink operation.
      * Because of this per-transaction limit, truncate needs to zero
        the [dt]indirect blocks starting from the end of the file, in
        case it needs to start a new transaction in the middle of the
        truncate (ext3 guarantees that a partially-completed truncate
        will be consistent/completed after a crash).
      * The read/write of the file's [dt]indirect blocks from the end of
        the file to the beginning can take a lot of time, as it does
        this in single-block chunks and the blocks are not contiguous.
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

