Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVAXS5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVAXS5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVAXS5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:57:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26047 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261566AbVAXS46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:56:58 -0500
Subject: Re: [Ext2-devel] [PATCH] JBD: log space management optimization
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: Stephen Tweedie <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <m3llapv3i7.fsf@bzzz.home.net>
References: <m3llapv3i7.fsf@bzzz.home.net>
Content-Type: text/plain
Message-Id: <1106593003.2103.147.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 24 Jan 2005 18:56:44 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-01-19 at 15:32, Alex Tomas wrote:

> during truncate ext3 calls journal_forget() for freed blocks, but
> before these blocks go to the transaction and jbd reserves space
> in log for them (->t_outstanding_credits). also, journal_forget()
> removes these blocks from the transaction, but doesn't correct
> log space reservation. for example, removal of 500MB file reserves
> 136 blocks, but only 10 blocks go to the log. a commit is expensive
> and correct reservation allows us to avoid needless commits. here
> is the patch. tested on UP.

Looks like a good approach to me, but would it not be better to return
the credits to the handle instead of to the transaction?

A really large truncate will typically be getting a bunch of credits,
using those up and then extending itself continually as it encounters
more and more indirect blocks.

With your patch, the extended credits that the handle obtained will be
returned to the transaction, effectively shrinking the transaction again
and forcing the handle to extend itself yet again as it continues.  If
you returned them to the handle directly, it would be slightly more
efficient.

ACK either way, though --- the patch you've got now does look correct as
it stands.

Cheers,
 Stephen


