Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVCIPM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVCIPM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVCIPM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:12:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65423 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261882AbVCIPMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:12:46 -0500
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050309132838.GJ6145@atrey.karlin.mff.cuni.cz>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050304160451.4c33919c.akpm@osdl.org>
	 <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307123118.3a946bc8.akpm@osdl.org>
	 <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1110286417.1941.40.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050308151258.GD23403@atrey.karlin.mff.cuni.cz>
	 <1110373818.1932.31.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050309132838.GJ6145@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110381147.1932.38.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 09 Mar 2005 15:12:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-03-09 at 13:28, Jan Kara wrote:

>   Hmm. I see for example a place at jbd/commit.c, line 287 (which you
> did not change in your patch) which does this and doesn't seem to be
> protected against journal_unmap_buffer() (but maybe I miss something).
> Not that I'd find that race probable but in theory...

Indeed; I can't see why that wouldn't trigger (at least without the
existing, low-risk journal_unmap_buffer() patch.)

Andrew, I think we just go with that simple patch for now --- it catches
the cases we actually see in testing.  And rather than mess with
temporary states where b_transaction goes NULL, I think the *correct*
long-term fix is to hide those states using locking rather than by list
tricks.  Merging the bh_journal_head and bh_state locks really seems
like the safe solution here, as the latter seems to be held nearly
everywhere where we need protection against journal_put_journal_head()
(and where it's not held --- as it wasn't in journal_unmap_buffer() ---
it's a bug.)

--Stephen

