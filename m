Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbUKROHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbUKROHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUKROHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:07:10 -0500
Received: from THUNK.ORG ([69.25.196.29]:28121 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261776AbUKROHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:07:03 -0500
Date: Thu, 18 Nov 2004 09:06:45 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       r6144 <rainy6144@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       phillips@istop.com, Alex Tomas <alex@clusterfs.com>,
       Christopher Li <chrisl@vmware.com>,
       Christopher Li <ext2-devel@chrisli.org>
Subject: Re: Fw: [POSSIBLE-BUG] telldir() broken on ext3 dir_index'd directories just after the first entry.
Message-ID: <20041118140645.GA5306@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@osdl.org>, r6144 <rainy6144@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	phillips@istop.com, Alex Tomas <alex@clusterfs.com>,
	Christopher Li <chrisl@vmware.com>,
	Christopher Li <ext2-devel@chrisli.org>
References: <20041116183813.11cbf280.akpm@osdl.org> <20041117223436.GB5334@thunk.org> <1100736003.11047.14.camel@sisko.sctweedie.blueyonder.co.uk> <20041118045336.GA5236@thunk.org> <Pine.LNX.4.53.0411181221360.12219@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411181221360.12219@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 12:22:38PM +0100, Jan Engelhardt wrote:
> >So instead what we need to do is wire '.' and '..' to have hash values
> >of (0,0) and (2,0), respectively, without ignoring other existing
> >dirents with colliding hashes.  (In those cases the programs will
> >break, but they are statistically rare, and there's not much we can do
> >in those cases anyway.)
> 
> IMO it's better to fix the mess all at once to have it weeded out for some
> months.

Programs that assume that '.' and '..' are the first and second
entries of a directory are intrinsically broken; POSIX never
guaranteed this to be the case.  Unfortunately, historically things
have always worked that way, and so there may be some broken programs
lurking out there.  But there's really not much we can do.

Before, we hard-wired '.' and '..' to always be first, at the cost of
breaking programs that used the (broken by design) POSIX
telldir/seekdir interfaces.  Since telldir/seekdir, however badly
designed, are part of POSIX, it seems appropriate to let those
programs work, but the cost is a statistical probability that programs
making assumptions about the order of '.' and '..' will break.  We
don't really have a choice here.  

(Actually, I guess we could define a new hash function that never
produces certain hash values, but that would break compatibility with
all existing deployed filesystems that use ext3 htree.  That's not an
option, either.  So again, making a best effort, but breaking programs
that are fundamentally broken is the best we can do.)

						- Ted
